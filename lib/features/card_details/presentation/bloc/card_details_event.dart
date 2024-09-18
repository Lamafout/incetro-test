part of 'card_details_bloc.dart';

class CardDetailsEvent{}
class SendId extends CardDetailsEvent{
  final int id;
  SendId(this.id);
}
class ExitFromPage extends CardDetailsEvent{}