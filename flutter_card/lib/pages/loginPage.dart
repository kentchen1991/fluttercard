import 'package:flutter/material.dart';
import 'package:flutter_card/util/ApiInterface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_card/models/user.dart';
import 'package:flutter_card/util/SharedPreferenceUtil.dart';
import './MainPage.dart';
import 'package:flutter_card/event/LoginEvent.dart';
import 'package:flutter_card/globalConfig/global_config.dart';

// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class MyAppLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        body: loginPage(),
      ),
    );
  }
}

class loginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return loginPageState();
  }
}

class loginPageState extends State<loginPage> {
  TextEditingController _phoneController = new TextEditingController(text: '');
  TextEditingController _pwdController = new TextEditingController(text: '');
  @override
  void initState() {
    super.initState();
    //监听输入改变
    _phoneController.addListener(() {
      print(_phoneController.text);
    });
    _pwdController.addListener(() {
      print(_pwdController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return new Scaffold(
      // appBar: new AppBar(
      //   title: new Text("登录", style: new TextStyle(color: Colors.white)),
      //   iconTheme: new IconThemeData(color: Colors.white),
      // ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            const Color.fromARGB(255, 43, 133, 254),
            const Color.fromARGB(255, 3, 179, 254),
          ])),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                right: 0,
                height: 175,
                // width: ,
                child: new Image.network(
                    'http://cdn.hlymp.com/dwdaw-dadawd-dwd.png'),
              ),
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(color: Color.fromARGB(0, 0, 0, 0)),
                child: SafeArea(
                    child: new Padding(
                  padding: EdgeInsets.all(30),
                  child: ListView(
                    children: <Widget>[
                      new Text(
                        '欢迎你！',
                        style: new TextStyle(
                            fontSize: 30,
                            // fontFamily: ,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      new Container(
                        decoration: BoxDecoration(
                            // 下滑线浅灰色，宽度1像素
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.white, width: 1.0))),
                        child: TextField(
                          // autofocus: true,
                          controller: _phoneController,

                          decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  color: Colors.white, fontSize: 13.0),
                              border: InputBorder.none, //隐藏下划线
                              // labelText: "用户名",
                              hintText: "请输入手机号码",
                              prefixIcon: Icon(Icons.phone)),
                        ),
                      ),
                      new Container(
                        decoration: BoxDecoration(
                            // 下滑线浅灰色，宽度1像素
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.white, width: 1.0))),
                        child: TextField(
                          controller: _pwdController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              // labelText: "密码",
                              hintText: "请输入密码",
                              prefixIcon: Icon(Icons.lock)),
                          obscureText: true,
                        ),
                      ),
                      new Container(
                        margin: EdgeInsets.only(top: 40),
                        // padding:
                        height: 30,
                        width: 300,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: FlatButton(
                          // shape: Border.all(width: 10,color: Color.fromARGB(255, 0, 255, 255),style: BorderStyle.solid),
                          onPressed: () {
                            print(_phoneController.text);
                            print(_pwdController.text);
                            ApiInterface.login(
                                    _phoneController.text, _pwdController.text)
                                .then((data) {
                              // print('success');
                              // print(User.fromJson(data));
                              SharedPreferenceUtil.saveUser(User.fromJson(data));
                              Navigator.of(context).pushAndRemoveUntil(
                                  new MaterialPageRoute(
                                      builder: (context) => new MyApp()),
                                  (route) => route == null);
                              GlobalConfig.eventBus.fire(new LoginEvent());
                            }).catchError((onError) {
                              print('err');
                            });
                          },
                          color: Color.fromARGB(255, 255, 255, 255),
                          child: new Text(
                            '登录',
                            style: new TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ),
                      )
                    ],
                  ),
                )
            
                    ),
              )
            ],
          )
          ),
    );
    
  }
}
