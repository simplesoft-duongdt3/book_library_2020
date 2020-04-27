import 'package:booklibrary2020/data/models/language.dart';
import 'package:booklibrary2020/data/service/api_service.dart';
import 'package:booklibrary2020/features/main_app/bloc/language_bloc.dart';
import 'package:booklibrary2020/features/main_app/bloc/language_event.dart';
import 'package:booklibrary2020/data/repo/book_repository.dart';
import 'package:booklibrary2020/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:booklibrary2020/features/main/book_list/book_list.dart';
import 'package:booklibrary2020/features/main/category_list/category_list.dart';

class HomeScreen extends StatelessWidget {
  static final screenName = "/books";

  @override
  Widget build(BuildContext context) {
    return Container(
        child: CategoryList(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

