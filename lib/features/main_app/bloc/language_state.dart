import 'package:booklibrary2020/data/models/language.dart';
import 'package:meta/meta.dart';

@immutable
class LanguageState {
  final Language _language;

  LanguageState(this._language);

  Language get language => _language;

  @override
  String toString() {
    return 'LanguageState{_language: $_language}';
  }
}
