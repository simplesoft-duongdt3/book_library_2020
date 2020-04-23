import 'package:booklibrary2020/data/models/book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BookDetail extends StatelessWidget {
  final double _expandedHeight = 300;
  final BookEntity bookEntity;

  BookDetail({this.bookEntity});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    delegate: _MySliverAppBar(expandedHeight: _expandedHeight, logoUrl: bookEntity.thumbUrl),
                    pinned: true,
                    floating: true,
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 4,
                            ),
                            Text("${bookEntity.name}",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.black)),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "${bookEntity.author}",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            RatingBar(
                              initialRating: 3,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 20,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "130",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Page",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey),
                                    )
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "English",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "language",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey),
                                    )
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "2018",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Release",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "${bookEntity.description}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey),
                            )
                          ],
                        ),
                      )
                    ]),
                  )
                ],
              ),
            ),
            widgetBorrow(context)
          ],
        ),
      ),
    );
  }

  Widget widgetBorrow(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.green),
        alignment: Alignment.center,
        child: Text(
          "BORROW",
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}


class _MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final String logoUrl;

  _MySliverAppBar({@required this.expandedHeight, @required this.logoUrl});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.indigo,
          height: expandedHeight,
          child: Stack(
            fit: StackFit.expand,
            overflow: Overflow.visible,
            children: [
              Positioned(
                left: 0,
                top: kToolbarHeight / 2 - 24,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
                  iconSize: 24,
                  onPressed: () {
                    Navigator.pop(context);
                  },),
              ),
              Center(
                child: Opacity(
                  opacity: shrinkOffset / expandedHeight,
                  child: Text(
                    "Book Details",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 23,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          top: expandedHeight / 2 - 40,
          child: Container(
            height: expandedHeight / 2 + 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1.0),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Colors.white),
          ),
        ),
        Positioned(
          top: expandedHeight - 240 - shrinkOffset,
          left: MediaQuery.of(context).size.width / 4,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: widgetLogoBook(context, this.logoUrl),
          ),
        )
      ],
    );
  }

  Widget widgetLogoBook(BuildContext context, String logoUrl) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      height: 240,
      child: Card(
          semanticContainer: true,
          elevation: 10,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Image.network(
            logoUrl,
            fit: BoxFit.fill,
          )),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
