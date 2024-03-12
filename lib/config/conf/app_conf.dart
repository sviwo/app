import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../tools/deviceInfo/lw_deviceInfo_tool.dart';
import 'app_keys.dart';

class AppConf {
  AppConf._();

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
    return '${await domainUrl}/portal/pcrm/api/';
  }

  /// =====================
  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
  static List<String>? _permissions;
  static List<String>? _roles;
  // static bool isMainPage = false; // 临时，主页是否启用

  static void logout() {
    _permissions = null;
    _roles = null;
  }

  // 混合开发
  static Future<bool> mixDevelop() async {
    return (await prefs).getBool(AppKeys.mixDevelop) ?? false;
  }

  static Future<String> hostPrefix() async {
    var env = await environment();
    return {'dev': 'd-', 'sit': 't-', 'uat': 'p-'}[env] ?? '';
  }

  // 致敬XX
  static Future<bool> respectGreat() async {
    return (await prefs).getString(AppKeys.respectGreat) == '1';
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
    return (await prefs).getString(AppKeys.deviceId) ?? await DeviceInfos.getDeviceIdentifier();
  }

  // 登录信息
  static Future<bool> loginSuccess() async {
    return (await prefs).getBool(AppKeys.loginSuccess) ?? false;
  }

  static Future<bool> setLoginSuccess(bool? success) async {
    return (await prefs).setBool(AppKeys.loginSuccess, success ?? false);
  }

  // token信息
  // static Future<TokenInfo> tokenInfo() async {
  //   String? string = (await prefs).getString(AppKeys.tokenInfo);
  //   if (string == null) {
  //     return TokenInfo();
  //   }
  //   return TokenInfo.fromJson(jsonDecode(string));
  // }

  // static Future<bool> setTokenInfo(TokenInfo? tokenInfo) async {
  //   return (await prefs).setString(AppKeys.tokenInfo, tokenInfo == null ? '' : jsonEncode(tokenInfo.toJson()));
  // }

  // 用户信息
  // static Future<UserInfo> userInfo() async {
  //   String? string = (await prefs).getString(AppKeys.userInfo);
  //   if (string == null) {
  //     return UserInfo();
  //   }
  //   return UserInfo.fromJson(jsonDecode(string));
  // }

  // static Future<bool> setUserInfo(UserInfo? userInfo) async {
  //   _permissions ??= userInfo?.permissions;
  //   _roles ??= userInfo?.roles;
  //   return (await prefs).setString(AppKeys.userInfo, userInfo == null ? '' : jsonEncode(userInfo.toJson()));
  // }

  // 用户权限
  // static Future<List<String>> permissions() async {
  //   _permissions ??= (await userInfo()).permissions;
  //   return _permissions ?? [];
  // }

  // 用户角色
  // static Future<List<String>> roles() async {
  //   _roles ??= (await userInfo()).roles;
  //   return _roles ?? [];
  // }

  // 用户id
  // static Future<String?> userId() async {
  //   UserInfo info = await userInfo();
  //   return info.sysUser?.userId;
  // }

  // 用户code
  // static Future<String?> userCode() async {
  //   UserInfo info = await userInfo();
  //   return info.sysUser?.username;
  // }


  // 数据字典
  // static Future<List<DictInfo>> dictList() async {
  //   String? string = (await prefs).getString(AppKeys.dictList);
  //   if (string == null) {
  //     return [];
  //   }
  //   return (jsonDecode(string) as List).map((e) => DictInfo.fromJson(e)).toList();
  // }

  // static Future<bool> setDictList(List<DictInfo>? dictInfos) async {
  //   return (await prefs).setString(AppKeys.dictList, dictInfos == null ? '' : jsonEncode(dictInfos));
  // }

  

  // 环境信息
  // static Future<EnvironmentInfo?> environmentInfo() async {
  //   String? string = (await prefs).getString(AppKeys.environmentInfo);
  //   if (string == null) {
  //     return null;
  //   }
  //   return EnvironmentInfo.fromJson(jsonDecode(string));
  // }

  // 配置信息
  // static Future<ConfigInfo?> configInfo() async {
  //   String? string = (await prefs).getString(AppKeys.configInfo);
  //   if (string == null) {
  //     return null;
  //   }
  //   return ConfigInfo.fromJson(jsonDecode(string));
  // }
}