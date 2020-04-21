import 'package:booklibrary2020/features/main/book_list_without_state_management.dart';
import 'package:flutter/material.dart';

import 'book_list_setstate.dart';
import 'book_list_streambuilder.dart';

class DemoMain extends StatefulWidget {
  DemoMain({Key key}) : super(key: key);

  @override
  _DemoMainState createState() => _DemoMainState();
}

class _DemoMainState extends State<DemoMain> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueAccent,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BookListWithoutStateManagement()),
                );
              },
              child: Text(
                "1. Book list without state management",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueAccent,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookListSetState()),
                );
              },
              child: Text(
                "2. Book list setState",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueAccent,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BookListStreamBuilder()),
                );
              },
              child: Text(
                "3. Book list streambuilder",
                style: TextStyle(fontSize: 20.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
