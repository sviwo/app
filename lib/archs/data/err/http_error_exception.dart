import 'package:atv/archs/data/err/token_invalid_exception.dart';
import 'package:atv/archs/utils/log_util.dart';
import 'package:atv/generated/locale_keys.g.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// Http请求与响应错误
class HttpErrorException implements Exception {
  final String? message;
  final String code;

  HttpErrorException({this.code = '-1', this.message = 'unknown'});

  String toString() {
    return message ?? LocaleKeys.http_unknown_exception.tr();
  }

  factory HttpErrorException.create(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        throw HttpErrorException(
            code: '-1', message: LocaleKeys.request_cancellation.tr());
      case DioErrorType.connectTimeout:
        throw HttpErrorException(
            code: '-1', message: LocaleKeys.connection_timeout.tr());
      case DioErrorType.sendTimeout:
        throw HttpErrorException(
            code: '-1', message: LocaleKeys.request_timeout.tr());
      case DioErrorType.receiveTimeout:
        throw HttpErrorException(
            code: '-1', message: LocaleKeys.response_timeout.tr());
      case DioErrorType.response:
        {
          int code = error.response?.statusCode ?? -1;
          switch (code) {
            // case 400:
            //   throw BadRequestException(code, "服务器错误");
            case 401:
              throw TokenInvalidException(
                  code, LocaleKeys.login_invalid_tips.tr());
            // case 403:
            //   throw UnauthorisedException(code, "服务器拒绝执行");
            // case 404:
            //   throw UnauthorisedException(code, "服务器未部署");
            // case 405:
            //   throw UnauthorisedException(code, "请求方法被禁止");
            // case 500:
            //   throw UnauthorisedException(code, "服务器内部错误");
            // case 502:
            //   throw UnauthorisedException(code, "无效的请求");
            // case 503:
            //   throw UnauthorisedException(code, "服务器挂了");
            // case 505:
            //   throw UnauthorisedException(code, "不支持HTTP协议请求");
            default:
              throw HttpErrorException(
                  code: code.toString(),
                  message: error.response?.statusMessage ??
                      LocaleKeys.http_unknown_exception.tr());
          }
        }
      default:
        throw HttpErrorException(code: '-1', message: error.message);
    }
  }
}

/// 请求错误
class BadRequestException extends HttpErrorException {
  BadRequestException(int badCode, String msg)
      : super(code: badCode.toString(), message: msg);
}

/// 未认证异常
class UnauthorisedException extends HttpErrorException {
  UnauthorisedException(int uCode, String msg)
      : super(code: uCode.toString(), message: msg);
}
