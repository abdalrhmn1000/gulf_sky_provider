part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthCheckRequested extends AuthEvent {}

class AuthLogin extends AuthEvent {
  final UserInfo user;
  AuthLogin(this.user);
}

class AuthLogout extends AuthEvent {}

class AuthSetFirstTimeLogged extends AuthEvent {
  final bool isFirstTimeLogged;
  AuthSetFirstTimeLogged({required this.isFirstTimeLogged});
}

class SubscribeToAuthStatus extends AuthEvent {}

class AuthUpdateUser extends AuthEvent {
  final UserInfo user;
  AuthUpdateUser({required this.user});
}
