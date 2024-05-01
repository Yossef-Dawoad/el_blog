part of 'app_user_bloc.dart';

@immutable
sealed class AppUserEvent {}

final class AppUserUpdated extends AppUserEvent {
  final UserEntity? user;
  AppUserUpdated(this.user);
}
