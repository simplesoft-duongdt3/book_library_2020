import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:booklibrary2020/data/models/book.dart';
import 'package:booklibrary2020/data/repo/book_repository.dart';
import 'package:booklibrary2020/data/service/api_service.dart';
import 'book_list_item.dart';

class BookList extends StatefulWidget {
  @override
  createState() => BookListState();
}

class BookListState extends State<BookList> {
  List<BookEntity> newListBook = List<BookEntity>();

  @override
  void initState() {
    super.initState();
    getBooks();
  }

  void getBooks() async {
    BookRepository bookRepository = BookRepository(apiServiceInstance);
    var books = await bookRepository.getBooks();
    print(books);
    if (books.isSuccess()) {
      setState(() {
        newListBook = books.responseModel;
      });
    }
//    var categories = await bookRepository.getCategories();
//    print(categories);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Color.fromARGB(135, 135, 135, 1),
        ),
        itemCount: newListBook.length,
        itemBuilder: (BuildContext context, int index) {
          return BookListItem(item: newListBook[index]);
        },
      ),
    );
  }
}