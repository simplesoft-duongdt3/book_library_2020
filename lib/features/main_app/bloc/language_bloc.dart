import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:booklibrary2020/data/models/language.dart';
import 'package:booklibrary2020/data/repo/language_repository.dart';

import 'language_event.dart';
import 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final LanguageRepository _languageRepository;

  Language _currentLanguage;
  LanguageBloc(this._currentLanguage, this._languageRepository);

  Language getCurrentLanguage() {
    return _currentLanguage;
  }


  @override
  LanguageState get initialState => LanguageState(_currentLanguage);

  @override
  Stream<LanguageState> mapEventToState(
    LanguageEvent event,
  ) async* {
    if (event is ChangeLanguageEvent) {
      await updateCurrentLanguage(event);
      _currentLanguage = event.language;
      yield LanguageState(_currentLanguage);
    }
  }

  Future<void> updateCurrentLanguage(ChangeLanguageEvent event) async {
    await this._languageRepository.updateCurrentLanguage(event.language);
  }
}
