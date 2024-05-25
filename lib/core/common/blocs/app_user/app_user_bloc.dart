import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../entities/user_entity.dart';

part 'app_user_event.dart';
part 'app_user_state.dart';

class AuthenticatedUserBloc extends Bloc<AuthenticatedUserEvent, AuthenticatedUserState> {
  AuthenticatedUserBloc() : super(AuthenticatedUserInitial()) {
    on<AuthenticatedUserUpdated>((event, emit) {
      if (event.user != null) {
        emit(AuthenticatedUserLoggedInSuccess(event.user!));
        return;
      }
      emit(AuthenticatedUserInitial());
    });
  }
}
