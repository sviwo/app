import 'dart:ffi';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageTool {
  /// 切换语言
  static void changeLocale(BuildContext context, [String local = 'en']) async {
    var supportLocals = context.supportedLocales;
    bool contains =
        supportLocals.any((element) => element.toString().contains(local));
    if (contains) {
      // 有支持的，设置为支持的类型
      await context.setLocale(Locale(local));
    } else {
      // 未支持的语言类型 使用英语
      await context.setLocale(const Locale('es'));
    }
  }

  /// 重置到系统语言
  static void resetToDeviceLocale(BuildContext context) async {
    await context.resetLocale();
  }

  /// 获取系统语言
  static Locale getDeviceLocal(BuildContext context) {
    return context.deviceLocale;
  }

  /// 获取系统语言
  static String getDeviceLocalString(BuildContext context) {
    return context.deviceLocale.toString();
  }

  /// 删除存储的local
  static void deleteSavedLocal(BuildContext context) async {
    await context.deleteSaveLocale();
  }

  /// 获取支持的语言列表
  static List<Locale> supportedLocales(BuildContext context) {
    return context.supportedLocales;
  }

  /// 获取未支持所转向的语言
  static Locale? fallbackLocale(BuildContext context) {
    return context.fallbackLocale;
  }

  /// 获取支持的代理
  static List<LocalizationsDelegate<dynamic>> localizationDelegates(
      BuildContext context) {
    return context.localizationDelegates;
  }
}
