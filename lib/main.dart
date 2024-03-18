import 'package:bot_toast/bot_toast.dart';
import 'package:bruno/bruno.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'pages/login/login.dart';
import 'routers/routers.dart';
import './store/index.dart';

void main() {
  // 通常，在应用启动阶段，特别是在 Dart 的 main() 函数中，
  //如果要在初始化阶段执行依赖于 Flutter 框架的任何操作
  //（例如注册路由、设置插件或者在没有构建 MaterialApp 或 CupertinoApp 之前访问某些框架服务），
  //就需要先调用 WidgetsFlutterBinding.ensureInitialized() 方法。
  WidgetsFlutterBinding.ensureInitialized();
  Routes.configureRoutes(Routes.router);
  BrnInitializer.register(
      allThemeConfig: BrnAllThemeConfig(
          // 全局配置
          commonConfig: BrnCommonConfig(brandPrimary: const Color(0xFF3072F6)),
          // dialog配置
          dialogConfig: BrnDialogConfig(radius: 12.0)));
  runApp(StoreProvider(
    store: StoreWrapper.store,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  bool get isProduction =>
      kReleaseMode; // 在Flutter中，kReleaseMode用于判断是否为发布模式（生产环境）
  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();
    return MaterialApp(
      builder: (context, child) {
        child = botToastBuilder(context, child); // 覆盖在整个material上的组件
        return child;
      },
      navigatorObservers: [BotToastNavigatorObserver()],
      // 定制主题
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3072F6)),
        useMaterial3: true,
        dialogTheme: const DialogTheme(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ),
        textTheme: const TextTheme(
          // 设置默认文本样式
          bodyLarge: TextStyle(fontSize: 16.0), // 一般正文大小
          bodyMedium: TextStyle(fontSize: 14.0), // 可选，另一个正文大小
          displayLarge: TextStyle(fontSize: 32.0), // 大标题
          // 其他文本样式的大小，如标题、副标题等
          // ...
        ),
      ),
      home: const Login(),
      // showSemanticsDebugger: !isProduction,
      // 在main函数中，我们初始化路由，并在MaterialApp中通过onGenerateRoute属性设置路由生成器为Routes.router.generator，
      // 这样当应用试图导航到一个未明确指定的路由时，Fluro就会根据我们之前定义的路由规则来处理并生成对应的页面。
      onGenerateRoute: Routes.router.generator,
    );
  }
}
