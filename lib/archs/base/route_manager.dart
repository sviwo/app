
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/log_util.dart';
import 'base_page.dart';

// ignore: camel_case_types
typedef BasePage _buildPage();

class RouteManager {
  factory RouteManager() => _getInstance();

  static RouteManager get instance => _getInstance();

  static RouteManager? _instance;

  RouteManager._();

  static RouteManager _getInstance() {
    return _instance ??= RouteManager._();
  }

  // 页面缓存
  Map<String, _buildPage> routes = {};

  /// 在main.dart统一注册页面
  void registerRoute(String route, _buildPage func) {
    routes[route] = func;
  }

  /// 用于响应native外部调用（响应并解析channel）
  BasePage getPage(String name) {
    if (routes.containsKey(name)) {
      var page = routes[name]!();
      LogUtil.d('routeManger: $name, ${page.hashCode}');
      return page;
    } else {
      return PageNotFound();
    }
  }

  /// 用于响应flutter内部调用（响应Navigator.xxx）
  RouteFactory getRouteFactory() {
    return _getRoute;
  }

  /// 路由转接，pageName/pagePath => Page
  MaterialPageRoute _getRoute(RouteSettings settings) {
    LogUtil.d('_getRoute: ${routes.containsKey(settings.name)}');
    if (routes.containsKey(settings.name)) {
      return MaterialPageRoute(
          builder: (BuildContext context) {
            return routes[settings.name]!();
          },
          settings: settings);
    } else {
      return MaterialPageRoute(builder: (BuildContext context) {
        return PageNotFound();
      });
    }
  }
}

/// 页面异常
class PageNotFound extends BasePage {
  PageNotFound({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PageNotFoundState();
}

class _PageNotFoundState extends BasePageState<PageNotFound> {
  @override
  void releaseVM() {}

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.1,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light, // iOS
            statusBarIconBrightness: Brightness.dark, // Android
          ),
          elevation: 0,
          toolbarHeight: 44,
        ),
        body: Container(
          color: Colors.white,
        ),
      ),
    );
  }
}
