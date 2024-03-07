import 'package:atv/archs/base/route_manager.dart';
import 'package:atv/config/conf/route/app_route_settings.dart';
import 'package:atv/pages/Login/login_main_page.dart';
import 'package:atv/pages/Login/login_page.dart';
import 'package:atv/pages/Login/login_register_page.dart';
import 'package:atv/pages/MainPage/main_page.dart';

void globalRegisterRoutes() {
  /// 登录主页
  RouteManager.instance
      .registerRoute(AppRouteSettings.loginMain, () => LoginMainPage());
  /// 登录页
  RouteManager.instance
      .registerRoute(AppRouteSettings.login, () => LoginPage());
  /// 注册页面
  RouteManager.instance
      .registerRoute(AppRouteSettings.register, () => LoginRegisterPage());
  /// App主页
  RouteManager.instance
      .registerRoute(AppRouteSettings.main, () => MainPage());
}
