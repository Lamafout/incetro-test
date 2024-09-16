part of 'auth_bloc.dart';

class AuthState{}
class InitialState extends AuthState{}
class AuthenticatedState extends AuthState{
  final Organisations organisations;
  AuthenticatedState(this.organisations);
}
class UnauthenticatedState extends AuthState{
  final Organisations organisations;
  UnauthenticatedState(this.organisations);
}
class FailureState extends AuthState{
  final String? message;
  FailureState(this.message);
}
