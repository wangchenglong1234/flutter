// TODO Implement this librarimport 'package:flutter/services.dart';
import 'dart:async';

import 'package:flutter/services.dart';

typedef DebouncedFunction = void Function();
typedef ThrottledFunction = void Function();

class ToolUtils {
  static void hideStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  static DebouncedFunction debounce(DebouncedFunction func, int duration) {
    Timer? timer;
    return () {
      if (timer != null) {
        timer?.cancel();
      }
      timer = Timer(Duration(milliseconds: duration), () {
        func();
      });
    };
  }

  static ThrottledFunction throttle(ThrottledFunction func, int duration) {
    bool canExecute = true;
    Timer? timer;

    return () {
      if (!canExecute) {
        return;
      }
      canExecute = false;
      func();
      timer?.cancel();
      timer = Timer(Duration(milliseconds: duration), () {
        canExecute = true;
      });
    };
  }
}
