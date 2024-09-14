import 'package:dartz/dartz.dart';
import 'package:incetro_test/res/failures/failure.dart';
import 'package:incetro_test/features/send_email/domain/entities/send_email.dart';

abstract class SendEmailRepository {
  Future<Either<Failure, bool>> sendEmail(SendEmail sendEmailEntity);
}