import 'package:booklibrary2020/data/models/book.dart';
import 'package:booklibrary2020/features/main/book_detail.dart';
import 'package:booklibrary2020/features/main/category_list/category_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';

import 'package:booklibrary2020/data/models/CategoryBookItems.dart';
import 'package:booklibrary2020/data/repo/book_repository.dart';
import 'package:booklibrary2020/features/main/category_list/bloc.dart';
import 'package:booklibrary2020/generated/l10n.dart';

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Builder(builder: (context) {
        return BlocProvider(
          create: (context) {
            return CategoryBloc(RepositoryProvider.of<BookRepository>(context));
          },
          child: CategoryListBody(),
        );
      }),
    );
  }
}

class CategoryListBody extends StatefulWidget {
  @override
  _CategoryListBodyState createState() => _CategoryListBodyState();
}

class _CategoryListBodyState extends State<CategoryListBody> {
  @override
  Widget build(BuildContext context) {
    return buildBodyWidget(context);
  }

  Widget buildBodyWidget(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (BuildContext context, CategoryState state) {
        if (state is ErrorLoadingCategoryListState) {
          return buildErrorWidget();
        } else if (state is SuccessCategoryListState) {
          return buildDataWidget(
              state.listCategory.toList(growable: true), context);
        } else {
          return buildLoadingWidget();
        }
      },
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
                  Text(S.of(context).retry_action),
                ],
              ),
            ),
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

  Widget buildDataWidget(
      List<CategoryBookItemsEntity> listCategory, BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, index) => Divider(
        color: Color.fromARGB(135, 135, 135, 1),
      ),
      itemCount: listCategory.length,
      itemBuilder: (_, i) {
        return _horizontalListView(listCategory[i]);
      },
    );
  }

  Widget _horizontalListView(CategoryBookItemsEntity item) {
    return Container(
      height: MediaQuery.of(context).size.width / 2.9 + 40,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  CategoryDetail.screenName,
                  arguments: CategoryDetailScreenArguments(
                      categoryId: item.category.id,
                      categoryName: item.category.name),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        item.category.name,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Icon(Icons.navigate_next),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: item.books.length,
              itemBuilder: (_, i) => _buildBookItem(bookEntity: item.books[i]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookItem({BookEntity bookEntity}) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BookDetail(
                      bookEntity: bookEntity,
                    )));
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2.9,
        height: MediaQuery.of(context).size.width / 2.9,
        margin: EdgeInsets.only(left: 16, bottom: 8, top: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: Colors.grey, width: 0.3)),
        child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(5),
          child: Stack(
            children: <Widget>[
              CachedNetworkImage(
                errorWidget: (context, url, error) => Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 28,
                ),
                imageUrl: bookEntity.thumbUrl,
                width: MediaQuery.of(context).size.width / 2.9,
                height: MediaQuery.of(context).size.width / 2.9,
                fit: BoxFit.fill,
              ),
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black],
                  stops: [0.0, 1],
                )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                      child: Text(
                        bookEntity.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2, left: 4, right: 4, bottom: 4),
                      child: Text(
                        bookEntity.author,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 11, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> refreshItems(BuildContext context) async {
    getCategories(context);
  }

  void getCategories(context) async {
    BlocProvider.of<CategoryBloc>(context).add(GetCategoryItemsEvent());
  }

  @override
  void initState() {
    getCategories(context);
    super.initState();
  }
}
