import 'package:dio/dio.dart';
import 'package:app_inspection_system/http/code.dart';
import 'package:app_inspection_system/http/result_data.dart';

class ResponseInterceptors extends InterceptorsWrapper {
  @override
  onResponse(Response response, handler) async {
    final value = ResultData(response.data, true, Code.SUCCESS,
        headers: response.headers);
    if (response.statusCode! != 200) {
      Code.errorHandleFunction(
          Code.NETWORK_UNKNOWN, response.data?.msg ?? '', true);
    }
    response.data = value;
    return handler.next(response);
  }
}
