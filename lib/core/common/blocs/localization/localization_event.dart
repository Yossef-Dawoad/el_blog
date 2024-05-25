part of 'localization_bloc.dart';

@immutable
sealed class LocalizationEvent {}

final class LocalizationChanged extends LocalizationEvent {
  final LanguagesEnum selectedLanguage;

  LocalizationChanged({required this.selectedLanguage});
}

final class GetCurrentLocale extends LocalizationEvent {}
