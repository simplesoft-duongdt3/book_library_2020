import 'package:booklibrary2020/features/main/book_detail.dart';
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
        margin: EdgeInsets.all(8.0),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.network(
                item.thumbUrl,
                width: 80,
                height: 80,
              ),
            ),
            SizedBox(width: 5,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    item.categoryName,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    item.name,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    item.author,
                    style: TextStyle(
                        fontSize: 15,
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