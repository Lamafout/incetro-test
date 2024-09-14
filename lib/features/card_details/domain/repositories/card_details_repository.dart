import 'package:dartz/dartz.dart';
import 'package:incetro_test/features/card_details/domain/entities/organisation.dart';
import 'package:incetro_test/res/failures/failure.dart';

abstract class CardDetailsRepository {
  Future<Either<Failure, Organisation>> getOrganisationById(int id);
}