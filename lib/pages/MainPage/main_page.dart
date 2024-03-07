import 'package:atv/archs/base/base_mvvm_page.dart';
import 'package:atv/archs/base/event_manager.dart';
import 'package:atv/archs/conf/arch_event.dart';
import 'package:atv/config/conf/app_conf.dart';
import 'package:atv/config/conf/app_event.dart';
import 'package:atv/config/conf/app_icons.dart';
import 'package:atv/config/conf/route/app_route_settings.dart';
import 'package:atv/pages/MainPage/viewModel/main_page_view_model.dart';
import 'package:atv/widgetLibrary/basic/colors/lw_colors.dart';
import 'package:atv/widgetLibrary/basic/font/lw_font_weight.dart';
import 'package:atv/widgetLibrary/complex/toast/lw_toast.dart';
import 'package:atv/widgetLibrary/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPage extends BaseMvvmPage {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends BaseMvvmPageState<MainPage, MainPageViewModel> {
  DateTime? lastPopTime;
  int _currentIndex = 0;
  var respectGreat = false;

  @override
  void dispose() {
    EventManager.unregister(context, AppEvent.respectGreat);
    super.dispose();
  }

  @override
  Widget? headerBackgroundWidget() {
    return Image.asset(
      AppIcons.imgMainPageBg,
      fit: BoxFit.cover,
    );
  }

  @override
  bool isSupportPullRefresh() => true;

  @override
  bool isSupportScrollView() => true;

  @override
  MainPageViewModel viewModelProvider() {
    return MainPageViewModel();
  }

  @override
  void initState() {
    super.initState();
    AppConf.isMainPage = true;
  }

  @override
  void releaseVM() {
    AppConf.isMainPage = false;
    EventManager.unregister(this, ArchEvent.tokenInvalid);
    super.releaseVM();
  }

  @override
  Widget buildBody(Object context) {
    return Container();
  }
}
