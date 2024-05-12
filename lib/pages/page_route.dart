import 'package:atv/archs/base/route_manager.dart';
import 'package:atv/config/conf/route/app_route_settings.dart';
import 'package:atv/pages/Login/login_main_page.dart';
import 'package:atv/pages/Login/login_page.dart';
import 'package:atv/pages/Login/login_register_page.dart';
import 'package:atv/pages/MainPage/energy_model_page.dart';
import 'package:atv/pages/MainPage/main_page.dart';
import 'package:atv/pages/MainPage/map_navi_page.dart';
import 'package:atv/pages/MainPage/nearby_bluetooth_device_page.dart';
import 'package:atv/pages/MainPage/remote_control_page.dart';
import 'package:atv/pages/MainPage/safety_info_page.dart';
import 'package:atv/pages/MainPage/service_info_page.dart';
import 'package:atv/pages/MainPage/trip_recorder_page.dart';
import 'package:atv/pages/MainPage/upgrade_info_page.dart';
import 'package:atv/pages/MainPage/vehicle_condition_information_page.dart';
import 'package:atv/pages/Mine/account_info_page.dart';
import 'package:atv/pages/Mine/authentication_center_page.dart';
import 'package:atv/pages/Mine/help_info_page.dart';
import 'package:atv/pages/Mine/mine_page.dart';
import 'package:atv/pages/Mine/multi_language_page.dart';
import 'package:atv/pages/Login/reset_password_page.dart';
import 'package:atv/pages/Mine/user_info_edit_page.dart';
import 'package:atv/pages/Mine/user_info_page.dart';

void globalRegisterRoutes() {
  /// 登录主页
  RouteManager.instance
      .registerRoute(AppRoute.loginMain, () => LoginMainPage());

  /// 登录页
  RouteManager.instance.registerRoute(AppRoute.login, () => LoginPage());

  /// 注册页面
  RouteManager.instance
      .registerRoute(AppRoute.register, () => LoginRegisterPage());

  /// App主页
  RouteManager.instance.registerRoute(AppRoute.main, () => MainPage());

  /// 动能模式
  RouteManager.instance
      .registerRoute(AppRoute.energyModel, () => EnergyModelPage());

  /// 遥控器
  RouteManager.instance
      .registerRoute(AppRoute.remoteControl, () => RemoteControlPage());

  /// 行程记录
  RouteManager.instance
      .registerRoute(AppRoute.tripRecorder, () => TripRecorderPage());

  /// 车况信息
  RouteManager.instance.registerRoute(AppRoute.vehicleConditionInformation,
      () => VehicleConditionInformationPage());

  /// 安全性
  RouteManager.instance
      .registerRoute(AppRoute.safetyInfo, () => SafetyInfoPage());

  /// 服务
  RouteManager.instance
      .registerRoute(AppRoute.serviceInfo, () => ServiceInfoPage());

  /// 升级
  RouteManager.instance
      .registerRoute(AppRoute.upgradeInfo, () => UpgradeInfoPage());

  /// 我的页面
  RouteManager.instance.registerRoute(AppRoute.mine, () => MinePage());

  /// 认证中心
  RouteManager.instance.registerRoute(
      AppRoute.authenticationCenter, () => AuthenticationCenterPage());

  /// 联系信息
  RouteManager.instance.registerRoute(AppRoute.userInfo, () => UserInfoPage());

  /// 账户
  RouteManager.instance
      .registerRoute(AppRoute.accountInfo, () => AccountInfoPage());

  /// 帮助
  RouteManager.instance.registerRoute(AppRoute.helpInfo, () => HelpInfoPage());

  /// 多语言
  RouteManager.instance
      .registerRoute(AppRoute.multiLanguage, () => MultiLanguagePage());

  /// 重置密码
  RouteManager.instance
      .registerRoute(AppRoute.resetPassword, () => ResetPasswordPage());

  /// 编辑用户信息
  RouteManager.instance
      .registerRoute(AppRoute.editUserInfo, () => UserInfoEditPage());

  /// 地图页
  RouteManager.instance.registerRoute(AppRoute.mapNavi, () => MapNaviPage());

  /// 地图页
  RouteManager.instance.registerRoute(AppRoute.bluetoothDevicesPage, () => NearByBluetoothDevicesPage());
}
