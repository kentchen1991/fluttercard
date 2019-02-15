import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'SharedPreferenceUtil.dart';
import 'NavigatorUtils.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NetUtil {
  static final debug = true;
  // static BuildContext context = null;
  /// 服务器路径
  // static final host = 'https://www.hlymp.com';
  static final host = 'http://117.25.148.123:38081';
  static final baseUrl = host + '/';

  ///  基础信息配置
  static final Dio _dio = new Dio(new Options(
      method: "get",
      baseUrl: baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 5000,
      followRedirects: true));

  /// 代理设置，方便抓包来进行接口调节

//  static void setProxy() {
//    _dio.onHttpClientCreate = (HttpClient client) {
//      // config the http client
//      client.findProxy = (uri) {
//        //proxy all request to localhost:8888
//        return "PROXY 192.168.1.151:8888";
//      };
//      // you can also create a new HttpClient to dio
//      // return new HttpClient();
//    };
//  }

  static String token;

  static final LogicError unknowError = LogicError(-1, "未知异常");

  static Future<Map<String, dynamic>> getJson<T>(
          String uri, Map<String, dynamic> paras) =>
      _httpJson("get", uri, data: paras).then(logicalErrorTransform);

  static Future<Map<String, dynamic>> getForm<T>(
          String uri, Map<String, dynamic> paras) =>
      _httpJson("get", uri, data: paras, dataIsJson: false)
          .then(logicalErrorTransform);

  /// 表单方式的post
  static Future<Map<String, dynamic>> postForm<T>(
          String uri, Map<String, dynamic> paras) =>
      _httpJson("post", uri, data: paras, dataIsJson: false)
          .then(logicalErrorTransform);

  /// requestBody (json格式参数) 方式的 post
  static Future<Map<String, dynamic>> postJson(
          String uri, Map<String, dynamic> body) =>
      _httpJson("post", uri, data: body).then(logicalErrorTransform);

  static Future<Map<String, dynamic>> deleteJson<T>(
          String uri, Map<String, dynamic> body) =>
      _httpJson("delete", uri, data: body).then(logicalErrorTransform);

  /// requestBody (json格式参数) 方式的 put
  static Future<Map<String, dynamic>> putJson<T>(
          String uri, Map<String, dynamic> body) =>
      _httpJson("put", uri, data: body).then(logicalErrorTransform);

  /// 表单方式的 put
  static Future<Map<String, dynamic>> putForm<T>(
          String uri, Map<String, dynamic> body) =>
      _httpJson("put", uri, data: body, dataIsJson: false)
          .then(logicalErrorTransform);

  /// 文件上传  返回json数据为字符串
  static Future<T> putFile<T>(String uri, String filePath) {
    var name =
        filePath.substring(filePath.lastIndexOf("/") + 1, filePath.length);
    var suffix = name.substring(name.lastIndexOf(".") + 1, name.length);
    FormData formData = new FormData.from({
      "multipartFile": new UploadFileInfo(new File(filePath), name,
          contentType: ContentType.parse("image/$suffix"))
    });

    var enToken = token == null ? "" : Uri.encodeFull(token);
    return _dio
        .put<Map<String, dynamic>>("$uri?token=$enToken", data: formData)
        .then(logicalErrorTransform);
  }

  static Future<Response<Map<String, dynamic>>> _httpJson(
      String method, String uri,
      {Map<String, dynamic> data, bool dataIsJson = true}) async {
    // var enToken = token == null ? "" : Uri.encodeFull(token);
    var enToken = await getToken();
    print(enToken);

    /// 如果为 get方法，则进行参数拼接
    // if (method == "get") {
    //   dataIsJson = false;
    //   if (data == null) {
    //     data = new Map<String, dynamic>();
    //   }
    //   data["token"] = token;
    // }

    if (debug) {
      print('<net url>------$uri');
      print('<net params>------$data');
    }

    /// 根据当前 请求的类型来设置 如果是请求体形式则使用json格式
    /// 否则则是表单形式的（拼接在url上）
    Options op;
    if (dataIsJson) {
      op = new Options(contentType: ContentType.parse("application/json"));
    } else {
      op = new Options(
          contentType: ContentType.parse("application/x-www-form-urlencoded"));
    }

    op.method = method;
    // print(object)
    /// 统一带上token
    return _dio.request<Map<String, dynamic>>(
        method == "get" ? uri : "$uri?card_token=$enToken",
        data: data,
        options: op);
  }

  /// 对请求返回的数据进行统一的处理
  /// 如果成功则将我们需要的数据返回出去，否则进异常处理方法，返回异常信息
  static Future<T> logicalErrorTransform<T>(
      Response<Map<String, dynamic>> resp) {
    if (resp.data != null) {
      if (resp.data["status"] == 200) {
        T realData = resp.data["data"];
        return Future.value(realData);
      }
    }

    if (debug) {
      print('resp--------$resp');
      print('resp.data--------${resp.data}');
    }

    LogicError error;

    /// 判断有问题
    if (resp.data != null && resp.data["status"] != 200) {
      if (resp.data['data'] != null) {
        /// 失败时  错误提示在 data中时
        /// 收到token过期时  直接进入登录页面
        // Map<String, dynamic> realData = resp.data["data"];
        error = new LogicError(resp.data["status"], resp.data['msg']);
      } else {
        /// 失败时  错误提示在 message中时
        error = new LogicError(resp.data["status"], resp.data["msg"]);
      }
    } else {
      error = unknowError;
    }
    return Future.error(error);
  }

  ///获取授权token
  static Future<String> getToken() async {
    String token = await SharedPreferenceUtil.getToken();
    return token;
  }
}

/// 统一异常类
class LogicError {
  int errorCode;
  String msg;

  LogicError(errorCode, msg) {
    this.errorCode = errorCode;
    this.msg = msg;
  }
}

class LoginInvalidHandler {
  BuildContext currentContext;
  LoginInvalidHandler(this.currentContext);

  Future<Null> loginInvalidHandler(dynamic errorMsg) {
    if (errorMsg != null &&
        errorMsg is LogicError &&
        errorMsg.errorCode == 5102) {
      // print('您的登录已过期，请重新登录');
      // LocalStorage.clearLoginInfo();
      // Fluttertoast.showToast(
      //     msg: "您的登录已过期，请重新登录",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIos: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0);

      /// 进入登录页的路由跳转
      NavigatorUtils.goPwdLogin(currentContext);
      return Future.error(errorMsg);
    }
    return Future.error(errorMsg);
  }
}

Future<Null> nullFutureHandler(dynamic data) {
  return Future.value(null);
}
