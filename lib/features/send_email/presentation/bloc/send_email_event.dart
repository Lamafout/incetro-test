part of 'send_email_bloc.dart';

class SendEmailEvent {}
class SendEmailForGetCodeEvent extends SendEmailEvent{
  final String email;
  SendEmailForGetCodeEvent(this.email);
}