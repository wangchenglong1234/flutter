import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:app_inspection_system/http/code.dart';
import 'package:app_inspection_system/http/result_data.dart';

///是否需要弹提示
const NOT_TIP_KEY = "noTip";

class ErrorInterceptors extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options, handler) async {
    //没有网络
    // switch (connectivityResult) {
    //   case ConnectivityResult.wifi:
    //     // 设备已连接到Wi-Fi
    //     break;
    //   case ConnectivityResult.mobile:
    //     // 设备已通过移动数据连接
    //     break;
    //   case ConnectivityResult.none:
    //     // 设备没有连接到任何网络
    //     break;
    //   default:
    //   // 不确定或未知网络状态
    // }
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      var data = ResultData(
          Code.errorHandleFunction(Code.NETWORK_ERROR, "无网络", true),
          false,
          Code.NETWORK_ERROR);
      Response response = Response(requestOptions: options, data: data);
      return handler.resolve(response); // 可以返回自定义的错误响应
    }
    return super.onRequest(options, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    // 检查是否为超时错误
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      // 处理超时错误
      final data = ResultData(
          Code.errorHandleFunction(Code.NETWORK_TIMEOUT, "time out", true),
          false,
          Code.NETWORK_TIMEOUT);
      Response response =
          Response(requestOptions: err.requestOptions, data: data);
      return handler.resolve(response); // 可以返回自定义的错误响应
    } else if (err.response?.statusMessage != null) {
      final data = ResultData(
          Code.errorHandleFunction(
              Code.NETWORK_UNKNOWN, err.response?.statusMessage, true),
          false,
          Code.NETWORK_UNKNOWN);
      Response response =
          Response(requestOptions: err.requestOptions, data: data);
      return handler.resolve(response); // 可以返回自定义的错误响应
    }

    // 其他错误处理或交给下一个拦截器
    return super.onError(err, handler);
  }
}
