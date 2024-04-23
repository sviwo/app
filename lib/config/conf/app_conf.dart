import 'package:atv/archs/data/net/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../tools/deviceInfo/lw_deviceInfo_tool.dart';
import 'app_keys.dart';

class AppConf {
  AppConf._();

  static const iosMapApiKey = 'AIzaSyAOrV7txQSbF0LDcBYpioW-nXIHaOCoURM';
  static const androidMapApiKey = 'AIzaSyAOrV7txQSbF0LDcBYpioW-nXIHaOCoURM';

  /// =====================
  // 服务器域名
  static Future<String> get domainUrl async {
    if ((await environment()) != 'prod') {
      // 从原生传过来的
      // var envInfo = await environmentInfo();
      // if (envInfo != null && envInfo.apiDomain != null) {
      //   return envInfo.apiDomain!;
      // }
    }
    return 'https://${await hostPrefix()}ser-cloud.xinchao.com';
  }

  // 服务器BaseUrl
  static Future<String> get baseUrl async {
    // return '${await domainUrl}/portal/pcrm/api/';
    return Future(() => 'http://114.115.135.233:8000/');
  }

  /// =====================
  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
  static void logout() async {
    /// 退出登录不删除多语言设置
    var p = (await prefs);
    p.remove(AppKeys.loginSuccess);
    p.remove(AppKeys.httpAuthorization);
    p.remove(AppKeys.httpPublickey);
    Http.instance().clearToken();
  }

  static void afterLoginSuccess(
      {String? Authorization, String? Publickey}) async {
    /// 登录成功保存token、publickey、登录标志设为true
    var wait = [
      setHttpAuthorization(Authorization ?? ''),
      setHttpPublickey(Publickey ?? ''),
      setLoginSuccess(true)
    ];
    Http.instance().setToken(Authorization);
  }

  // 混合开发
  static Future<bool> mixDevelop() async {
    return (await prefs).getBool(AppKeys.mixDevelop) ?? false;
  }

  static Future<String> hostPrefix() async {
    var env = await environment();
    return {'dev': 'd-', 'sit': 't-', 'uat': 'p-'}[env] ?? '';
  }

  // 环境
  static Future<String> environment() async {
    if (!await mixDevelop()) {
      return 'dev';
    } else {
      return (await prefs).getString(AppKeys.environment) ?? '';
    }
  }

  // 设备唯一标识
  static Future<String> deviceId() async {
    return (await prefs).getString(AppKeys.deviceId) ??
        await LWDeviceInfos.getDeviceIdentifier();
  }

  /// app版本号
  static Future<String> appVersion() async {
    return (await LWDeviceInfos.getAppInfo()).version;
  }

  // 登录信息
  static Future<bool> loginSuccess() async {
    return (await prefs).getBool(AppKeys.loginSuccess) ?? false;
  }

  static Future<bool> setLoginSuccess(bool? success) async {
    return (await prefs).setBool(AppKeys.loginSuccess, success ?? false);
  }

  static Future<String> getHttpAuthorization() async {
    return (await prefs).getString(AppKeys.httpAuthorization) ?? '';
  }

  static Future<bool> setHttpAuthorization(String value) async {
    return (await prefs).setString(AppKeys.httpAuthorization, value);
  }

  static Future<String> getHttpPublickey() async {
    return (await prefs).getString(AppKeys.httpPublickey) ?? "";
  }

  static Future<bool> setHttpPublickey(String value) async {
    return (await prefs).setString(AppKeys.httpPublickey, value);
  }

  static Future<String> getLauguage() async {
    return (await prefs).getString(AppKeys.currentLauguage) ?? '';
  }

  static Future<bool> setLauguage(String value) async {
    return (await prefs).setString(AppKeys.currentLauguage, value);
  }
}
