import 'dart:convert';

import 'package:webview_flutter/webview_flutter.dart';

import 'js_callback.dart';

class LWJsUtils {
  static const String _openUrl = "openUrl";
  static const String _takeEvent = "sendEvent";

  static const String loginSuccess = 'xinchao://loginSuccess';
  static const String _backUrl = "back";
  static const String _localJumpUrl = "xinchao://";
  static const String _backMethod = "interceptBackBtn";
  static const String _virtualBackPress = "virtualBackPress";
  static const String _setPageHeaderDisplay = "setPageHeaderDisplay";
  static const String _getLocation = "getGeoLocation";
  static const String _getSystemInfo = "getSystemInfo";
  static const String _fastLogin = "thirdLogin";
  static const String _getUserInfo = "getUserinfo";
  static const String _exitLogin = "logout";
  static const String _openLocalFile = "openLocalFile";
  static const String _downLoadFile = "downloadFile";
  static const String _share = "share";
  static const String _clickRightBarButtonItem = "clickRightBarButtonItem";
  static const String _getExportParam = "getExportParam"; //获取导出
  static const String _openExportNextPage = "openExportNextPage";
  static const String _registerJsHandler = "registerJsHandler"; //公共方法

  static sendEvent(WebViewController? controller, String eventName, Map<String, dynamic> params) {
    var message = 'window.lwFlutterHandlers["$eventName"](${jsonEncode(params)});';
    controller?.runJavaScript(message);
  }

  ///仅仅指定了同js的通信的规范，方法的具体实现以及通信的参数结构还需要实现处理
  static executeMethod(WebViewController? controller, String message, JsCallBack? callBack) {
    var json = jsonDecode(message);
    _JsParams jsParams = _JsParams.fromJson(json);

    void callbackSuccess({Map<String, dynamic>? dataMap, String? dataStr}) {
      _callbackSuccess(controller, jsParams.callback, dataMap: dataMap, dataStr: dataStr);
    }

    void callbackFailed({String? errorMsg}) {
      _callbackFailed(controller, jsParams.callback, errorMsg: errorMsg);
    }

    /// 接收事件
    void takeEvent(String eventName, Map<String, dynamic> params) {
      callBack?.takeEvent(eventName, params, callbackSuccess, callbackFailed);
    }

    switch (jsParams.action) {
      /// 打开指定路由
      case _openUrl:
        if (jsParams.data == null) {
          return;
        }
        Map<String, dynamic> params = {};
        try {
          params = jsonDecode(jsParams.data);
        } catch (e) {
          return;
        }
        var route = params.remove('url')?.toString() ?? '';
        if (route.isNotEmpty != true) {
          return;
        }
        if (route != loginSuccess) {
          callBack?.openUrl(route, params);
        } else {
          takeEvent(route, params);
        }
        break;

      /// 接收事件
      case _takeEvent:
        if (jsParams.data == null) {
          return;
        }
        Map<String, dynamic> params = {};
        try {
          params = jsonDecode(jsParams.data);
        } catch (e) {
          return;
        }
        var eventName = params.remove('eventName')?.toString() ?? '';
        if (eventName.isNotEmpty != true) {
          return;
        }

        takeEvent(eventName, params['params'] ?? {});
        break;
      case _registerJsHandler:
        break;
      case _backMethod:
        callBack?.setBackMethod(controller, jsParams.callback, jsParams.data);
        break;
      case _virtualBackPress:
        callBack?.virtualBackPress(controller, jsParams.callback, jsParams.data);
        break;
      case _setPageHeaderDisplay:
        callBack?.showTitleBar(controller, jsParams.callback, jsParams.data);
        break;
      case _getLocation:
        callBack?.getGeoLocation(callbackSuccess, callbackFailed);
        break;
      case _getSystemInfo:
        callBack?.getSystemInfo(controller, jsParams.callback);
        break;
      case _fastLogin:
        callBack?.loginWx(controller, jsParams.callback, jsParams.data);
        break;
      case _getUserInfo:
        callBack?.getUserInfo(controller, jsParams.callback);
        break;
      case _exitLogin:
        callBack?.loginOut(controller, jsParams.callback);
        break;
      case _openLocalFile:
        callBack?.openFile(controller, jsParams.callback);
        break;
      case _downLoadFile:
        callBack?.loadFile(controller, jsParams.callback, jsParams.data);
        break;
      case _share:
        callBack?.shareInfo(controller, jsParams.callback, jsParams.data);
        break;
      case _clickRightBarButtonItem:
        callBack?.showBackDialog(controller, jsParams.callback, jsParams.data);
        break;
      case _getExportParam:
        callBack?.getExportParam(controller, jsParams.callback);
        break;
      case _openExportNextPage:
        callBack?.openExportNextPage(controller, jsParams.callback, jsParams.data);
        break;
    }
  }

  /// H5请求的成功回调
  static _callbackSuccess(WebViewController? controller, String callback,
      {Map<String, dynamic>? dataMap, String? dataStr}) {
    var newData = _CallBackParams('success', dataMap, '').toJson();
    controller?.runJavaScript("javascript:lwFlutterCallbacks.$callback($newData)");
  }

  /// H5请求的失败回调
  static _callbackFailed(WebViewController? controller, String callback, {String? errorMsg}) {
    var data = _CallBackParams('fail', null, errorMsg).toJson();
    controller?.runJavaScript("javascript:lwFlutterCallbacks.$callback($data)");
  }
}

class _JsParams {
  ///同js约定的方法标识
  late String action;

  ///携带的数据
  late dynamic data;

  ///回调js的方法名  就执行 callBackHandle(String funcName, WebViewController? controller, {String? data})
  late String callback;

  _JsParams(this.action, this.data, this.callback);

  _JsParams.fromJson(Map<String, dynamic> json) {
    action = json['action'];
    data = json['data'];
    callback = json['callBack'];
  }
}

class _CallBackParams {
  ///回调的状态信息，成功-success 失败-fail
  String status;

  ///回调的数据
  dynamic data;

  ///失败时的错误信息
  String? error;

  _CallBackParams(this.status, this.data, this.error);

  String toJson() {
    return jsonEncode({"status": status, "data": data, "error": error});
  }
}
