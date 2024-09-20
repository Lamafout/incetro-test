import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incetro_test/di/di.dart';
import 'package:incetro_test/features/like/domain/usecases/like_usecase.dart';
import 'package:incetro_test/res/failures/failure.dart';

part 'like_event.dart';
part 'like_state.dart';

class LikeBloc extends Bloc<LikeEvent, Map<String, LikeState>> {
  LikeBloc() : super({}) {
    on<TapOnLikeButton>((event, emit) async {
      final usecase = di<LikeUsecase>();
      usecase.setOrganisationId(event.id);
      final result = await usecase.tapOnLikeButton();
      result.fold(
        (failure) {
          if (failure is IncorrectCodeFailure) {
            emit({
              ...state, 
              event.id.toString(): LikeBadRequestState()
            });
          } else {
            emit({
              ...state,
              event.id.toString() : LikeFailureState() 
            });
          }
        },
        (success) {
          if (success.status == 'deleted') {
            emit({
              ...state,
              event.id.toString() : DisLikedState()
            });
          } else {
            emit({
              ...state,
              event.id.toString() : LikedState()
            });
          }
        } 
      );
    });
  }
}