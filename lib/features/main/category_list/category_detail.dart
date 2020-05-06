import 'package:booklibrary2020/features/main/book_list/book_list.dart';
import 'package:flutter/material.dart';

class CategoryDetail extends StatelessWidget {
  static final screenName = "/category_detail";

  @override
  Widget build(BuildContext context) {
    final CategoryDetailScreenArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(args.categoryName),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: BookList(isShowSearchBox: false, categoryId: args.categoryId),
    );
  }
}

class CategoryDetailScreenArguments {
  final String categoryName;
  final int categoryId;

  const CategoryDetailScreenArguments(
      {@required this.categoryName, @required this.categoryId});
}
