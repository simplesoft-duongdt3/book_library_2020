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
  final int categoryId;

  BookList(this.categoryId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
          create: (context) {
            return BookListBloc(RepositoryProvider.of<BookRepository>(context));
          },
          child: BookListWithBlocBody(categoryId),
        ));
  }
}

class BookListWithBlocBody extends StatefulWidget {
  final int categoryId;

  BookListWithBlocBody(this.categoryId);

  @override
  _BookListWithBlocBodyState createState() => _BookListWithBlocBodyState();
}

class _BookListWithBlocBodyState extends State<BookListWithBlocBody> {

  final textController = TextEditingController();
  @override
  void initState() {
    getBooks(context);
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
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
                    searchBooks(context, textController.text);
                  },
                  controller: textController,
                  style: TextStyle(
                    height: 1.0
                  ),
                  decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)))),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
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
    BlocProvider.of<BookListBloc>(context).add(GetItemsEvent(widget.categoryId));
  }

  void searchBooks(context, String searchTerm) async {
    BlocProvider.of<BookListBloc>(context).add(SearchItemsEvent(widget.categoryId, searchTerm));
  }
}
