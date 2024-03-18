import 'package:dio/dio.dart';

class TokenInterceptors extends InterceptorsWrapper {
  String? _token;

  @override
  onRequest(RequestOptions options, handler) async {
    //授权码
    if (_token == null) {
      var authorizationCode = await getAuthorization();
      if (authorizationCode != null) {
        _token = authorizationCode;
      }
    }
    if (_token != null) {
      options.headers["Authorization"] = _token;
    }
    return super.onRequest(options, handler);
  }

  @override
  onResponse(Response response, handler) async {
    try {
      var responseJson = response.data;
      if (response.statusCode == 201 && responseJson["token"] != null) {
        // ignore: prefer_interpolation_to_compose_strings
        _token = 'token ' + responseJson["token"];
      }
    } catch (e) {
      print(e);
    }
    return super.onResponse(response, handler);
  }

  ///清除授权
  clearAuthorization() {
    this._token = null;
  }

  ///获取授权token
  getAuthorization() async {
    // String? token = await LocalStorage.get(Config.TOKEN_KEY);
    // if (token == null) {
    //   String? basic = await LocalStorage.get(Config.USER_BASIC_CODE);
    //   if (basic == null) {
    //     //提示输入账号密码
    //   } else {
    //     //通过 basic 去获取token，获取到设置，返回token
    //     return "Basic $basic";
    //   }
    // } else {
    // this._token = token;
    // return token;
    // }
  }
}
