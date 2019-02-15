import 'package:flutter/material.dart';
import 'cardmyPage.dart';
import 'package:flutter_card/util/SharedPreferenceUtil.dart';
import 'package:flutter_card/models/user.dart';
// import 'package:flutter_card/pages/loginPage.dart';
import 'package:flutter_card/event/LoginEvent.dart';
import 'package:flutter_card/globalConfig/global_config.dart';

class indexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    // SharedPreferenceUtil.getUser();
    return indexPageState();
  }
}

class indexPageState extends State<indexPage> {
  List<ListItem> list = [
    new headerItem(),
    new dividerItem(),
    new nomalItem(title: '名片个人信息', subTitle: '姓名,手机,职位 '),
    new dividerItem(),
    new nomalItem(title: '名片风格', subTitle: '名片主题,背景,音乐 '),
    new dividerItem(),
    new singleTitleItem(title: '名片标题'),
    new dividerItem(),
    new singleTitleItem(title: '显示设置'),
    new dividerItem(),
    new singleTitleItem(title: '互联云名片二维码')
  ];
  static const double IMAGE_ICON_WIDTH = 30.0;
  static const double ARROW_ICON_WIDTH = 16.0;

  final rightArrowIcon = new Icon(IconData(0xe642, fontFamily: 'iconfont'),
      size: 18.0, color: const Color.fromARGB(255, 195, 195, 195));
  var isOpen = false;
  User user = new User();
  void getUser() async {
    user = await SharedPreferenceUtil.getUser();
    setState(() {
      user = user;
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
    GlobalConfig.eventBus.on<LoginEvent>().listen((event){
      print('LoginEvent');
      getUser();
    });
  }

  void _toCardMy(BuildContext context) {
    Navigator.push(context, new MaterialPageRoute(builder: (context) {
      return new cardmyPage();
      // return new loginPage();
    }));
  }

  // GlobalConfig.eventBus

  Widget getHeaderWidget(context) {
    return new Container(
      constraints: BoxConstraints.expand(
        height: isOpen ? 300 : 200,
      ),
      padding: EdgeInsets.only(top: 30),
      child: GestureDetector(
          onTap: () => _toCardMy(context),
          child: new Container(
            padding: EdgeInsets.only(bottom: 10),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Icon(IconData(0xe643, fontFamily: 'iconfont'),
                        color: Color.fromARGB(255, 248, 226, 171)),
                    new Text(
                      '互联云名片',
                      style: new TextStyle(
                          fontSize: 13,
                          color: Color.fromARGB(255, 248, 226, 171)),
                    ),
                    new Padding(
                      padding: EdgeInsets.only(top: 3, right: 2),
                      child: new Icon(IconData(0xe746, fontFamily: 'iconfont'),
                          color: Color.fromARGB(255, 248, 226, 171)),
                    ),
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(user.portrait??'http://cdn.hlymp.com/622095b4-4134-139a-145c-f9e0a7d17ecb'))
                          // borderRadius: BorderRadius.circular(25)
                          ),
                    )
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      user.cardName ?? '',
                      style: new TextStyle(
                          fontSize: 17,
                          color: Color.fromARGB(255, 248, 226, 171)),
                    )
                  ],
                )
              ],
            ),
            margin: EdgeInsets.only(left: 30, right: 30, bottom: 20, top: 20),
            // color: Color.fromARGB(255, 222, 12, 22),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                gradient: LinearGradient(colors: [
                  const Color.fromARGB(255, 23, 23, 26),
                  const Color.fromARGB(255, 66, 67, 71),
                ])),
          )),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage('http://cdn.hlymp.com/dwdaw-dadawd-dwd.png')),
          gradient: LinearGradient(colors: [
            const Color.fromARGB(255, 43, 133, 254),
            const Color.fromARGB(255, 3, 179, 254),
          ])),
    );
  }

  Widget getCell(index,context) {
    final item = list[index];
    if (item is nomalItem) {
      return new Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: new Row(
          children: <Widget>[
            new Expanded(
                flex: 3,
                child: new Text(
                  item.title,
                  style: TextStyle(color: Color.fromARGB(255, 51, 51, 51)),
                )),
            new Expanded(
              flex: 2,
              child: new Text(
                item.subTitle,
                style: new TextStyle(
                    color: Color.fromARGB(255, 195, 195, 195), fontSize: 13),
                textAlign: TextAlign.right,
              ),
            ),
            rightArrowIcon
          ],
        ),
      );
    } else if (item is singleTitleItem) {
      return new Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: new Row(
          children: <Widget>[
            new Expanded(
                child: new Text(
              item.title,
              style: TextStyle(color: Color.fromARGB(255, 51, 51, 51)),
            )),
            rightArrowIcon
          ],
        ),
      );
    } else if (item is dividerItem) {
      return new Divider();
    } else {
      return getHeaderWidget(context);
    }
  }

  List <Widget> getItems (context) {
    List <Widget> cellList = [];
    for(int i = 0; i < list.length; i++) {
      cellList.add(getCell(i, context));
    }
    return cellList;
  }

  @override
  Widget build(BuildContext context) {
    // final double topPadding = MediaQuery.of(context).padding.top;
    return new Scaffold(
        body: new Container(
      child: new SingleChildScrollView(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: getItems(context),
        ),
      ),
    ));
  }
}

class nomalItem implements ListItem {
  String title;
  String subTitle;
  nomalItem({this.title, this.subTitle});
}

class singleTitleItem implements ListItem {
  String title;
  singleTitleItem({String title}) {
    this.title = title;
  }
}

class dividerItem implements ListItem {
  dividerItem();
}

class headerItem implements ListItem {
  headerItem();
}

abstract class ListItem {}
