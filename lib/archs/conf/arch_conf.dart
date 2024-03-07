import 'package:shared_preferences/shared_preferences.dart';

import '../data/net/proxy/http_proxy.dart';
import 'arch_keys.dart';

class ArchConf {
  ArchConf._();

  static String env = '';
  static String token = '';
  static String baseUrl = '';

  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  // http log & proxy
  static Future<bool> getHttpProdEnable() async {
    return (await prefs).getBool(ArchKeys.httpProdEnable) ?? false;
  }

  static Future<bool> setHttpProdEnable(bool value) async {
    return (await prefs).setBool(ArchKeys.httpProdEnable, value);
  }

  static Future<int> getHttpProdEnableTime() async {
    return (await prefs).getInt(ArchKeys.httpProdEnableTime) ?? 0;
  }

  static Future<bool> setHttpProdEnableTime(int value) async {
    return (await prefs).setInt(ArchKeys.httpProdEnableTime, value);
  }

  static Future<bool> getHttpLogEnable() async {
    return (await prefs).getBool(ArchKeys.httpLogEnable) ?? !['prod', ''].contains(env);
  }

  static Future<bool> setHttpLogEnable(bool value) async {
    await (await prefs).setBool(ArchKeys.httpLogEnable, value);
    return (await prefs).commit();
  }

  static Future<bool> getHttpProxyEnable() async {
    return (await prefs).getBool(ArchKeys.httpProxyEnable) ?? HttpProxy.enable;
  }

  static Future<bool> setHttpProxyEnable(bool value) async {
    return (await prefs).setBool(ArchKeys.httpProxyEnable, value);
  }

  static Future<String> getHttpProxyHost() async {
    return (await prefs).getString(ArchKeys.httpProxyHost) ?? HttpProxy.host;
  }

  static Future<bool> setHttpProxyHost(String value) async {
    return (await prefs).setString(ArchKeys.httpProxyHost, value);
  }

  static Future<String> getHttpProxyPort() async {
    return (await prefs).getString(ArchKeys.httpProxyPort) ?? HttpProxy.port;
  }

  static Future<bool> setHttpProxyPort(String value) async {
    return (await prefs).setString(ArchKeys.httpProxyPort, value);
  }
}
