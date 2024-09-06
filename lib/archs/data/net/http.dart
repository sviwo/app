import 'dart:convert';
import 'dart:io';

import 'package:atv/generated/locale_keys.g.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_log/interceptor/dio_log_interceptor.dart';
import 'package:atv/archs/data/net/proxy/http_proxy.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../utils/log_util.dart';
import '../err/http_error_exception.dart';
import '../err/token_invalid_exception.dart';
import 'interceptor/repeat_interceptor.dart';
import 'interceptor/request_interceptor.dart';

class Http {
  static const int TIMEOUT_CONNECT = 15000;
  static const int TIMEOUT_READ = 180000;
  static const int TIMEOUT_WRITE = 30000;

  final Dio _dio = Dio();
  final CancelToken _cancelToken = CancelToken();

  static final Http _singleton = Http._internal();

  factory Http.instance() => _singleton;

  String? _token;

  Http._internal() {
    // options.
    _dio.options
      ..baseUrl = ''
      ..connectTimeout = TIMEOUT_CONNECT
      ..receiveTimeout = TIMEOUT_READ
      ..sendTimeout = TIMEOUT_WRITE
      ..validateStatus = (int? status) {
        return status != null && status > 0;
      }
      ..headers = {};

    // interceptor.
    _dio.interceptors.add(DioLogInterceptor());
    // _dio.interceptors.add(LogInterceptor()); // 日志拦截器
    _dio.interceptors.add(RepeatInterceptor()); // 重复请求拦截器
    _dio.interceptors.add(RequestInterceptor()); // 自定义请求拦截器

    // proxy.
    setProxy();
  }

