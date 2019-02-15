import 'NetUtil.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class ApiParams {
  static final String API_GET_SMS = "user/sendPhoneSms";
  static final String API_SET_PPWD = "user/set/word";
  static final String APILogin = "mp/cus/land";
  static final String APIgetLibraryOrRec = "mp/article/getLibraryOrRec";
}

/// 所有接口请求
class ApiInterface {
  /// 登陆
  static Future<Map<String, dynamic>> login(String phone, String pwd) async {
    return NetUtil.postForm(ApiParams.APILogin, {"phone": phone, "pwd": generateMd5(pwd)});
  }

  /// 短信验证码
  static Future<Map<String, dynamic>> getSmsCode(
      String flag, String phoneNum, String vefifyCode) async {
    /// 调用封装的NetUtil ，这里合理选择方法即可，比如请求体的方式传参数
    return NetUtil.postJson(ApiParams.API_GET_SMS,
        {"flagId": flag, "phone": phoneNum, "vefifyCode": vefifyCode});
  }

  /// 获取文章
  static Future<Map<String, dynamic>> getLibraryOrRec(LoginInvalidHandler handler,int type) async {
    return NetUtil.postForm(ApiParams.APIgetLibraryOrRec, {"type": type}).catchError(handler.loginInvalidHandler);
  }

  /// 在需要进行登录校验的接口上进行LoginInvalidHandler  异常检测
  ///     LoginInvalidHandler handler 带token过期  自动进入登录页的 检测
  /// 这里使用的putForm ，即表单方式传递参数

  static Future<Map<String, dynamic>> tradepassword(LoginInvalidHandler handler,
      String tradePassword, String checkTradePassword) async {
    return NetUtil.putForm(ApiParams.API_SET_PPWD, {
      'tradePassword': tradePassword,
      'checkTradePassword': checkTradePassword
    }).catchError(handler.loginInvalidHandler);
  }

  // md5 加密
  static String generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    // 这里其实就是 digest.toString()
    return hex.encode(digest.bytes);
  }
}
