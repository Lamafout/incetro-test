part of 'card_details_bloc.dart';

class CardDetailsState {}
class CardDetailsInitial extends CardDetailsState {}
class GotOrganisationState extends CardDetailsState {
  final Organisation organisation;
  GotOrganisationState(this.organisation);
}
class NoTokenState extends CardDetailsState {}
class FailureWhileGettingCardDetailsState extends CardDetailsState {
  final String errorMessage;
  FailureWhileGettingCardDetailsState(this.errorMessage);
}