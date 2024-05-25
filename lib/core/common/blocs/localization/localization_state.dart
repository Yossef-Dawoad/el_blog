part of 'localization_bloc.dart';

// @immutable
// class LocalizationState {
//   final LanguagesEnum selectedLanguage;

//   const LocalizationState({LanguagesEnum? language})
//       : selectedLanguage = language ?? LanguagesEnum.english;

//   LocalizationState copyWith({LanguagesEnum? selectedLanguage}) =>
//       LocalizationState(language: selectedLanguage);
// }
@immutable
class LocalizationState {
  final LanguagesEnum selectedLanguage;

  const LocalizationState({this.selectedLanguage = LanguagesEnum.english});
}

final class LocalizationChangeSuccess extends LocalizationState {
  const LocalizationChangeSuccess({super.selectedLanguage});
}
