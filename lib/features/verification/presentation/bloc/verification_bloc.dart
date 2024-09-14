import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incetro_test/di/di.dart';
import 'package:incetro_test/features/verification/domain/usecases/verification_usecase.dart';
import 'package:incetro_test/res/failures/failure.dart';

part 'verification_event.dart';
part'verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  VerificationBloc() : super(VerificationInitialState()) {
    on<SendCodeEvent>((event, emit) async {
      final usecase = di<VerificationUsecase>();
      final result = await usecase.execute(event.verificationCode);
      result.fold(
        (failure){
          failure is IncorrectCodeFailure ? emit(WrongDataState()) : emit(FailureState());
        },
        (success) => emit(CorrectDataState())
      );
    });
  }
}