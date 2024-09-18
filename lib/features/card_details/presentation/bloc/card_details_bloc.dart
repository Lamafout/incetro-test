import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incetro_test/di/di.dart';
import 'package:incetro_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:incetro_test/features/card_details/domain/entities/organisation.dart';
import 'package:incetro_test/features/card_details/domain/usecases/card_details_usecase.dart';
import 'package:incetro_test/res/failures/failure.dart';

part 'card_details_event.dart';
part 'card_details_state.dart';

class CardDetailsBloc extends Bloc<CardDetailsEvent, CardDetailsState> {
  CardDetailsBloc() : super(CardDetailsInitial()) {
    on<SendId>((event, emit) async {
      final usecase = di<CardDetailsUsecase>();
      usecase.setCardId(event.id);
      final result = await usecase.execute();
      result.fold(
        (failure) {
          if (failure is NoTokenFailure) {
            emit(NoTokenState());
          }
          else {
            emit(FailureWhileGettingCardDetailsState(failure.toString()));
          }
        },
        (success) => emit(GotOrganisationState(success))
      );
    });
    on<ExitFromPage>((event, emit) {
      emit(CardDetailsInitial());
    });
  }
}