import 'package:flutter/material.dart';
import 'package:flutter_card/pages/loginPage.dart';

class NavigatorUtils {
  static void goPwdLogin(context) {
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (context) => new loginPage()));
    // Navigator.of(context).pushAndRemoveUntil(
    //     new MaterialPageRoute(builder: (context) => new MyAppLogin()),
    //     (route) => route == null);
  }
}
