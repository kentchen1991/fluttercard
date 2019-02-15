import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_card/util/SharedPreferenceUtil.dart';
import 'package:flutter_card/models/user.dart';

class cardmyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new cardmyPageState();
  }
}

class cardmyPageState extends State<cardmyPage> {
  User user = new User();
  var url = "";
  void getUser() async {
    user = await SharedPreferenceUtil.getUser();
    setState(() {
      user = user;
      url =
          "https://www.hlymp.com/vip/index.html#/cardmy?share_user_id=${user.id}";
    });
  }

  bool loaded = false;
  String detailDataStr;
  final flutterWebViewPlugin = new FlutterWebviewPlugin();
  @override
  void initState() {
    super.initState();
    getUser();
    // 监听WebView的加载事件
    flutterWebViewPlugin.onStateChanged.listen((state) {
      print("state: ${state.type}");
      if (state.type == WebViewState.finishLoad) {
        // 加载完成
        setState(() {
          loaded = true;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flutterWebViewPlugin.close();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> titleContent = [];
    titleContent.add(new Text(
      "名片",
      style: new TextStyle(color: Colors.yellow),
    ));
    if (!loaded) {
      titleContent.add(new CupertinoActivityIndicator());
    }
    print(url);
    return new Scaffold(
      body: Container(
        child: WebviewScaffold(
            appBar: AppBar(title: Text('data'),),
            url: url,
            withZoom: false,
            withLocalStorage: true,
            withJavascript: true,
          ),
      ),
    );
  }
}
