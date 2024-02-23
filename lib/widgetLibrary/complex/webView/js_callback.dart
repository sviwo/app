import 'package:webview_flutter/webview_flutter.dart';

typedef OnSuccess = Function({Map<String, dynamic>? dataMap, String? dataStr});
typedef OnFailed = Function({String? errorMsg});

abstract class JsCallBack {
  void openUrl(String route, Map<String, dynamic> params);

  void takeEvent(String eventName, Map<String, dynamic> params, OnSuccess onSuccess, OnFailed onFailed);

  void showTitleBar(WebViewController? controller, String callback, dynamic data) {}

  void setBackMethod(WebViewController? controller, String callback, dynamic data) {}

  void virtualBackPress(WebViewController? controller, String callback, dynamic data) {}

  void getGeoLocation(OnSuccess onSuccess, OnFailed onFailed) {}

  void getSystemInfo(WebViewController? controller, String callback) {}

  void loginWx(WebViewController? controller, String callback, dynamic data) {}

  void getUserInfo(WebViewController? controller, String callback) {}

  void openFile(WebViewController? controller, String callback) {}

  void loadFile(WebViewController? controller, String callback, dynamic data) {}

  void loginOut(WebViewController? controller, String callback) {}

  void shareInfo(WebViewController? controller, String callback, dynamic data) {}

  void showBackDialog(WebViewController? controller, String callback, dynamic data) {}

  void getExportParam(WebViewController? controller, String callback) {}

  void openExportNextPage(WebViewController? controller, String callback, dynamic data) {}
}
