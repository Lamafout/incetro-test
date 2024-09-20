import 'package:dartz/dartz.dart';
import 'package:incetro_test/features/like/domain/entities/like_response.dart';
import 'package:incetro_test/res/failures/failure.dart';

abstract class LikeRepository{
  Future<Either<Failure, LikeResponse>> like(int id);
}