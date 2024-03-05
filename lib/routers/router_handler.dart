import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:app_inspection_system/pages/inspection_detail/inspection_detail.dart';
import 'package:app_inspection_system/pages/inspection_list/inspection_list.dart';
import 'package:app_inspection_system/pages/login/login.dart';

var loginHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const Login();
});

var inspectionListHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  return const InspectionList();
});

var inspectionDetailHandler =
    Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
  String id = params['id'].first as String; // 动态参数取值 /page:id
  return InspectionDetail(id: id);
});
