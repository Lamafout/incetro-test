import 'package:dartz/dartz.dart';
import 'package:incetro_test/features/card_details/domain/entities/organisation.dart';
import 'package:incetro_test/features/card_details/domain/repositories/card_details_repository.dart';
import 'package:incetro_test/res/failures/failure.dart';

class CardDetailsUsecase {
  final CardDetailsRepository cardDetailsRepository;
  late int cardId;
  setCardId(int id){
    cardId = id;
  }

  CardDetailsUsecase({required this.cardDetailsRepository});

  Future<Either<Failure, Organisation>> execute() async{
    final response = await cardDetailsRepository.getOrganisationById(cardId);
    return response.fold(
      (failure) => Left(failure),
      (success) => Right(success),
    );
  }
}