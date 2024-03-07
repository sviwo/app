import 'package:atv/archs/data/err/token_invalid_exception.dart';
import 'package:dio/dio.dart';

/// Http请求与响应错误
class HttpErrorException implements Exception {
  final String? message;
  final String code;

  HttpErrorException({this.code = '-1', this.message = 'HTTP未知异常'});

  String toString() {
    return message ?? 'HTTP未知异常`';
  }

  factory HttpErrorException.create(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        throw HttpErrorException(code: '-1', message: '请求取消');
      case DioErrorType.connectTimeout:
        throw HttpErrorException(code: '-1', message: '连接超时');
      case DioErrorType.sendTimeout:
        throw HttpErrorException(code: '-1', message: "请求超时");
      case DioErrorType.receiveTimeout:
        throw HttpErrorException(code: '-1', message: '响应超时');
      case DioErrorType.response:
        {
          int code = error.response?.statusCode ?? -1;
          switch (code) {
            case 400:
              throw BadRequestException(code, "服务器错误");
            case 401:
              throw TokenInvalidException(code, "没有权限");
            case 403:
              throw UnauthorisedException(code, "服务器拒绝执行");
            case 404:
              throw UnauthorisedException(code, "服务器未部署");
            case 405:
              throw UnauthorisedException(code, "请求方法被禁止");
            case 500:
              throw UnauthorisedException(code, "服务器内部错误");
            case 502:
              throw UnauthorisedException(code, "无效的请求");
            case 503:
              throw UnauthorisedException(code, "服务器挂了");
            case 505:
              throw UnauthorisedException(code, "不支持HTTP协议请求");
            default:
              throw HttpErrorException(code: code.toString(), message: error.response?.statusMessage ?? 'HTTP未知异常');
          }
        }
      default:
        throw HttpErrorException(code: '-1', message: error.message);
    }
  }
}

/// 请求错误
class BadRequestException extends HttpErrorException {
  BadRequestException(int badCode, String msg) : super(code: badCode.toString(), message: msg);
}

/// 未认证异常
class UnauthorisedException extends HttpErrorException {
  UnauthorisedException(int uCode, String msg) : super(code: uCode.toString(), message: msg);
}
