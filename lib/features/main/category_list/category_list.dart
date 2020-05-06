import 'package:booklibrary2020/data/models/book.dart';
import 'package:booklibrary2020/features/main/book_detail.dart';
import 'package:booklibrary2020/features/main/book_list/book_list.dart';
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
            return CategoryBloc(
                RepositoryProvider.of<BookRepository>(context));
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

  Widget buildDataWidget(List<CategoryBookItemsEntity> listCategory, BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: listCategory.length,
        itemBuilder: (_, i) {
          return _horizontalListView(listCategory[i]);
        },
      ),
    );
  }

  Widget _horizontalListView(CategoryBookItemsEntity item) {
    return Container(
      height: MediaQuery.of(context).size.width / 2.5 * 1.5 + 20,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(item.category.name,),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => BookList(categoryId: item.category.id, isShowSearchBox: true,)));
                  },
                    child: Icon(Icons.more_vert)
                ),
              ],
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
      onTap: ()  {
        Navigator.push(context, MaterialPageRoute(builder: (context) => BookDetail(
          bookEntity: bookEntity,
        )));
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2.5,
        margin: EdgeInsets.all(8),

        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: Colors.grey, width: 0.3)),
        child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CachedNetworkImage(
                errorWidget: (context, url, error) =>
                    Icon(Icons.error_outline, color: Colors.red, size: 28,),
                imageUrl: bookEntity.thumbUrl,
                width: MediaQuery.of(context).size.width / 2.5,
                height: MediaQuery.of(context).size.width / 2.5 * 1.5 / 2,
                fit: BoxFit.fill,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 5.0
                ),
                child: Text(
                  bookEntity.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 5.0
                ),
                child: Text(
                  bookEntity.author,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 13,
                      color: Color.fromRGBO(135, 135, 135, 1.0)
                  ),
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


