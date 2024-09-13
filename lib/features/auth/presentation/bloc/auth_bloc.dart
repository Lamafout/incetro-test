import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incetro_test/di/di.dart';
import 'package:incetro_test/features/auth/domain/entities/organisations.dart';
import 'package:incetro_test/features/auth/domain/usecases/auth_usecases.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitialState()) {
    on<EntryEvent>((event, emit) async {
      final authUsecases = di<AuthUsecases>();
      final result = await authUsecases.execute();
      result.fold(
        (failure) => emit(FailureState()),
        (success) {
          success.isDemo == true 
          ? emit(UnauthenticatedState(success))
          : emit(AuthenticatedState(success));
        }
      ); 
    });
  }
}