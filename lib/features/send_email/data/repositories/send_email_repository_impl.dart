import 'package:dartz/dartz.dart';
import 'package:incetro_test/features/auth/domain/entities/failure.dart';
import 'package:incetro_test/features/send_email/data/models/send_email_model.dart';
import 'package:incetro_test/features/send_email/data/sources/send_email_local_source.dart';
import 'package:incetro_test/features/send_email/data/sources/send_email_remote_source.dart';
import 'package:incetro_test/features/send_email/domain/entities/send_email.dart';
import 'package:incetro_test/features/send_email/domain/repositories/send_email_repository.dart';

class SendEmailRepositoryImpl extends SendEmailRepository{
  final SendEmailLocalSource sendEmailLocalSource;
  final SendEmailRemoteSource sendEmailRemoteSource;
  SendEmailRepositoryImpl({ required this.sendEmailLocalSource, required this.sendEmailRemoteSource}); 
  @override
  Future<Either<Failure, bool>> sendEmail(SendEmail sendEmailEntity) async {
    final sendEmailModel = SendEmailModel.fromEntity(sendEmailEntity);
    try {
      final response = await sendEmailRemoteSource.sendEmail(sendEmailModel);
      return Right(response);
    }
    catch (e) {
      return Left(NoInternetFailure('Check your conection and retry'));
    }
  }
}