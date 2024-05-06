import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

ThemeData getMaterialTheme() {
  return (ThemeData(
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
  ));
}

BrnAllThemeConfig getBrunoTheme() {
  return (BrnAllThemeConfig(
      // 全局配置
      commonConfig: BrnCommonConfig(brandPrimary: const Color(0xFF3072F6)),
      // dialog配置
      dialogConfig: BrnDialogConfig(radius: 12.0)));
  // ...
}
