import 'package:booklibrary2020/features/main/book_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:booklibrary2020/data/models/book.dart';
import 'package:flutter/widgets.dart';

class BookListItem extends StatelessWidget {
  final BookEntity item;

  const BookListItem ({
    Key key,
    this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => BookDetail(bookEntity: item)));
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(28, 8, 28, 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.grey, width: 0.3)),
              width: 80,
              height: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error_outline, color: Colors.red, size: 28,),
                  imageUrl: item.thumbUrl,
                  width: 80,
                  height: 80,
                ),
              ),
            ),
            SizedBox(width: 16,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    item.categoryName,
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.black
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    item.name,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    item.author,
                    style: TextStyle(
                        fontSize: 13,
                        color: Color.fromRGBO(135, 135, 135, 1.0)
                    ),
                  )
                ],
              ),
            ),
            Icon(Icons.keyboard_arrow_right),
          ],
        ),

      ),
    );
  }

}