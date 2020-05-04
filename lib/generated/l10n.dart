// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

class S {
  S();
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final String name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return S();
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  String get app_name {
    return Intl.message(
      'Book station',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  String get hello_text {
    return Intl.message(
      'Hello!',
      name: 'hello_text',
      desc: '',
      args: [],
    );
  }

  String get change_language {
    return Intl.message(
      'Change language',
      name: 'change_language',
      desc: '',
      args: [],
    );
  }

  String get page {
    return Intl.message(
      'Page',
      name: 'page',
      desc: '',
      args: [],
    );
  }

  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  String get release {
    return Intl.message(
      'Release',
      name: 'release',
      desc: '',
      args: [],
    );
  }

  String get borrow_book_action {
    return Intl.message(
      'BORROW',
      name: 'borrow_book_action',
      desc: '',
      args: [],
    );
  }

  String get retry_action {
    return Intl.message(
      'Retry',
      name: 'retry_action',
      desc: '',
      args: [],
    );
  }

  String get main_newest_tab {
    return Intl.message(
      'Newest',
      name: 'main_newest_tab',
      desc: '',
      args: [],
    );
  }

  String get main_category_tab {
    return Intl.message(
      'Category',
      name: 'main_category_tab',
      desc: '',
      args: [],
    );
  }

  String get main_search_tab {
    return Intl.message(
      'Search',
      name: 'main_search_tab',
      desc: '',
      args: [],
    );
  }

  String get main_setting_tab {
    return Intl.message(
      'Setting',
      name: 'main_setting_tab',
      desc: '',
      args: [],
    );
  }

  String get newest_tab_label {
    return Intl.message(
      'Newest',
      name: 'newest_tab_label',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (Locale supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}