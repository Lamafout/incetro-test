import 'package:dartz/dartz.dart';
import 'package:incetro_test/features/verification/data/models/verification_request_model.dart';
import 'package:incetro_test/features/verification/data/sources/verification_local_source.dart';
import 'package:incetro_test/features/verification/data/sources/verification_remote_source.dart';
import 'package:incetro_test/features/verification/domain/entities/verification_request.dart';
import 'package:incetro_test/features/verification/domain/entities/verification_response.dart';
import 'package:incetro_test/features/verification/domain/repositories/verification_repository.dart';
import 'package:incetro_test/res/failures/failure.dart';

class VerificationRepositoryImpl implements VerificationRepository {
  final VerificationRemoteSource verificationRemoteSource;
  final VerificationLocalSource verificationLocalSource;
  VerificationRepositoryImpl({required this.verificationLocalSource, required this.verificationRemoteSource});

  @override
  Future<Either<Failure, VerificationResponse>> sendCode(VerificationRequest requestEntity) async {
    final request = VerificationRequestModel.fromEntity(requestEntity);
    await request.setEmail(await verificationLocalSource.getEmail());
    try{
      final response = await verificationRemoteSource.sendCode(request);
      verificationLocalSource.setToken('access', response.accessToken);
      verificationLocalSource.setToken('refresh', response.refreshToken);
      return Right(response.toEntity());
    } on BadRequestException{
      return Left(IncorrectCodeFailure('Check your email and retry'));
    } on Exception{
      return Left(NoInternetFailure('Check your connection and retry'));
    }
  }
}