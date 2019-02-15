import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'pages/loginPage.dart';
import 'pages/MainPage.dart';
import 'package:flutter_card/util/SharedPreferenceUtil.dart';
// import 'package:flutter_card/models/user.dart';

void main() async {
  return runApp(new MyApp());

  /// 模态跳转 键盘会有bug 
  // bool user = await SharedPreferenceUtil.getIsLogin();
  // if(user) {
  //   return runApp(new MyApp());
  // } else {
  //   return runApp(new MyAppLogin());
  // }
}


