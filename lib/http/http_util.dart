import 'package:dio/dio.dart';
import 'package:app_inspection_system/constant/constant.dart';
import 'package:app_inspection_system/http/interceptors/error_interceptor.dart';
import 'package:app_inspection_system/http/interceptors/response_interceptor.dart';
import 'package:app_inspection_system/http/interceptors/token_interceptor.dart';

/// 请求方法
enum DioMethod {
  get,
  post,
  put,
  delete,
  patch,
  head,
}

class httpUtil {
  /// 单例模式
  static httpUtil? _instance;
  factory httpUtil() => _instance ?? httpUtil._internal();
  static httpUtil? get instance => _instance ?? httpUtil._internal();

  /// 连接超时时间
  static const Duration connectTimeout = Duration(seconds: 60 * 1000);

  /// 响应超时时间
  static const Duration receiveTimeout = Duration(seconds: 60 * 1000);

  /// Dio实例
  static Dio _dio = Dio();

  /// 私有构造函数
  httpUtil._internal() {
    // 初始化基本选项
    BaseOptions options = BaseOptions(
        baseUrl: Constant.baseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout);
    _instance = this;
    // 初始化dio
    _dio = Dio(options);
    // 添加拦截器

    _dio.interceptors.add(TokenInterceptors());

    _dio.interceptors.add(ResponseInterceptors());

    _dio.interceptors.add(ErrorInterceptors());
  }

  /// 请求类
  Future<T> request<T>(
    String path, {
    DioMethod method = DioMethod.get,
    Map<String, dynamic>? params,
    data,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    const _methodValues = {
      DioMethod.get: 'get',
      DioMethod.post: 'post',
      DioMethod.put: 'put',
      DioMethod.delete: 'delete',
      DioMethod.patch: 'patch',
      DioMethod.head: 'head'
    };
    options ??= Options(method: _methodValues[method]);
    try {
      Response response;
      response = await _dio.request(path,
          data: data,
          queryParameters: params,
          cancelToken: cancelToken,
          options: options,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  /// 开启日志打印
  void openLog() {
    _dio.interceptors
        .add(LogInterceptor(responseHeader: false, responseBody: true));
  }
}
