import 'package:booklibrary2020/common/network/dio.dart';
import 'package:booklibrary2020/data/models/book.dart';
import 'package:booklibrary2020/data/repo/book_repository.dart';
import 'package:booklibrary2020/data/service/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'book_list_item.dart';

class BookListSetState extends StatefulWidget {
  @override
  createState() => BookListSetStateState();
}

class BookListSetStateState extends State<BookListSetState> {
  List<BookEntity> newListBook = List<BookEntity>();
  bool isLoading = false;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    getBooks();
  }

  void getBooks() async {
    setState(() {
      isLoading = true;
      isError = false;
    });

    BookRepository bookRepository = BookRepository(apiServiceInstance);
    NetworkResponseModel<List<BookEntity>> books = await bookRepository.getBooks();
    print(books);
    if (books.isSuccess()) {
      setState(() {
        isLoading = false;
        isError = false;
        newListBook = books.responseModel;
      });
    } else {
      setState(() {
        isError = true;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Book list setState"),
        automaticallyImplyLeading: true,
        titleSpacing: 0.00,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    if (isLoading) {
      return buildLoadingWidget();
    } else if (isError) {
      return buildErrorWidget();
    } else {
      return buildDataWidget();
    }
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

  Container buildLoadingWidget() {
    return Container(
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Container buildErrorWidget() {
    return Container(
      child: Center(
        child: InkWell(
          onTap: () {
            refreshItems();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 48,
                ),
                Text("Thử lại"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> refreshItems() async {
    getBooks();
  }
}
