import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incetro_test/di/di.dart';
import 'package:incetro_test/features/send_email/domain/usecases/send_email_usecases.dart';

part 'send_email_event.dart';
part 'send_email_state.dart';

class SendEmailBloc extends Bloc<SendEmailEvent, SendEmailState> {
  SendEmailBloc() : super(InitialState()) {
    on<SendEmailForGetCodeEvent>((event, emit) async {
      final usecases = di<SendEmailUsecases>();
      usecases.setEmail(event.email);
      final result = await usecases.execute();
      result.fold(
        (failure) => emit(FailureState()),
        (success){
          if (success == true){
            emit (CodeSendedState());
          }
          else{
            emit(CodeNotSendedState());
          }
        }
      );
    });
  }
}