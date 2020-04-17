import 'package:booklibrary2020/data/models/language.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LanguageEvent {}

@immutable
class ChangeLanguageEvent extends LanguageEvent {
  final Language _language;

  ChangeLanguageEvent(this._language);

  Language get language => _language;

  @override
  String toString() {
    return 'ChangeLanguageEvent{_language: $_language}';
  }
}
