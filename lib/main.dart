import 'package:atv/archs/base/base_app.dart';
import 'package:atv/archs/base/route_manager.dart';
import 'package:atv/archs/utils/log_util.dart';
import 'package:atv/config/conf/app_conf.dart';
import 'package:atv/config/conf/route/app_route_settings.dart';
import 'package:atv/generated/codegen_loader.g.dart';
import 'package:atv/pages/Login/splash_page.dart';
import 'package:atv/pages/page_route.dart';
import 'package:atv/tools/language/lw_language_tool.dart';
import 'package:atv/widgetLibrary/lw_widget.dart';
import 'package:dio_log/interceptor/dio_log_interceptor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'archs/lw_arch.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

bool mixDevelop = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // sentry为性能与BUG监听库
  await SentryFlutter.init((options) async {
    options.dsn = '';
    options.tracesSampleRate = 1.0;
    options.environment = await AppConf.environment();
    options.anrEnabled = true;
  }, appRunner: () async {
    var env = await AppConf.environment();
    mixDevelop = await AppConf.mixDevelop();

    // 网络日志配置
    DioLogInterceptor.enablePrintLog = false;

    // 初始化架构库
    LWArch.init(
      env: env,
      token: '',
      // token: (await AppConf.tokenInfo()).accessToken,
      baseUrl: (await AppConf.baseUrl),
      httpSuccessCodes: ['1', '200', '100200', '100201', '100204'],
      mixDevelop: mixDevelop,
    );

    // var token =
    //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsaWNlbnNlIjoibWFkZSBieSB4aW5jaGFvIiwidXNlcl9uYW1lIjoiWEMwOTk4OSIsInNjb3BlIjpbInNlcnZlciJdLCJleHAiOjE2OTg5OTM5NjUsImF1dGhvcml0aWVzIjpbIlJFUE9SVF9NQU5BR0VSIiwiVEhFQVRFUl9DSVRZX01BTiIsIlNQRUNJQUxfTUFOQUdFIiwiQ0lUWV9QUk9fU1VSUlBPUlRFUiIsIlJPTEVfVVNFUiIsIlNXV19DSEFSR0VSIiwiUF9IT01FX05FVyIsIlJPTEVfQ1JNTUFOQUdFUiIsIlRIRUFURVJfUkVHSU9OX01BTiJdLCJqdGkiOiI3ZmUzYTI0MS03ZmFmLTQ4ZTYtOWUyNS02OWExYjE1OWRiM2YiLCJjbGllbnRfaWQiOiJhcHAifQ.UVBPhTnnZ79orKe9NyTqRuKfda6V1PoMoDpBYRrZyb4';
    // Http.instance().init(baseUrl: 'https://t-ser-cloud.xinchao.com/portal/pcrm/api/', token: token);
    // XCArch.init(
    //   env: 'dev',
    //   token: token,
    //   baseUrl: 'https://d-ser-cloud.xinchao.com/portal/pcrm/api/',
    //   httpSuccessCodes: ['0', '000', '200', '100200', '100201', '100204'],
    // );

    // 初始化谷歌地图
    _initMap();

    //
    return runApp(EasyLocalization(
      supportedLocales: const [
        Locale('zh'), // 汉语
        Locale('en'), // 英语
        Locale('es'), // 西班牙语
        Locale('fr'), // 法语
      ],
      path: 'resources/langs',
      fallbackLocale: const Locale('zh'), //TODO: 这里要改成es
      saveLocale: true, // 保存当前的local到本地
      useOnlyLangCode: true, // 只用语言标签，不用区域标签
      // assetLoader: const CodegenLoader(), //TODO: 等所有的key定义完成后再来生成这个
      child: MyApp(),
    ));
  });
}

_initMap() {}

class MyApp extends BaseApp {
  MyApp({Key? key}) : super(key: key);

  String? _environment;

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() {
    // Db.instance();
    AppConf.environment().then((value) => _environment = value);

    return super.createState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, Widget page) {
    var appName = 'atv';
    if (_environment != 'prod') {
      appName += '.$_environment';
    }
    return MaterialApp(
      title: appName,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        _MyNavigator(),
        SentryNavigatorObserver(),
      ],
      onGenerateRoute: RouteManager.instance.getRouteFactory(),
      color: Colors.white,
      theme: ThemeData(
        // platform: TargetPlatform.iOS,
        // primarySwatch: Color(0xFFE60044),
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: const Color(0x01FFFFFF)),
      ),
      //国际化配置
      localizationsDelegates: context.localizationDelegates,
      // const [
      //   GlobalMaterialLocalizations.delegate, // for Android
      //   GlobalCupertinoLocalizations.delegate, // for iOS
      //   GlobalWidgetsLocalizations.delegate, // for widget
      // ],
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      // const [
      //   Locale('zh'), // 汉语
      //   Locale('en'), // 英语
      //   Locale('es'), // 西班牙语
      //   Locale('fr'), // 法语
      // ],
      home: mixDevelop ? page : SplashPage(route: AppRoute.splash),
      builder: EasyLoading.init(
        builder: (context, widget) {
          LWWidget.init(context, designWidth: 375, designHeight: 812);
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: MediaQuery(
              //Setting font does not change with system font size
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget ??
                  Container(
                    color: Colors.white,
                  ),
            ),
          );
        },
      ),
    );
  }

  @override
  void registerRoutes() {
    globalRegisterRoutes();
  }
}

class _MyNavigator extends NavigatorObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    LogUtil.d("didPop ${navigator?.widget.pages}");
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    LogUtil.d("didPush ${navigator?.widget.pages}");
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    LogUtil.d("didRemove ${navigator?.widget.pages}");
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    LogUtil.d("didReplace ${navigator?.widget.pages}");
  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    super.didStartUserGesture(route, previousRoute);
    LogUtil.d("didStartUserGesture ${navigator?.widget.pages}");
  }

  @override
  void didStopUserGesture() {
    super.didStopUserGesture();
    LogUtil.d("didStopUserGesture ${navigator?.widget.pages}");
  }
}
