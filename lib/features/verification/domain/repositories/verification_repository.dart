import 'package:dartz/dartz.dart';
import 'package:incetro_test/res/failures/failure.dart';
import 'package:incetro_test/features/verification/domain/entities/verification_request.dart';
import 'package:incetro_test/features/verification/domain/entities/verification_response.dart';

abstract class VerificationRepository {
  Future<Either<Failure, VerificationResponse>> sendCode(VerificationRequest request);
}