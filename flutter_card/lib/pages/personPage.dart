import 'package:flutter/material.dart';
import 'package:flutter_card/util/SharedPreferenceUtil.dart';
import 'package:flutter_card/models/user.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:sy_flutter_qiniu_storage/sy_flutter_qiniu_storage.dart';

class personPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return personPageState();
  }
}

class personPageState extends State {
  User user = new User();
  void getUser() async {
    user = await SharedPreferenceUtil.getUser();
    setState(() {
      user = user;
    });
  }

  void initState() {
    super.initState();
    getUser();
  }

  final rightArrowIcon = new Icon(IconData(0xe642, fontFamily: 'iconfont'),
      size: 18.0, color: const Color.fromARGB(255, 195, 195, 195));
  List<ListItem> nomallist = [
    new singleTitleItem(title: '手机号码'),
    new dividerItem(),
    new singleTitleItem(title: '登录密码'),
    new dividerItem(),
    new singleTitleItem(title: '隐私设置'),
    new dividerItem(),
    new singleTitleItem(title: '绑定微信'),
    new dividerItem(),
    new singleTitleItem(title: '我的公司')
  ];
  File _image;
  Future getImage() async {
    /// ios 记得要填写plist
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    String token =
        'qhApHZzTRglz0RRCUgUu4Qn3JDhVe552aw2E9-IH:SwCR3OBanDKfNRIH7vsao4xg2Vw=:eyJkZWFkbGluZSI6MzUzOTcyMzQxNSwic2NvcGUiOiJtcC1yZXNvdXJjZSJ9';

    if (image == null) {
      return;
    }
    final syStorage = new SyFlutterQiniuStorage();
    //监听上传进度
    syStorage.onChanged().listen((dynamic percent) {
      double p = percent;
      print(p);
    });

    String key = DateTime.now().millisecondsSinceEpoch.toString() +
        '.' +
        image.path.split('.').last;
    print(key);
    //上传文件
    bool result = await syStorage.upload(image.path, token, key);
    print(result); //true 上传成功，false失败
  }

  @override
  Widget build(BuildContext context) {
    final double screenW = MediaQuery.of(context).size.width;
    final double screenH = MediaQuery.of(context).size.height;
    //TODO: 获取头部
    Widget getHeaderCell() {
      return new Container(
        height: 200,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              const Color.fromARGB(255, 3, 179, 254),
              const Color.fromARGB(255, 43, 133, 254)
            ]),
            // shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.fill,
                image:
                    NetworkImage('http://cdn.hlymp.com/dwdaw-dadawd-dwd.png'))),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: new Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(colors: [
                const Color.fromARGB(255, 66, 67, 71),
                const Color.fromARGB(255, 23, 23, 26)
              ]),
            ),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Padding(
                  padding: EdgeInsets.all(4),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Icon(IconData(0xe743, fontFamily: 'iconfont'),
                          color: Color.fromARGB(255, 248, 226, 171)),
                      new Container(
                        padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                topRight: Radius.circular(5)),
                            color: Color.fromARGB(100, 244, 222, 167)),
                        child: Text(
                          'VIP用户',
                          style: new TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      )
                    ],
                  ),
                ),
                new Row(
                  children: <Widget>[
                    new GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: new Container(
                        width: 50,
                        height: 50,
                        margin: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: _image == null
                                    ? NetworkImage(user.portrait ??
                                        'http://f.hiphotos.baidu.com/image/pic/item/9f510fb30f2442a79cac5e59dc43ad4bd01302af.jpg')
                                    : FileImage(_image))
                            // borderRadius: BorderRadius.circular(25)
                            ),
                      ),
                    ),
                    new Container(
                      margin: EdgeInsets.only(left: 20),
                      child: new Text(
                        user.cardName ?? '',
                        style: new TextStyle(
                            fontSize: 17,
                            color: Color.fromARGB(255, 248, 226, 171)),
                      ),
                    )
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: new Text(
                        "NO. ${user.phone}",
                        style: new TextStyle(
                            fontSize: 17,
                            color: Color.fromARGB(255, 248, 226, 171)),
                      ),
                    ),
                    new Padding(
                        padding: EdgeInsets.only(left: 30),
                        child: FlatButton(
                            onPressed: () {
                              print('文章搜索');
                            },
                            child: Text(
                              '续费',
                              style: new TextStyle(
                                  fontSize: 17,
                                  color: Color.fromARGB(255, 248, 226, 171)),
                            ))),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    }

    Widget getItemDetails(String title, int icon) {
      return Container(
        // color: Color.fromARGB(255, 0, 0, 0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Icon(IconData(icon, fontFamily: 'iconfont'),
                color: Color.fromARGB(255, 3, 179, 254)),
            new Text(
              title,
              style: TextStyle(color: Color.fromARGB(255, 51, 51, 51)),
            )
          ],
        ),
      );
    }

    List<Container> _buildGridTileList = [
      getItemDetails('钱包', 0xe72d),
      getItemDetails('企业名片', 0xe73f),
      getItemDetails('镜像同步', 0xe740),
      getItemDetails('我推荐的', 0xe745),
      getItemDetails('名片屏保', 0xe63f),
      getItemDetails('消息', 0xe737),
    ];

    Widget buildGrid() {
      return new GridView.count(
          physics: new NeverScrollableScrollPhysics(),
          crossAxisCount: 4,
          padding: EdgeInsets.zero,
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
          children: _buildGridTileList);
    }

    //TODO: 获取企业文章
    Widget getItems() {
      return new Column(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.only(left: 30, top: 5),
            width: screenW,
            height: 40,
            child: new Text('我的工具',
                textAlign: TextAlign.left,
                style: new TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 0, 0, 0),
                )),
          ),
          new Container(
            width: screenW,
            height: 190,
            child: buildGrid(),
          )
          // buildGrid()
        ],
      );
    }

    Widget getListCell(ListItem item) {
      // final item = list[index - 2];
      if (item is singleTitleItem) {
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
                child: new Container(),
              ),
              rightArrowIcon
            ],
          ),
        );
      } else {
        return new Divider();
      }
    }

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromARGB(255, 3, 179, 254),
        title: new Text("我的"),
      ),
      // body: Text('data'),
      body: new ListView.builder(
        itemCount: 11,
        itemBuilder: (context, index) {
          if (index == 0) {
            return getHeaderCell();
          } else if (index == 1) {
            return getItems();
          } else {
            final item = nomallist[index - 2];
            return getListCell(item);
          }
        },
      ),
    );
  }
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

abstract class ListItem {}
