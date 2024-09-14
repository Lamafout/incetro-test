part of 'verification_bloc.dart';

class VerificationEvent{}
class SendCodeEvent extends VerificationEvent{
  final String verificationCode;
  SendCodeEvent(this.verificationCode);
}