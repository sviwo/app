import 'package:atv/generated/locale_keys.g.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../base/event_manager.dart';
import '../../conf/arch_event.dart';
import '../../utils/log_util.dart';
import '../entity/res_data.dart';
import '../entity/res_empty.dart';
import '../err/http_error_exception.dart';
import '../err/token_invalid_exception.dart';

class HttpHelper {
  HttpHelper._internal();

  static List<String> _successCodes = [];

  /// 设置后端返回的成功状态码
  static void setSuccessCodes(List<String> codes) {
    _successCodes = codes;
  }

  /// 带数据转换（data为对象）
  static Future<ResData<T>> httpDataConvert<T>(
      dynamic data, T Function(Map<String, dynamic> json)? fromJsonT,
      {bool needOriginalData = false}) async {
    try {
      if (_successCodes.contains(data['code'].toString())) {
        var ret = ResData.fromJson(data, fromJsonT);
        ret.originalData = needOriginalData ? data['data'] : null;
        return ret;
      } else {
        throw HttpErrorException(
            code: data['code'].toString(), message: data['msg'].toString());
      }
    } catch (e, stack) {
      LogUtil.d('http-error: $e, stack=\n${stack.toString()}');
      if (e is HttpErrorException) {
        rethrow;
      } else {
        throw HttpErrorException(
            code: '-2',
            message: LocaleKeys.network_data_conversion_is_abnormal.tr());
      }
    }
  }

  /// 带数据转换（data为不分页list）
  static Future<ResData<T>> httpListConvert<T>(
      dynamic data, T Function(List<dynamic> json)? fromJsonT,
      {bool needOriginalData = false}) async {
    try {
      if (_successCodes.contains(data['code'].toString())) {
        var ret = ResData.fromJsonList(data, fromJsonT);
        ret.originalData = needOriginalData ? data['data'] : null;
        return ret;
      } else {
        throw HttpErrorException(
            code: data['code'].toString(), message: data['msg'].toString());
      }
    } catch (e, stack) {
      LogUtil.d('http-error: $e, stack=\n${stack.toString()}');
      if (e is HttpErrorException) {
        rethrow;
      } else {
        throw HttpErrorException(
            code: '-2',
            message: LocaleKeys.network_data_conversion_is_abnormal.tr());
      }
    }
  }

  /// 空数据转换
  static Future<ResEmpty> httpEmptyConvert<T>(dynamic data) async {
    try {
      if (_successCodes.contains(data['code'].toString())) {
        return ResEmpty.fromJson(data);
      } else {
        throw HttpErrorException(
            code: data['code'].toString(), message: data['msg'].toString());
      }
    } catch (e, stack) {
      LogUtil.d('http-error: $e, stack=\n${stack.toString()}');
      if (e is HttpErrorException) {
        rethrow;
      } else {
        throw HttpErrorException(
            code: '-2',
            message: LocaleKeys.network_data_conversion_is_abnormal.tr());
      }
    }
  }

  @deprecated
  static Future<dynamic?> httpDynamicDataConvert<T>(dynamic data) async {
    try {
      if (_successCodes.contains(data['code'].toString())) {
        return data['data'];
      } else {
        throw HttpErrorException(
            code: data['code'].toString(), message: data['msg'].toString());
      }
    } catch (e, stack) {
      LogUtil.d('http-error: $e, stack=\n${stack.toString()}');
      if (e is HttpErrorException) {
        rethrow;
      } else {
        throw HttpErrorException(
            code: '-2',
            message: LocaleKeys.network_data_conversion_is_abnormal.tr());
      }
    }
  }

  static Exception handleException(Object e) {
    LogUtil.d('http-error: $e');
    if (e is Error) {
      return HttpErrorException(message: e.toString());
    } else if (e is TokenInvalidException) {
      EventManager.post(ArchEvent.tokenInvalid);
      return e;
    } else if (e is HttpErrorException) {
      return e;
    } else if (e is DioError) {
      return HttpErrorException.create(e);
    } else {
      return HttpErrorException();
    }
  }
}
