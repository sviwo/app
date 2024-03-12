import 'package:atv/archs/base/base_view_model.dart';
import 'package:atv/config/conf/app_icons.dart';
import 'package:atv/generated/locale_keys.g.dart';
import 'package:atv/widgetLibrary/utils/size_util.dart';
import 'package:easy_localization/easy_localization.dart';

class MinePageViewModel extends BaseViewModel {
  final List<String> itemNames = [
    LocaleKeys.account.tr(),
    LocaleKeys.help.tr(),
    LocaleKeys.multi_language.tr(),
    LocaleKeys.authentication_center.tr(),
    LocaleKeys.quit.tr()
  ];
  final List<String> itemImageNames = [
    AppIcons.imgMinePageAccount,
    AppIcons.imgMinePageHelp,
    AppIcons.imgMinePageLanguage,
    AppIcons.imgMinePageAC,
    AppIcons.imgMinePageQuit,
  ];
  final List<double> itemImageWidths = [
    16.67.dp,
    20.67.dp,
    21.dp,
    18.dp,
    19.67.dp,
  ];
  final List<double> itemImageHeights = [
    16.67.dp,
    20.67.dp,
    21.dp,
    19.67.dp,
    20.67.dp,
  ];

  bool hasVerified = false;

  String get verifiedString => hasVerified
      ? ('${LocaleKeys.authenticated.tr()}!')
      : ('${LocaleKeys.unverified.tr()}!');

  final List<String> productImageUrls = [
    'https://pics2.baidu.com/feed/9922720e0cf3d7cae34495d5a83b0e046a63a991.jpeg@f_auto?token=e07c40ef947d14020572427f40fb8603',
    'https://pics0.baidu.com/feed/7af40ad162d9f2d364fc170294c83a1e6227cc1b.jpeg@f_auto?token=a25a3e922eefd55bfb6253c399ea00df',
    'https://pics6.baidu.com/feed/8d5494eef01f3a29070a9f34a4010c3c5d607c3f.jpeg@f_auto?token=35ad6360b103f077d32f372000c92b70',
  ];
  final List<String> productTitles = [
    LocaleKeys.vehicle.tr(),
    LocaleKeys.charge.tr(),
    LocaleKeys.mall.tr(),
  ];

  final List<String> productDescrips = [
    LocaleKeys.vehicle_describe.tr(),
    LocaleKeys.charge_describe.tr(),
    LocaleKeys.mall_describe.tr(),
  ];

  @override
  void initialize(args) {
    // TODO: implement initialize
  }

  @override
  void release() {
    // TODO: implement release
  }
}
