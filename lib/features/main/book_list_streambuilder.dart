import 'dart:async';

import 'package:booklibrary2020/common/network/dio.dart';
import 'package:booklibrary2020/data/models/book.dart';
import 'package:booklibrary2020/data/repo/book_repository.dart';
import 'package:booklibrary2020/data/service/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'book_list_item.dart';

class BookListStreamBuilder extends StatefulWidget {
  @override
  createState() => BookListStreamBuilderState();
}

class BookListStreamBuilderState extends State<BookListStreamBuilder> {
  final StreamController<BookListState> _streamController =
  new StreamController<BookListState>();
  final BookRepository bookRepository = BookRepository(apiServiceInstance);

  @override
  void initState() {
    super.initState();
    getBooks();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  void getBooks() async {
    _streamController.add(BookListState.loading());

    NetworkResponseModel<List<BookEntity>> books =
    await bookRepository.getBooks();

    if (books.isSuccess()) {
      _streamController.add(BookListState.successWithData(books.responseModel));
    } else {
      _streamController.add(BookListState.error());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book list streambuilder"),
        automaticallyImplyLeading: true,
        titleSpacing: 0.00,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: StreamBuilder<BookListState>(
          stream: _streamController.stream,
          initialData: BookListState.loading(),
          builder: (BuildContext context,
              AsyncSnapshot<BookListState> snapshot) {
            if (snapshot.hasData) {
              final bookListState = snapshot.data;
              if (bookListState.isLoading) {
                return buildLoadingWidget();
              } else if (bookListState.isError) {
                return buildErrorWidget();
              } else {
                return buildDataWidget(bookListState.listBook);
              }
            } else {
              return buildErrorWidget();
            }
          }),
    );
  }

  Container buildDataWidget(List<BookEntity> listBook) {
    return Container(
      child: RefreshIndicator(
        onRefresh: () {
          return refreshItems();
        },
        child: ListView.separated(
          separatorBuilder: (context, index) =>
              Divider(
                color: Color.fromARGB(135, 135, 135, 1),
              ),
          itemCount: listBook.length,
          itemBuilder: (BuildContext context, int index) {
            return BookListItem(item: listBook[index]);
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

class BookListState {
  final bool isLoading;
  final bool isError;
  final List<BookEntity> listBook;

  BookListState({@required this.isLoading,
    @required this.isError,
    @required this.listBook});

  static BookListState loading() {
    return BookListState(isError: false, isLoading: true, listBook: null);
  }

  static BookListState error() {
    return BookListState(isError: true, isLoading: false, listBook: null);
  }

  static BookListState successWithData(List<BookEntity> listBook) {
    return BookListState(isError: false, isLoading: false, listBook: listBook);
  }
}
