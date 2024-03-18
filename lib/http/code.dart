import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

///错误编码
class Code {
  ///网络错误
  static const NETWORK_ERROR = -1;

  ///网络超时
  static const NETWORK_TIMEOUT = -2;

  ///网络返回数据格式化一次
  static const NETWORK_JSON_EXCEPTION = -3;

  static const NETWORK_UNKNOWN = -4;

  static const SUCCESS = 200;

  static errorHandleFunction(code, message, noTip) {
    if (noTip) {
      return message;
    }
    BotToast.showText(
        text: message,
        textStyle: const TextStyle(fontSize: 14, color: Colors.white));
    return message;
  }
}
