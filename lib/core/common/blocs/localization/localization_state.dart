part of 'localization_bloc.dart';

@immutable
class LocalizationState {
  final LanguagesEnum selectedLanguage;

  const LocalizationState({this.selectedLanguage = LanguagesEnum.english});
}

final class LocalizationChangeSuccess extends LocalizationState {
  const LocalizationChangeSuccess({super.selectedLanguage});
}
