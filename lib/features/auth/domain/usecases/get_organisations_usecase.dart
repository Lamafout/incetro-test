import 'package:dartz/dartz.dart';
import 'package:incetro_test/features/auth/domain/entities/failure.dart';
import 'package:incetro_test/features/auth/domain/entities/organisations.dart';
import 'package:incetro_test/features/auth/domain/repositories/auth_repository.dart';

class GetOrganisationsUseCase {
  final AuthRepository authRepository;
  GetOrganisationsUseCase(this.authRepository);

  Future<Either<Failure, Organisations>> execute() async {
    final organisations = await authRepository.signIn();
    return organisations.fold(
        (failure) async{
          if (failure is NoTokenFailure){
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