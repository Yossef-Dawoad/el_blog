import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../entities/user_entity.dart';

part 'app_user_event.dart';
part 'app_user_state.dart';

class AppUserBloc extends Bloc<AppUserEvent, AppUserState> {
  AppUserBloc() : super(AppUserInitial()) {
    on<AppUserUpdated>((event, emit) {
      if (event.user != null) {
        emit(AppUserLoggedInSuccess(event.user!));
        return;
      }
      emit(AppUserInitial());
    });
  }
}
