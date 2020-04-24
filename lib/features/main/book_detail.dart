
import 'package:booklibrary2020/data/models/book.dart';
import 'package:booklibrary2020/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'image_full_screen.dart';

class BookDetail extends StatelessWidget {
  final double imageHeight = 240;
  final double imageWidth = 0;
  final BookEntity bookEntity;

  BookDetail({this.bookEntity});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Column(
          children: <Widget>[
            Expanded(
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverPersistentHeader(
                      delegate: _MySliverAppBar(
                          imageHeight: imageHeight,
                          ratio: bookEntity.imageRatio,
                          logoUrl: bookEntity.thumbUrl,
                      title: bookEntity.name),
                      pinned: true,
                      floating: true,
                    )
                  ];
                },
                body: Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                      SizedBox(
                      height: 28,
                    ),
                      Text("${bookEntity.name}",
                          style: TextStyle(fontSize: 24, color: Colors.black)),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "${bookEntity.author}",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
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
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                bookEntity.pageCount,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                S.of(context).page,
                                style:
                                TextStyle(fontSize: 14, color: Colors.grey),
                              )
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                bookEntity.language,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                S.of(context).language,
                                style:
                                TextStyle(fontSize: 14, color: Colors.grey),
                              )
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                bookEntity.releaseTime,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                S.of(context).release,
                                style:
                                TextStyle(fontSize: 14, color: Colors.grey),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Html(
                        defaultTextStyle: TextStyle(fontFamily: 'serif'),
                        data: bookEntity.description,
                      )]
                    )
                  ),
                ),
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
  final double imageHeight;
  final String ratio;
  final String logoUrl;
  final String title;
  double expandedHeight;

  _MySliverAppBar({@required this.imageHeight, @required this.ratio, @required this.logoUrl, @required this.title});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    expandedHeight = imageHeight + kToolbarHeight;
    double opacity = 0;
    if(shrinkOffset < (expandedHeight - minExtent + 50)) {
      opacity = 0;
    } else {
      opacity = 1;
    }

    double centerScreen = MediaQuery.of(context).size.width / 2;
    var imageWidth = calculateWidthLogoByRatio(context, ratio);
    var leftPositionImage = centerScreen - (imageWidth / 2);
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
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  iconSize: 24,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Center(
                child: Opacity(
                  opacity: opacity,
                  child: Text(
                    this.title,
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
          top: expandedHeight - imageHeight - shrinkOffset,
          left: leftPositionImage,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: widgetLogoBook(context, this.logoUrl, imageWidth.toDouble()),
          ),
        )
      ],
    );
  }

  int calculateWidthLogoByRatio(BuildContext context, String ratio) {
    var imageRatioSplit = ratio.split(":");
    int imageWidth = MediaQuery.of(context).size.width ~/ 2 ;
    if(imageRatioSplit.length > 1) {
      imageWidth = imageHeight * int.parse(imageRatioSplit[0]) ~/ int.parse(imageRatioSplit[1]);
    }
    if (imageWidth >= MediaQuery.of(context).size.width) {
      imageWidth = (MediaQuery.of(context).size.width - 30).toInt();
    }
    return imageWidth;
  }

  Widget widgetLogoBook(BuildContext context, String logoUrl, double imageWidth) {
    String tag = "logoBook";
    return Hero(
      tag: tag,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, PageRouteBuilder(opaque: false, pageBuilder: (_,ab,c) {
            return ImageFullScreen(tag: tag, imageUrl: logoUrl);
          }));
        },
        child: Container(
          width: imageWidth,
          height: imageHeight,
          child: Card(
              semanticContainer: true,
              elevation: 10,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Image.network(
                logoUrl,
                fit: BoxFit.fill,
              )),
        ),
      ),
    );
  }

  @override
  double get maxExtent => imageHeight + kToolbarHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
