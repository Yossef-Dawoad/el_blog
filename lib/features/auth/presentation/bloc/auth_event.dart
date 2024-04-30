part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUpEvt extends AuthEvent {
  final String email;
  final String password;
  final String name;

  AuthSignUpEvt({
    required this.email,
    required this.password,
    required this.name,
  });
}

final class AuthSignInEvt extends AuthEvent {
  final String email;
  final String password;

  AuthSignInEvt({
    required this.email,
    required this.password,
  });
}

final class AuthGetCurrentUserEvt extends AuthEvent {}
