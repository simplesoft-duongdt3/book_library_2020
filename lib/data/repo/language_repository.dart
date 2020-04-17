import 'package:booklibrary2020/data/models/language.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageRepository {
  static const int VIETNAMESE_INDEX = 0;
  static const int ENGLISH_INDEX = 1;
  static const LANGUAGE_KEY = "language";

  Future<void> updateCurrentLanguage(Language language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (language == Language.vietnamese) {
      await prefs.setInt(LANGUAGE_KEY, VIETNAMESE_INDEX);
    } else {
      await prefs.setInt(LANGUAGE_KEY, ENGLISH_INDEX);
    }
  }

  Future<Language> getCurrentLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int languageIndex = prefs.getInt(LANGUAGE_KEY) ?? VIETNAMESE_INDEX;
    if (languageIndex == VIETNAMESE_INDEX) {
      return Language.vietnamese;
    } else {
      return Language.english;
    }
  }
}
