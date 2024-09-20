import 'package:dartz/dartz.dart';
import 'package:incetro_test/features/like/data/models/like_response_model.dart';
import 'package:incetro_test/features/like/data/sources/like_local_source.dart';
import 'package:incetro_test/features/like/data/sources/like_remote_source.dart';
import 'package:incetro_test/features/like/domain/entities/like_response.dart';
import 'package:incetro_test/features/like/domain/repositories/like_repository.dart';
import 'package:incetro_test/res/failures/failure.dart';

class LikeRepositoryImpl implements LikeRepository {
  final LikeLocalSource likeLocalSource;
  final LikeRemoteSource likeRemoteSource;

  LikeRepositoryImpl({required this.likeLocalSource, required this.likeRemoteSource});

  @override
  Future<Either<Failure, LikeResponse>> like(int id) async {
    final accessToken = await likeLocalSource.getToken('access');
    try {
      final response = await likeRemoteSource.postLike(id, accessToken as String);
      response.setStatus('liked');
      return Right(response.toEntity());
    } on IncorrectTokenException {
      final refreshToken = await likeLocalSource.getToken('refresh'); 
      final newTokens = await likeRemoteSource.updateToken(accessToken as String, refreshToken as String);
      await likeLocalSource.setToken('access', newTokens['access_token'] as String);
      await likeLocalSource.setToken('refresh', newTokens['refresh_token'] as String);
      try {
        final newResponse = await likeRemoteSource.postLike(id, newTokens['access_token'] as String);
        newResponse.setStatus('liked');
        return Right(newResponse.toEntity());
      } on IsAlreadyLikedException {
        try {
          await likeRemoteSource.deleteLike(id, newTokens['access'] as String);
          final result = LikeResponseModel(id: id, user: null, organization: null);
          result.setStatus('deleted');
          return Right(result.toEntity());
        } on BadRequestException catch(e){
          return Left(IncorrectCodeFailure(e.toString()));
        } on Exception catch (e) {
          return Left(NoInternetFailure(e.toString()));
        }
      } on Exception {
        return Left(NoInternetFailure('Check your connection and retry'));
      }
    } on IsAlreadyLikedException {
      try {
        await likeRemoteSource.deleteLike(id, accessToken as String);
        final result = LikeResponseModel(id: id, user: null, organization: null);
        result.setStatus('deleted');
        return Right(result.toEntity());
      } on BadRequestException catch(e){
        return Left(IncorrectCodeFailure(e.toString()));
      } on Exception catch (e) {
        return Left(NoInternetFailure(e.toString()));
      }
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}