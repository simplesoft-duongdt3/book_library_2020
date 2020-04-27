import 'package:booklibrary2020/features/main/category_list/category_list.dart';
import 'package:flutter/material.dart';

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

