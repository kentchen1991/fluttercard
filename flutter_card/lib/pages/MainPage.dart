
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './articlesPage.dart';
import './indexPage.dart';
import './personPage.dart';
import 'package:flutter_card/globalConfig/global_config.dart';

class MyApp extends StatefulWidget {
  @override
  createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  final appBarTitles = ['名片', '软文', '我的'];
  final tabTextStyleNormal =
      new TextStyle(color: const Color.fromARGB(255, 87, 107, 149),fontSize: 14);
  final tabTextStyleSelected =
      new TextStyle(color: const Color.fromARGB(255, 3, 179, 254),fontSize: 14);
  var _body;
  int _tabIndex = 0;
  var tabImages;
  var pages = <Widget>[new indexPage(), new articlesPage(), new personPage()];

  @override
  void initState() {
    super.initState();
    if (tabImages == null) {
      tabImages = [
        [getTabImage(0xe730), getTabImage(0xe736)],
        [getTabImage(0xe733), getTabImage(0xe735)],
        [getTabImage(0xe732), getTabImage(0xe734)]
      ];
    }
  }

  TextStyle getTabTextStyle(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabTextStyleSelected;
    }
    return tabTextStyleNormal;
  }

  Text getTabTitle(int idx) {
    return new Text(appBarTitles[idx], style: getTabTextStyle(idx));
  }

  IconData getTabImage(int unicode) {
    return IconData(unicode, fontFamily: 'iconfont');
  }

  Icon getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return new Icon(tabImages[curIndex][1],
          size: 18.0, color: const Color.fromARGB(255, 3, 179, 254));
    }
    return new Icon(tabImages[curIndex][0],
        size: 18.0, color: const Color.fromARGB(255, 87, 107, 149));
  }

  @override
  Widget build(BuildContext context) {
    _body = new IndexedStack(children: pages, index: _tabIndex);
    return new MaterialApp(
      
      home: new Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Color.fromARGB(255, 3, 179, 254),
        // ),
        body: _body,
        bottomNavigationBar: CupertinoTabBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: getTabIcon(0), title: getTabTitle(0)),
            BottomNavigationBarItem(icon: getTabIcon(1), title: getTabTitle(1)),
            BottomNavigationBarItem(icon: getTabIcon(2), title: getTabTitle(2)),
          ],
          currentIndex: _tabIndex,
          onTap: (index) {
            setState(() {
              _tabIndex = index;
            });
          },
        ),
      ),
      // theme: GlobalConfig.themeData
    );
  }
}
