import 'package:atv/archs/base/route_manager.dart';
import 'package:atv/config/conf/route/app_route_settings.dart';
import 'package:atv/pages/Login/login_main_page.dart';
import 'package:atv/pages/Login/login_page.dart';
import 'package:atv/pages/Login/login_register_page.dart';
import 'package:atv/pages/MainPage/main_page.dart';
import 'package:atv/pages/Mine/authentication_center_page.dart';
import 'package:atv/pages/Mine/mine_page.dart';

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

  /// 我的页面
  RouteManager.instance.registerRoute(AppRoute.mine, () => MinePage());

  /// 认证中心
  RouteManager.instance.registerRoute(
      AppRoute.authenticationCenter, () => AuthenticationCenterPage());
}
