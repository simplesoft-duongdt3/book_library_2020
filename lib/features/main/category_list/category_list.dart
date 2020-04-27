import 'package:booklibrary2020/features/main/category_list/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';

import 'package:booklibrary2020/data/models/category.dart';
import 'package:booklibrary2020/data/repo/book_repository.dart';
import 'package:booklibrary2020/data/service/api_service.dart';
import 'package:booklibrary2020/features/main/book_list/book_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) {
          return CategoryBloc(BookRepository(apiServiceInstance));
        },
        child: CategoryListBody(),
      ),
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
          return buildDataWidget(state.listCategory);
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
                  Text("Thử lại"),
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

  Widget buildDataWidget(List<CategoryEntity> listCategory) {
    return  Container(
      child: DefaultTabController (
        length: listCategory.length,
        child: Scaffold(
            appBar: TabBar(
              indicator: UnderlineTabIndicator(),
              isScrollable: true,
              tabs: List<Widget>.generate(listCategory.length, (int index) {
                return Tab(text: listCategory[index].name);
              }),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
            ),
            body: TabBarView(
              children: List<Widget>.generate(listCategory.length, (int index){
                return BookList();
              }),
            )
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

class UnderlineTabIndicator extends Decoration {
  const UnderlineTabIndicator({
    this.borderSide = const BorderSide(width: 5.0, color: Colors.blue),
    this.insets = EdgeInsets.zero,
  });
  final BorderSide borderSide;
  final EdgeInsetsGeometry insets;
  @override
  _UnderlinePainter createBoxPainter([ VoidCallback onChanged ]) {
    return _UnderlinePainter(this, onChanged);
  }
}

class _UnderlinePainter extends BoxPainter {
  _UnderlinePainter(this.decoration, VoidCallback onChanged)
      : assert(decoration != null),
        super(onChanged);

  final UnderlineTabIndicator decoration;

  BorderSide get borderSide => decoration.borderSide;
  EdgeInsetsGeometry get insets => decoration.insets;

  Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    final Rect indicator = insets.resolve(textDirection).deflateRect(rect);
    double wantWidth = 20;
    double cw = (indicator.left + indicator.right) / 2;
    return Rect.fromLTWH(cw - wantWidth / 2,
    indicator.bottom - borderSide.width, wantWidth, borderSide.width);
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect rect = offset & configuration.size;
    final TextDirection textDirection = configuration.textDirection;
    final Rect indicator = _indicatorRectFor(rect, textDirection).deflate(borderSide.width / 2.0);
    final Paint paint = borderSide.toPaint()..strokeCap = StrokeCap.square;
    canvas.drawLine(indicator.bottomLeft, indicator.bottomRight, paint);
  }
}



