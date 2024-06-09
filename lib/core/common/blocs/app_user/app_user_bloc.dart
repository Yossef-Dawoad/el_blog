import 'package:clean_blog/core/utils/logs/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../entities/user_entity.dart';

part 'app_user_event.dart';
part 'app_user_state.dart';

class AuthenticatedUserBloc extends Bloc<AuthenticatedUserEvent, AuthenticatedUserState> {
  AuthenticatedUserBloc() : super(AuthenticatedUserInitial()) {
    on<AuthenticatedUserUpdated>((event, emit) {
      logger.d('AuthenticatedUser Current Value: ', error: event.user);
      if (event.user != null) {
        return emit(AuthenticatedUserLoggedInSuccess(event.user!));
      }
      emit(AuthenticatedUserInitial());
    });
  }
}
