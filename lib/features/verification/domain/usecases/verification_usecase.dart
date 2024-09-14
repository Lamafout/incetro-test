import 'package:dartz/dartz.dart';
import 'package:incetro_test/res/failures/failure.dart';
import 'package:incetro_test/features/verification/domain/entities/verification_request.dart';
import 'package:incetro_test/features/verification/domain/entities/verification_response.dart';
import 'package:incetro_test/features/verification/domain/repositories/verification_repository.dart';

class VerificationUsecase {
  final VerificationRepository verificationRepository;
  late VerificationRequest verificationRequest;
  setCode(String verificationCode) {
    verificationRequest = VerificationRequest(verificationCode: verificationCode);
  }

  VerificationUsecase(this.verificationRepository);
  Future<Either<Failure, VerificationResponse>> execute(String verificationCode) async{
    setCode(verificationCode);
    final response = await verificationRepository.sendCode(verificationRequest);
    return response.fold(
      (failure) => Left(failure),
      (success) => Right(success)
    );
  }
}