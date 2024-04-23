import 'package:atv/archs/base/base_view_model.dart';
import 'package:atv/archs/base/event_manager.dart';
import 'package:atv/config/conf/app_conf.dart';
import 'package:atv/config/conf/app_event.dart';
import 'package:atv/generated/locale_keys.g.dart';
import 'package:atv/tools/language/lw_language_tool.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MultiLanguagePageViewModel extends BaseViewModel {
  List<Map<String, String>> get lauguageDatas => [
        {'zh': LocaleKeys.zh.tr()},
        {'en': LocaleKeys.en.tr()},
        {'fr': LocaleKeys.fr.tr()},
        {'es': LocaleKeys.es.tr()}
      ];

  String currentLauguage = 'en';

  changeLanguage(BuildContext context, String code) async {
    await LWLanguageTool.changeLocale(context, code);
    currentLauguage = await AppConf.getLauguage();
    EventManager.post(AppEvent.languageChange);
    // pageRefresh();
  }

  @override
  void initialize(args) async {
    // TODO: implement initialize
    currentLauguage = await AppConf.getLauguage();
    pageRefresh();
  }

  @override
  void release() {
    // TODO: implement release
  }
}
