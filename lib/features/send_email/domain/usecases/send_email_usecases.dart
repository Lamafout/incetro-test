import 'package:dartz/dartz.dart';
import 'package:incetro_test/features/auth/domain/entities/failure.dart';
import 'package:incetro_test/features/send_email/domain/entities/send_email.dart';
import 'package:incetro_test/features/send_email/domain/repositories/send_email_repository.dart';

class SendEmailUsecases {
  final SendEmailRepository sendEmailRepository;
  late SendEmail sendEmailEntity;
  setEmail(String email){
    sendEmailEntity = SendEmail(email: email);
  }

  SendEmailUsecases(this.sendEmailRepository);
  Future<Either<Failure, bool>> execute() async{
    final response = await sendEmailRepository.sendEmail(sendEmailEntity);
    return response.fold(
      (failure)=>Left(failure),
      (success) => Right(success),
    );
  }
}