import 'package:dio/dio.dart';

import '../../err/http_error_exception.dart';

/// 自定义请求拦截器
/// todo:
class RequestInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    HttpErrorException httpException = HttpErrorException.create(err);
    err.error = httpException;
    super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }
}