  void setProxy() {
    if (!HttpProxy.enable) {
      _dio.httpClientAdapter = DefaultHttpClientAdapter();
    } else {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (uri) {
          return "PROXY ${HttpProxy.host}:${HttpProxy.port}";
        };
        // 代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return null;
      };
    }
  }

  void setLanguage(String? language) {
    _dio.options.headers['Accept-Language'] = language;
  }

  void clearToken() {
    setToken(null);
    _dio.options.headers.remove('Authorization');
  }

  /// initial by main.dart
  void init(
      {String? baseUrl,
      String? token,
      String? language,
      int? connectTimeout,
      int? readTimeout,
      int? writeTimeout,
      Map<String, dynamic>? headers,
      List<Interceptor>? interceptors}) {
    _token = token;
    _dio.options = _dio.options.copyWith(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: readTimeout,
        sendTimeout: writeTimeout);
    // common headers.
    if (token?.isNotEmpty == true) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
      _dio.options.headers['Content-Type'] = 'application/json';
    }
    if (headers?.isNotEmpty == true) {
      _dio.options.headers.addAll(headers!);
    }
    if (interceptors?.isNotEmpty == true) {
      _dio.interceptors.addAll(interceptors!);
    }
  }

  /// set token with prefix, like as 'Bearer'
  void setToken(String? token) {
    _token = token;
  }

  /// set common headers.
  void setHeaders(Map<String, dynamic> headers) {
    _dio.options.headers.addAll(headers);
  }

  /// cancel many requests by the same cancelToken.
  void cancelRequests({CancelToken? cancelToken}) {
    (cancelToken ?? _cancelToken).cancel("cancelled");
  }

  /// restful get.
  Future get(String path,
      {Map<String, dynamic>? params,
      Map<String, dynamic>? headers,
      String? token,
      String? contentType = 'application/json',
      CancelToken? cancelToken,
      ProgressCallback? progressCallback}) async {
    _dio.options.headers['Content-Type'] = contentType;
    if (token?.isNotEmpty == true || _token?.isNotEmpty == true) {
      _dio.options.headers['Authorization'] = token ?? 'Bearer $_token';
    }
    if (headers?.isNotEmpty == true) {
      _dio.options.headers.addAll(headers!);
    }
    LogUtil.d('http-get: \n${_dio.options.baseUrl + path}'
        // '\n${_dio.options.headers['Authorization']}'
        '\n${_dio.options.headers}'
        '${params == null ? '' : '\nparams, ${jsonEncode(params)}'}');

    //
    Response res;
    res = await _dio.get(path,
        queryParameters: params,
        onReceiveProgress: progressCallback,
        cancelToken: cancelToken ?? _cancelToken);

    LogUtil.d('http-resp: \n${jsonEncode(res.data)}');
    _handleResponse(res.statusCode ?? -1);
    return res.data;
  }

  /// restful put.
  Future put(String path,
      {Map<String, dynamic>? params,
      Map<String, dynamic>? headers,
      data,
      String? token,
      String? contentType = 'application/json',
      CancelToken? cancelToken,
      ProgressCallback? progressCallback}) async {
    _dio.options.headers['Content-Type'] = contentType;
    if (token?.isNotEmpty == true || _token?.isNotEmpty == true) {
      _dio.options.headers['Authorization'] = token ?? 'Bearer $_token';
    }
    if (headers?.isNotEmpty == true) {
      _dio.options.headers.addAll(headers!);
    }
    LogUtil.d('http-put: \n${_dio.options.baseUrl + path}'
        // '\n${_dio.options.headers['Authorization']}'
        '\n${_dio.options.headers}'
        '${params == null ? '' : '\nparams, ${jsonEncode(params)}'}');

    //
    Response res;
    res = await _dio.put(path,
        data: data,
        queryParameters: params,
        onReceiveProgress: progressCallback,
        cancelToken: cancelToken ?? _cancelToken);

    LogUtil.d('http-resp: \n${jsonEncode(res.data)}');
    _handleResponse(res.statusCode ?? -1);
    return res.data;
  }

  /// restful delete.
  Future delete(String path,
      {Map<String, dynamic>? params,
      Map<String, dynamic>? headers,
      data,
      String? token,
      String? contentType = 'application/json',
      CancelToken? cancelToken,
      ProgressCallback? progressCallback}) async {
    _dio.options.headers['Content-Type'] = contentType;
    if (token?.isNotEmpty == true || _token?.isNotEmpty == true) {
      _dio.options.headers['Authorization'] = token ?? 'Bearer $_token';
    }
    if (headers?.isNotEmpty == true) {
      _dio.options.headers.addAll(headers!);
    }
    LogUtil.d('http-delete: \n${_dio.options.baseUrl + path}'
        // '\n${_dio.options.headers['Authorization']}'
        '\n${_dio.options.headers}'
        '${params == null ? '' : '\nparams, ${jsonEncode(params)}'}');

    //
    Response res;
    res = await _dio.delete(path,
        data: data,
        queryParameters: params,
        cancelToken: cancelToken ?? _cancelToken);

    LogUtil.d('http-resp: \n${jsonEncode(res.data)}');
    _handleResponse(res.statusCode ?? -1);
    return res.data;
  }

  /// restful post.
  Future post(String path,
      {Map<String, dynamic>? params,
      Map<String, dynamic>? headers,
      data,
      String? token,
      String? contentType = 'application/json',
      CancelToken? cancelToken,
      ProgressCallback? progressCallback}) async {
    _dio.options.headers['Content-Type'] = contentType;
    if (token?.isNotEmpty == true || _token?.isNotEmpty == true) {
      _dio.options.headers['Authorization'] = token ?? 'Bearer $_token';
    }
    if (headers?.isNotEmpty == true) {
      _dio.options.headers.addAll(headers!);
    }
    LogUtil.d('http-post: \n${_dio.options.baseUrl + path}'
        '\n${_dio.options.headers}');
    LogUtil.d(
        '${params == null ? '' : '\nparams, ${jsonEncode(params)}'}${data == null || data is FormData ? '' : '\nbody, ${jsonEncode(data)}'}');
    // if (data is FormData) {
    //   LogUtil.d('\nbody, ${jsonEncode(data.fields.first)}');
    // }

    //
    Response res;
    res = await _dio.post(path,
        data: data,
        queryParameters: params,
        onReceiveProgress: progressCallback,
        cancelToken: cancelToken ?? _cancelToken);

    LogUtil.d('http-resp: \n${jsonEncode(res.data)}');
    _handleResponse(res.statusCode ?? -1);
    return res.data;
  }

  /// restful post.
  Future postForm(String path,
      {Map<String, dynamic>? params,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? data,
      String? token,
      String? contentType = 'application/json',
      CancelToken? cancelToken,
      ProgressCallback? progressCallback}) async {
    return post(path,
        params: params,
        headers: headers,
        data: FormData.fromMap(data ?? {}),
        token: token,
        contentType: contentType,
        cancelToken: cancelToken,
        progressCallback: progressCallback);
  }

  void _handleResponse(int code) {
    switch (code) {
      // case 400:
      //   throw BadRequestException(code, "服务器错误");
      case 401:
        throw TokenInvalidException(code, LocaleKeys.login_invalid_tips.tr());
      // case 403:
      //   throw UnauthorisedException(code, "服务器拒绝执行");
      // case 404:
      //   throw UnauthorisedException(code, "无法连接服务器");
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
        if (code ~/ 100 != 2) {
          // throw HttpErrorException(code: "-1", message: '服务访问异常');
          throw HttpErrorException(
              code: code.toString(),
              message: LocaleKeys.http_unknown_exception.tr());
        }
    }
  }
}
