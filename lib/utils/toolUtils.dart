// TODO Implement this librarimport 'package:flutter/services.dart';
import 'package:flutter/services.dart';

class ToolUtils {
  static void hideStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }
}
