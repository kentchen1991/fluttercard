import 'package:flutter/material.dart';
import 'package:flutter_card/util/ApiInterface.dart';
import 'package:flutter_card/util/NetUtil.dart';

class articlesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return articlesPageState();
  }
}

class articlesPageState extends State<articlesPage> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  BuildContext _context;
  void getData() {
    new Future.delayed(const Duration(seconds: 1), () => requestData());
  }

  void requestData() async {
    print('请求数据');
    print(_context);
    LoginInvalidHandler login = new LoginInvalidHandler(_context);
    ApiInterface.getLibraryOrRec(login, 0).then((data) {
      print(data);
    }).catchError((onError) {});
  }

  Widget getItem(asset, title) {
    return new Expanded(
      flex: 1,
      child: new Column(
        children: <Widget>[
          new Image.asset(
            asset,
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
          new Text(title)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _context = context;
    });
    final double screenW = MediaQuery.of(context).size.width;
    final double screenH = MediaQuery.of(context).size.height;
    final double listH = MediaQuery.of(context).size.height - 100 - 60;
    final TextEditingController _controller = new TextEditingController();
    List<ListItem> list = [new cellItem(), new marginItem(), new cellItem()];
    Widget getCell() {
      return new Padding(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: new Row(
          children: <Widget>[
            new Expanded(
                child: new Container(
              margin: EdgeInsets.only(left: 10.0),
              width: 150,
              height: 100,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(
                          "http://cdn.hlymp.com/e2303f28-7134-1398-ec8b-0b5da8a3f9fc"))),
            )),
            new Expanded(
              child: new Padding(
                padding: const EdgeInsets.all(8),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text('公司简介,公司简介,公司简介'),
                    new Text('2019-01-10 15:51:52'),
                  ],
                ),
              ),
            )
            //
          ],
        ),
      );
    }

    Widget marginCell() {
      return new Container(
        width: screenW,
        height: 5,
        color: Color.fromARGB(255, 247, 247, 247),
      );
    }

    Widget getSearch() {
      return new Stack(
        children: <Widget>[
          new Positioned(
            left: 50,
            top: 50,
            child: new Container(
              height: 30,
              width: screenW - 100,
              child: new Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                // width: screenW - 100,
                child: FlatButton(
                    onPressed: () {
                      print('文章搜索');
                    },
                    child: Text('文章搜索')),
                // decoration: new BoxDecoration(
                //   borderRadius: BorderRadius.circular(15)
                // ),
              ),
            ),
          )
        ],
      );
    }

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromARGB(255, 3, 179, 254),
        title: new Text("软文"),
      ),
      body: new Container(
        width: screenW,
        height: screenH,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Container(
              height: 100,
              width: screenW,
              padding: EdgeInsets.only(left: 0, right: 0),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'http://cdn.hlymp.com/dwdaw-dadawd-dwd.png')),
                  gradient: LinearGradient(colors: [
                    const Color.fromARGB(255, 3, 179, 254),
                    const Color.fromARGB(255, 43, 133, 254)
                  ])),
              child: getSearch(),
              // child: new Padding(
              //   padding: const EdgeInsets.all(20.0),
              //   child: new TextField(
              //     controller: _controller,
              //     cursorRadius: Radius.circular(20),
              //     decoration: new InputDecoration(
              //       hintText: '搜索',
              //     ),
              //   ),
              // ),
            ),
            new Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: new Row(
                children: <Widget>[
                  getItem('images/recom.png', '精选推荐'),
                  getItem('images/manager.png', '信息管理'),
                  getItem('images/publish.png', '发布软文')
                ],
              ),
            ),
            new Container(
              padding: EdgeInsets.only(left: 30),
              width: screenW,
              height: 50,
              child: new Text('企业文章',
                  textAlign: TextAlign.left,
                  style: new TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 0, 0, 0),
                  )),
            ),
            new Container(
              width: screenW,
              //  padding: EdgeInsets.all(0),
              //  margin: EdgeInsets.only(bottom: 0,left: 0,right: 0,top: 0),
              height: listH - 254,
              //  decoration: BoxDecoration(
              //    color: Color.fromARGB(255, 0, 0, 0)
              //  ),
              child: new ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  // return getCell();
                  final item = list[index];
                  if (item is marginItem) {
                    return marginCell();
                  } else {
                    return getCell();
                  }
                  // return GetNomallCell();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

abstract class ListItem {}

class marginItem implements ListItem {}

class cellItem implements ListItem {}
