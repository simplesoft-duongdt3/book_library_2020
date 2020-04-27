import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:booklibrary2020/data/models/book.dart';
import 'package:booklibrary2020/data/repo/book_repository.dart';
import 'package:booklibrary2020/data/service/api_service.dart';
import 'book_list_item.dart';
import 'bloc.dart';

class BookList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
  void initState() {
    getBooks(context);
    super.initState();
  }

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
          return buildBookListWidget(state.listBook);
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget buildLoadingWidget() {
    return Builder(builder: (context) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    },);
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
                    size: 50,
                  ),
                  Text('Thử lại')
                ],
              ),
            ),
          ),
        ),
      );
    },);
  }

  Widget buildBookListWidget(List<BookEntity> listBook) {
    return Builder(builder: (context) {
      return Container(
        child: RefreshIndicator(
          onRefresh: () {
            return refreshItems(context);
          },
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                child: TextField(
                  onChanged: (value) {
                    searchBooks(context);
                  },
                  style: TextStyle(
                    height: 0.5
                  ),
                  decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)))),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                child: Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => Divider(
                      color: Color.fromARGB(135, 135, 135, 1),
                    ),
                    itemCount: listBook.length,
                    itemBuilder: (BuildContext context, int index) {
                      return BookListItem(item: listBook[index]);
                    },
                  ),
                ),
              ),
            ],
          )
        ));
      }
    );
  }

  Future<void> refreshItems(BuildContext context) async {
    getBooks(context);
  }

  void getBooks(context) async {
    BlocProvider.of<BookListBloc>(context).add(GetItemsEvent());
  }

  void searchBooks(context) async {
    BlocProvider.of<BookListBloc>(context).add(SearchItemsEvent());
  }
}
