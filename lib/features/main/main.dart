import 'package:booklibrary2020/data/models/language.dart';
import 'package:booklibrary2020/features/main/book_list/book_list.dart';
import 'package:booklibrary2020/features/main_app/bloc/language_bloc.dart';
import 'package:booklibrary2020/features/main_app/bloc/language_event.dart';
import 'package:booklibrary2020/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_bar_custom.dart';
import 'category_list/category_list.dart';
import 'setting/setting.dart';

class MainScreen extends StatelessWidget {
  static final screenName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).app_name),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: MyHomePage(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  var _selectedIndex = 0;
  List<Widget> listScreens;

  @override
  void initState() {
    super.initState();
    listScreens = [
      BookList(categoryId: 0, isShowSearchBox: false),
      CategoryList(),
      BookList(categoryId: 0, isShowSearchBox: true),
      Setting(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listScreens[_selectedIndex],
      bottomNavigationBar: BottomBarCustom(
        selectedIndex: _selectedIndex,
        showElevation: true,
        // use this to remove appBar's elevation
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        itemCornerRadius: 0,
        items: [
          BottomBarItemCustom(
            icon: Icon(Icons.fiber_new),
            title: Text(S.of(context).main_newest_tab),
            activeColor: Colors.indigoAccent,
          ),
          BottomBarItemCustom(
              icon: Icon(Icons.category),
              title: Text(S.of(context).main_category_tab),
              activeColor: Colors.purpleAccent),
          BottomBarItemCustom(
              icon: Icon(Icons.search),
              title: Text(S.of(context).main_search_tab),
              activeColor: Colors.pink),
          BottomBarItemCustom(
              icon: Icon(Icons.settings),
              title: Text(S.of(context).main_setting_tab),
              activeColor: Colors.blue),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
