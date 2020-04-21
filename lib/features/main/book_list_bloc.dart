import 'dart:async';

import 'package:booklibrary2020/data/models/book.dart';
import 'package:booklibrary2020/data/repo/book_repository.dart';
import 'package:booklibrary2020/data/service/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'book_list_item.dart';
import 'demo_bloc/bloc.dart';

class BookListWithBloc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Book list streambuilder"),
          automaticallyImplyLeading: true,
          titleSpacing: 0.00,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        body: BlocProvider(
          create: (context) {
            return BookListBloc(BookRepository(apiServiceInstance));
          },
          child: BookListWithBlocBody(),
        ));
  }
}

class BookListWithBlocBody extends StatefulWidget {
  @override
  _BookListWithBlocBodyState createState() => _BookListWithBlocBodyState();
}

class _BookListWithBlocBodyState extends State<BookListWithBlocBody> {
  @override
  Widget build(BuildContext context) {
    return buildBodyWidget(context);
  }

  Widget buildBodyWidget(BuildContext context) {
    return BlocBuilder<BookListBloc, BookListState>(
      builder: (BuildContext context, BookListState state) {
        if (state is ErrorBookListState) {
          return buildErrorWidget();
        } else if (state is SuccessBookListState) {
          return buildDataWidget(state.listBook);
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget buildDataWidget(List<BookEntity> listBook) {
    return Builder(builder: (context) {
      return Container(
        child: RefreshIndicator(
          onRefresh: () {
            return refreshItems(context);
          },
          child: ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Color.fromARGB(135, 135, 135, 1),
            ),
            itemCount: listBook.length,
            itemBuilder: (BuildContext context, int index) {
              return BookListItem(item: listBook[index]);
            },
          ),
        ),
      );
    });
  }

  Widget buildLoadingWidget() {
    return Container(
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget buildErrorWidget() {
    return Builder(builder: (context) {
      return Container(
        child: Center(
          child: InkWell(
            onTap: () {
              refreshItems(context);
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
    });
  }

  Future<void> refreshItems(BuildContext context) async {
    getBooks(context);
  }

  void getBooks(context) async {
    BlocProvider.of<BookListBloc>(context).add(GetItemsEvent());
  }

  @override
  void initState() {
    getBooks(context);
    super.initState();
  }
}
