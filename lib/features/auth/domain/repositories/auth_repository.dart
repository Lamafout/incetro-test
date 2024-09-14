import 'package:dartz/dartz.dart';
import 'package:incetro_test/res/failures/failure.dart';
import 'package:incetro_test/features/auth/domain/entities/organisations.dart';

abstract class AuthRepository{
  Future<Either<Failure, Organisations>> signIn();
  Future<Either<Failure, Organisations>> getDemo();
  Future <Either<Failure, Map<String, String>>> updateTokens();
}