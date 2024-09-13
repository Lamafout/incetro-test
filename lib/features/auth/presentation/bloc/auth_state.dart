part of 'auth_bloc.dart';

class AuthState{}
class InitialState extends AuthState{}
class AuthenticatedState extends AuthState{
  
}
class UnauthenticatedState extends AuthState{}
class FailureState extends AuthState{}
