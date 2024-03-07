import 'dart:io';

import 'package:atv/archs/utils/log_util.dart';
import 'package:flutter/material.dart';

import '../widgetLibrary/basic/colors/lw_colors.dart';
import 'conf/arch_conf.dart';
import 'data/net/http.dart';
import 'data/net/http_helper.dart';
import 'data/net/proxy/http_proxy.dart';
import 'fe_arch_flutter_platform_interface.dart';

class LWArch {
  // LWArch._();
  static bool mixDevelop = false; // 是否混合开发
  static double pageBottomBarHeight = 62; // 只能传入不带dp的常量值
  static double pageBottomBarElevation = 0;
  static Color pageBackgroundColor = LWColors.gray7;

  /// params:
  ///   - env, environment abbr, value is dev, sit, uat and prod
  ///   - token, need with prefix, like as 'Bearer'
  ///   - baseUrl
  ///   - httpSuccessCodes
  static void init({
    String? env,
    String? token,
    String? baseUrl,
    List<String> httpSuccessCodes = const [],
    double pageBottomBarHeight = 62.0,
    double pageBottomBarElevation = 0,
    Color pageBackgroundColor = LWColors.gray7,
    bool mixDevelop = true,
  }) {
    ArchConf.env = env ?? '';
    ArchConf.token = token ?? '';
    ArchConf.baseUrl = baseUrl ?? '';
    HttpHelper.setSuccessCodes(httpSuccessCodes);
    LWArch.pageBottomBarHeight = pageBottomBarHeight;
    LWArch.pageBottomBarElevation = pageBottomBarElevation;
    LWArch.pageBackgroundColor = pageBackgroundColor;
    LWArch.mixDevelop = mixDevelop;
    if (!mixDevelop) {
      initData();
    }

    // 手动日志Printer
    LogUtil.init(
        title: 'flutter',
        isDebug: env != 'prod',
        limitLength: (Platform.isIOS ? 3000 : 500));
  }

  static Future<void> initData() async {
    // Statistics.setBaseUrl('url');
    // 执行网络等其它初始化逻辑
    HttpProxy.enable = await ArchConf.getHttpProxyEnable();
    HttpProxy.host = await ArchConf.getHttpProxyHost();
    HttpProxy.port = await ArchConf.getHttpProxyPort();

    Http.instance().init(baseUrl: ArchConf.baseUrl, token: ArchConf.token);
    LogUtil.d(
        'BaseApp: env=${ArchConf.env} baseUrl=${ArchConf.baseUrl} token=${ArchConf.token}');
  }

  static void setHttpToken(String? token) {
    Http.instance().setToken(token);
  }

  static void setHttpHeaders(Map<String, dynamic> headers) {
    Http.instance().setHeaders(headers);
  }

  static void setHttpSuccessCodes(List<String> httpSuccessCodes) {
    HttpHelper.setSuccessCodes(httpSuccessCodes);
  }

  Future<String?> getPlatformVersion() {
    return FeArchFlutterPlatform.instance.getPlatformVersion();
  }
}
