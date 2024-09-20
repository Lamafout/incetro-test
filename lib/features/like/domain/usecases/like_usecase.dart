import 'package:dartz/dartz.dart';
import 'package:incetro_test/features/like/domain/entities/like_response.dart';
import 'package:incetro_test/features/like/domain/repositories/like_repository.dart';
import 'package:incetro_test/res/failures/failure.dart';

class LikeUsecase {
  final LikeRepository likeRepository;
  late int organisationId;
  setOrganisationId(int id){
    organisationId = id;
  }
  LikeUsecase(this.likeRepository); 

  Future<Either<Failure, LikeResponse>> tapOnLikeButton() async{
    var result = await likeRepository.like(organisationId);
    return result.fold(
      (failure) => Left(failure),
      (success) => Right(success)
    );
  }
}