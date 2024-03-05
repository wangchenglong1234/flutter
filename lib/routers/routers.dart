import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:app_inspection_system/routers/router_handler.dart';

class Routes {
  static FluroRouter router = FluroRouter();
  static String loginPage = '/login_page';
  static String inspectionListPage = '/inspection_list_page';
  static String inspectionDetailPage = '/inspection_detail_page/:id';

  static void configureRoutes(FluroRouter router) {
    router.define(loginPage, handler: loginHandler);
    router.define(inspectionListPage, handler: inspectionListHandler);
    router.define(inspectionDetailPage, handler: inspectionDetailHandler);
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      if (kDebugMode) {
        print('route not found!');
      }
      return null;
    });
  }

  static popPage(BuildContext context) {
    router.pop(context);
  }

  // 对参数进行encode
  static Future navigateTo(
    BuildContext context,
    String path, {
    Map<String, dynamic>? params, //页面参数
    bool replace = false, //是否清空上一个页面
    bool clearStack = false, // 是否清空当前页面栈
  }) {
    String query = "";
    if (params != null) {
      int index = 0;
      for (var key in params.keys) {
        var value = Uri.encodeComponent(params[key]);
        if (index == 0) {
          query = "?";
        } else {
          query = "$query&";
        }
        query += "$key=$value";
        index++;
      }
    }
    path = path + query;
    return router.navigateTo(context, path,
        replace: replace,
        clearStack: clearStack,
        transition: TransitionType.custom,
        transitionDuration: const Duration(milliseconds: 300),
        transitionBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
      // 定义滑动动画，从右侧滑入
      var begin = const Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    });
  }
}
