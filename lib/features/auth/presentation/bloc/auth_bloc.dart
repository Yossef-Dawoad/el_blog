import 'package:clean_blog/core/common/usecase/usecase_base.dart';
import 'package:clean_blog/features/auth/domain/entities/user_entity.dart';
import 'package:clean_blog/features/auth/domain/usecases/get_current_user.dart';
import 'package:clean_blog/features/auth/domain/usecases/login_usecase.dart';
import 'package:clean_blog/features/auth/domain/usecases/signup_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUpUsecase _signUpUsecase;
  final UserSignInWithPasswordUsecase _signInWithPasswordUsecase;
  final GetCurrentUser _getCurrentUser;
  AuthBloc({
    required UserSignUpUsecase signUpUsecase,
    required UserSignInWithPasswordUsecase signInWithPasswordUsecase,
    required GetCurrentUser getCurrentUser,
  })  : _signUpUsecase = signUpUsecase,
        _signInWithPasswordUsecase = signInWithPasswordUsecase,
        _getCurrentUser = getCurrentUser,
        super(AuthInitial()) {
    on<AuthSignUpEvt>(_signUpEvtHandler);
    on<AuthSignInEvt>(_signInEvtHandler);
    on<AuthGetCurrentUserEvt>(_onGetCurrentUser);
  }

  void _signUpEvtHandler(AuthSignUpEvt ev, Emitter<AuthState> emit) async {
    final result = await _signUpUsecase(
      SignUpUserParams(name: ev.name, email: ev.email, password: ev.password),
    );
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  void _signInEvtHandler(AuthSignInEvt ev, Emitter<AuthState> emit) async {
    final result = await _signInWithPasswordUsecase(
      SignInUserParams(email: ev.email, password: ev.password),
    );
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  void _onGetCurrentUser(
    AuthGetCurrentUserEvt ev,
    Emitter<AuthState> emit,
  ) async {
    final result = await _getCurrentUser(NoParams());
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }
}
