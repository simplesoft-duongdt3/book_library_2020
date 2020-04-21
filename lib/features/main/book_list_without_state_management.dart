import 'package:booklibrary2020/common/network/dio.dart';
import 'package:booklibrary2020/data/models/book.dart';
import 'package:booklibrary2020/data/repo/book_repository.dart';
import 'package:booklibrary2020/data/service/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'book_list_item.dart';

class BookListWithoutStateManagement extends StatefulWidget {
  @override
  createState() => BookListWithoutStateManagementState();
}

class BookListWithoutStateManagementState
    extends State<BookListWithoutStateManagement> {
  List<BookEntity> newListBook = List<BookEntity>();

  @override
  void initState() {
    super.initState();
    getBooks();
  }

  void getBooks() async {
    BookRepository bookRepository = BookRepository(apiServiceInstance);
    NetworkResponseModel<List<BookEntity>> books =
        await bookRepository.getBooks();
    print(books);
    if (books.isSuccess()) {
      setState(() {
        newListBook = books.responseModel;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book list without state management"),
        automaticallyImplyLeading: true,
        titleSpacing: 0.00,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: buildDataWidget(),
    );
  }

  Container buildDataWidget() {
    return Container(
      child: RefreshIndicator(
        onRefresh: () {
          return refreshItems();
        },
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: Color.fromARGB(135, 135, 135, 1),
          ),
          itemCount: newListBook.length,
          itemBuilder: (BuildContext context, int index) {
            return BookListItem(item: newListBook[index]);
          },
        ),
      ),
    );
  }

  Future<void> refreshItems() async {
    getBooks();
  }
}
