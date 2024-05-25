part of 'app_user_bloc.dart';

@immutable
sealed class AuthenticatedUserState {}

final class AuthenticatedUserInitial extends AuthenticatedUserState {}

final class AuthenticatedUserLoggedInSuccess extends AuthenticatedUserState {
  final UserEntity user;
  AuthenticatedUserLoggedInSuccess(this.user);
}
