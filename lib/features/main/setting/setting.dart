import 'package:booklibrary2020/data/models/language.dart';
import 'package:booklibrary2020/features/main_app/bloc/language_bloc.dart';
import 'package:booklibrary2020/features/main_app/bloc/language_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          width: 200,
          child: Column(
            children: <Widget>[
              CheckboxListTile(
                onChanged: (check) {
                  BlocProvider.of<LanguageBloc>(context)
                      .add(ChangeLanguageEvent(Language.vietnamese));
                },
                title: Text('Tiếng Việt'),
                value: Localizations.localeOf(context).languageCode == "vi",
              ),
              CheckboxListTile(
                onChanged: (check) {
                  BlocProvider.of<LanguageBloc>(context)
                      .add(ChangeLanguageEvent(Language.english));
                },
                title: Text('English'),
                value: Localizations.localeOf(context).languageCode == "en",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
