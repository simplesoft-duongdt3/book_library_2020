import 'package:booklibrary2020/data/models/book.dart';
import 'package:booklibrary2020/data/models/language.dart';
import 'package:booklibrary2020/features/main/book_detail.dart';
import 'package:booklibrary2020/features/main_app/bloc/language_bloc.dart';
import 'package:booklibrary2020/features/main_app/bloc/language_event.dart';
import 'package:booklibrary2020/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_bar_custom.dart';
import 'demo_home_screen.dart';
import 'home_screen.dart';

class MainScreen extends StatelessWidget {
  static final screenName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).app_name),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: DemoMain(),
      floatingActionButton: FloatingActionButton(
        tooltip: S.of(context).change_language,
        child: Icon(Icons.language),
        onPressed: () {
          changeLanguage(context);
        },

      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void changeLanguage(BuildContext context) {
    var currentLanguage =
        BlocProvider.of<LanguageBloc>(context).getCurrentLanguage();
    switch (currentLanguage) {
      case Language.vietnamese:
        BlocProvider.of<LanguageBloc>(context)
            .add(new ChangeLanguageEvent(Language.english));
        break;
      case Language.english:
        BlocProvider.of<LanguageBloc>(context)
            .add(new ChangeLanguageEvent(Language.vietnamese));
        break;
    }
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
    // TODO: implement initState
    super.initState();
    listScreens = [
      HomeScreen(),
      Text("BCD"),
      Text("EFE"),
      Text("ABC"),
    ];
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        body: listScreens[_selectedIndex],
        bottomNavigationBar: BottomBarCustom(
          selectedIndex: _selectedIndex,
          showElevation: true, // use this to remove appBar's elevation
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
          }),
          itemCornerRadius: 0,
          items: [
            BottomBarItemCustom(
              icon: Icon(Icons.apps),
              title: Text('Home'),
              activeColor: Colors.indigoAccent,
            ),
            BottomBarItemCustom(
                icon: Icon(Icons.people),
                title: Text('Users'),
                activeColor: Colors.purpleAccent
            ),
            BottomBarItemCustom(
                icon: Icon(Icons.message),
                title: Text('Messages'),
                activeColor: Colors.pink
            ),
            BottomBarItemCustom(
                icon: Icon(Icons.settings),
                title: Text('Settings'),
                activeColor: Colors.blue
            ),
          ],
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
