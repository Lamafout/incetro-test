import 'package:dartz/dartz.dart';
import 'package:incetro_test/res/failures/failure.dart';
import 'package:incetro_test/features/auth/domain/entities/organisations.dart';
import 'package:incetro_test/features/auth/domain/repositories/auth_repository.dart';

class AuthUsecases {
  final AuthRepository authRepository;
  AuthUsecases(this.authRepository);

  Future<Either<Failure, Organisations>> execute() async {
    final organisations = await authRepository.signIn();
    return organisations.fold(
        (failure) async{
          if (failure is IncorrectTokenFailure){
            final refreshResult = await authRepository.updateTokens();
            return refreshResult.fold(
              (failureRefresh) => Left(failureRefresh),
              (successRefresh) async{
                final newOrganisations = await authRepository.signIn();
                return newOrganisations.fold(
                  (newFailure) => Left(newFailure),
                  (newSuccess) => Right(newSuccess)
                );
              }
            );
          } 
          else if (failure is NoTokenFailure){
            final demo = await authRepository.getDemo();
            return demo.fold(
              (failureDemo) => Left(failureDemo),
              (successDemo) => Right(successDemo)
            );
          }
          else{
            return Left(failure);
          }
        }, 
        (success) => Right(success)
      );
  }
}