import 'package:dartz/dartz.dart';
import 'package:incetro_test/features/auth/data/sources/auth_local_source.dart';
import 'package:incetro_test/features/auth/data/sources/auth_remote_source.dart';
import 'package:incetro_test/res/failures/failure.dart';
import 'package:incetro_test/features/auth/domain/entities/organisations.dart';
import 'package:incetro_test/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final LocalSourceAuth localSource;
  final RemoteSourceAuth remoteSource;
  AuthRepositoryImpl({required this.localSource, required this.remoteSource});

  @override
  Future<Either<Failure, Organisations>> signIn() async {
    final accessToken = await localSource.getToken('access');
    final refreshToken = await localSource.getToken('refresh');
    if (accessToken!= null && refreshToken!= null) {
      try{
        final response = await remoteSource.getOrganisations(accessToken);
        return Right(response.toEntity());
      }
      catch(e){
        return Left(NoInternetFailure('Check connection and retry'));
      }
    }
    else{
      return Left(NoTokenFailure('Local user'));
    }
  }

  @override
  Future<Either<Failure, Organisations>> getDemo() async {
    try{
      final response = await remoteSource.getOrganisationsDemo();
      return Right(response.toEntityDemo());
    }
    catch(e){
      return Left(NoInternetFailure('Check your connection and retry'));
    }
  }

  @override
  Future<Either<Failure, Map<String, String>>> updateTokens() async {
    final oldAccessToken = await localSource.getToken('access');
    final oldRefreshToken = await localSource.getToken('refresh');
    try{
      final response = await remoteSource.updateToken(oldAccessToken as String, oldRefreshToken as String);
      localSource.setToken('access', response['access_token'] as String);
      localSource.setToken('refresh', response['refresh_token'] as String);
      return Right(response);
    }
    catch(e){
      return Left(NoInternetFailure('Check your connection and retry'));
    }
  }
}