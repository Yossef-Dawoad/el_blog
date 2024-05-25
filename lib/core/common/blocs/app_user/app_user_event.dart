part of 'app_user_bloc.dart';

@immutable
sealed class AuthenticatedUserEvent {}

final class AuthenticatedUserUpdated extends AuthenticatedUserEvent {
  final UserEntity? user;
  AuthenticatedUserUpdated(this.user);
}
