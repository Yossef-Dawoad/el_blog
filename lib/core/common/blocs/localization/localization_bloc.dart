import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_blog/core/common/entities/languages.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'localization_event.dart';
part 'localization_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  LocalizationBloc() : super(const LocalizationState()) {
    on<LocalizationChanged>(_onLocaleChange);
    on<GetCurrentLocale>(_onGetCurrentLocale);
  }

  FutureOr<void> _onLocaleChange(
    LocalizationChanged event,
    Emitter<LocalizationState> emit,
  ) async {
    // emit(state.copyWith(selectedLanguage: event.selectedLanguage));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentLocale', event.selectedLanguage.name);
    emit(LocalizationChangeSuccess(selectedLanguage: event.selectedLanguage));
  }

  FutureOr<void> _onGetCurrentLocale(event, emit) async {
    final prefs = await SharedPreferences.getInstance();
    final selectedLanguageVal = prefs.getString('currentLocale');
    emit(
      LocalizationChangeSuccess(
          selectedLanguage: selectedLanguageVal != null
              ? LanguagesEnum.values.where((ele) => ele.name == selectedLanguageVal).first
              : LanguagesEnum.english),
    );
  }
}
