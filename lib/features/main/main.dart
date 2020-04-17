import 'package:booklibrary2020/data/models/language.dart';
import 'package:booklibrary2020/features/main_app/bloc/language_bloc.dart';
import 'package:booklibrary2020/features/main_app/bloc/language_event.dart';
import 'package:booklibrary2020/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  static final screenName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).app_name),
      ),
      body: Center(
        child: Text(S.of(context).hello_text),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: S.of(context).change_language,
        child: Icon(Icons.language),
        onPressed: () {
          changeLanguage(context);
        },

      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void changeLanguage(BuildContext context) {
    var currentLanguage =
        BlocProvider.of<LanguageBloc>(context).getCurrentLanguage();
    switch (currentLanguage) {
      case Language.vietnamese:
        BlocProvider.of<LanguageBloc>(context)
            .add(new ChangeLanguageEvent(Language.english));
        break;
      case Language.english:
        BlocProvider.of<LanguageBloc>(context)
            .add(new ChangeLanguageEvent(Language.vietnamese));
        break;
    }
  }
}
