part of 'like_bloc.dart';

class LikeEvent {}

class TapOnLikeButton extends LikeEvent {
  final int id;
  TapOnLikeButton(this.id);
}
class RestoreState extends LikeEvent {}