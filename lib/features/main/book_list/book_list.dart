import 'package:booklibrary2020/data/models/book.dart';
import 'package:booklibrary2020/data/repo/book_repository.dart';
import 'package:booklibrary2020/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';
import 'book_list_item.dart';

class BookList extends StatelessWidget {
  final int categoryId;
  final bool isShowSearchBox;

  BookList({@required this.categoryId, @required this.isShowSearchBox});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) {
        return BookListBloc(RepositoryProvider.of<BookRepository>(context));
      },
      child: BookListWithBlocBody(categoryId, isShowSearchBox),
    ));
  }
}

class BookListWithBlocBody extends StatefulWidget {
  final int categoryId;
  final bool isShowSearchBox;

  BookListWithBlocBody(this.categoryId, this.isShowSearchBox);

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
    return Builder(
      builder: (context) {
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildErrorWidget() {
    return Builder(
      builder: (context) {
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
                    Text(S.of(context).retry_action)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
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
                  checkAndBuildSearchBox(context),
                  buildListBookItems(listBook),
                ],
              )));
    });
  }

  Widget buildListBookItems(List<BookEntity> listBook) {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) => Divider(
          color: Color.fromARGB(135, 135, 135, 1),
        ),
        itemCount: listBook.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 36),
            child: BookListItem(item: listBook[index]),
          );
        },
      ),
    );
  }

  Widget buildSearchBox(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 36),
      child: TextField(
        onChanged: (value) {
          searchBooks(context, textController.text);
        },
        controller: textController,
        style: TextStyle(height: 1.0),
        decoration: InputDecoration(
            hintText: 'Search',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)))),
      ),
    );
  }

  Widget checkAndBuildSearchBox(BuildContext context) {
    if (widget.isShowSearchBox) {
      return buildSearchBox(context);
    } else {
      return Container();
    }
  }

  Future<void> refreshItems(BuildContext context) async {
    getBooks(context);
  }

  void getBooks(context) async {
    BlocProvider.of<BookListBloc>(context)
        .add(GetItemsEvent(widget.categoryId));
  }

  void searchBooks(context, String searchTerm) async {
    BlocProvider.of<BookListBloc>(context)
        .add(SearchItemsEvent(widget.categoryId, searchTerm));
  }
}
