import 'package:dartz/dartz.dart';
import 'package:incetro_test/features/card_details/data/sources/card_details_local_source.dart';
import 'package:incetro_test/features/card_details/data/sources/card_details_remote_source.dart';
import 'package:incetro_test/features/card_details/domain/entities/organisation.dart';
import 'package:incetro_test/features/card_details/domain/repositories/card_details_repository.dart';
import 'package:incetro_test/res/failures/failure.dart';

class CardDetailsRepositoryImpl implements CardDetailsRepository {
  final CardDetailsLocalSource cardDetailsLocalSource;
  final CardDetailsRemoteSource cardDetailsRemoteSource;
  CardDetailsRepositoryImpl({required this.cardDetailsLocalSource, required this.cardDetailsRemoteSource});

  @override
  Future<Either<Failure, Organisation>> getOrganisationById(int id) async{
    final token = await cardDetailsLocalSource.getToken('access');
    if (token == null || token.isEmpty) {
      return Left(NoTokenFailure('User is not authentificated'));
    } else {
      try {
        final response = await cardDetailsRemoteSource.getOrganisationById(id, token);
        return Right(response.toEntity());
      } on BadRequestException{
        final refreshToken = await cardDetailsLocalSource.getToken('refresh');
        final newTokens = await cardDetailsRemoteSource.updateToken(token, refreshToken as String);
        cardDetailsLocalSource.setToken('access', newTokens['access_token'] as String);
        cardDetailsLocalSource.setToken('refresh', newTokens['refresh_token'] as String);
        try{
          final newResponse = await cardDetailsRemoteSource.getOrganisationById(id, cardDetailsLocalSource.getToken('access') as String);
          return Right(newResponse.toEntity());
        } on Exception{
          return Left(NoInternetFailure('Check your connection and retry'));
        }
      } on Exception{
          return Left(NoInternetFailure('Check your connection and retry'));
        }
    }
  }
}