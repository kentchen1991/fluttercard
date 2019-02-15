import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_card/models/user.dart';
import 'dart:convert';

class SharedPreferenceUtil {
  static void saveUser(User user) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    final jsonStr = json.encode(user);
    sp.setString('myUser', jsonStr);
    sp.setBool('Login', true);
  }

  //  static void saveUserFromJson(Map<String,dynamic> json) async {
  //   SharedPreferences sp = await SharedPreferences.getInstance();
  //   final jsonStr = json.encode(user);
  //   sp.setString('myUser', jsonStr);
  //   sp.setBool('Login', true);
  // }

  static Future<bool> getIsLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var islogin = sp.getBool('Login');
    islogin = islogin ?? false;
    print(islogin);
    return islogin;
  }

  static Future<User> getUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    final jsonModel = sp.getString('myUser');
    // print(jsonModel);
    Map userMap = json.decode(jsonModel);
    User user = new User.fromJson(userMap);
    return user;
  }

  static Future<String> getToken() async {
    bool user = await SharedPreferenceUtil.getIsLogin();
    print(user);
    if(!user) {
      return '';
    }
    SharedPreferences sp = await SharedPreferences.getInstance();
    final jsonModel = sp.getString('myUser');
    // print(jsonModel);
    Map userMap = json.decode(jsonModel);
    return userMap['token'];
  }
}
