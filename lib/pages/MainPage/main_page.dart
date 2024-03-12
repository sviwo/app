import 'package:atv/archs/base/base_mvvm_page.dart';
import 'package:atv/archs/base/event_manager.dart';
import 'package:atv/archs/conf/arch_event.dart';
import 'package:atv/archs/utils/extension/ext_string.dart';
import 'package:atv/archs/utils/log_util.dart';
import 'package:atv/config/conf/app_conf.dart';
import 'package:atv/config/conf/app_event.dart';
import 'package:atv/config/conf/app_icons.dart';
import 'package:atv/config/conf/route/app_route_settings.dart';
import 'package:atv/generated/locale_keys.g.dart';
import 'package:atv/pages/MainPage/viewModel/main_page_view_model.dart';
import 'package:atv/widgetLibrary/basic/colors/lw_colors.dart';
import 'package:atv/widgetLibrary/basic/font/lw_font_weight.dart';
import 'package:atv/widgetLibrary/complex/titleBar/lw_title_bar.dart';
import 'package:atv/widgetLibrary/complex/toast/lw_toast.dart';
import 'package:atv/widgetLibrary/utils/size_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainPage extends BaseMvvmPage {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends BaseMvvmPageState<MainPage, MainPageViewModel> {
  @override
  void dispose() {
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
  LWTitleBar? buildTitleBar() {
    // TODO: implement buildTitleBar
    return super.buildTitleBar();
  }

  // @override
  // bool isSupportPullRefresh() => true;

  @override
  bool isSupportScrollView() => true;

  @override
  MainPageViewModel viewModelProvider() {
    return MainPageViewModel();
  }

  @override
  void initState() {
    super.initState();
    // AppConf.isMainPage = true;
  }

  @override
  void releaseVM() {
    // AppConf.isMainPage = false;
    EventManager.unregister(this, ArchEvent.tokenInvalid);
    super.releaseVM();
  }

  @override
  Widget buildBody(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        _buildNaviIcons(),
        _buildCar(),
        SizedBox(
          height: 28.dp,
        ),
        _buildCarStatus(),
        SizedBox(
          height: 30.dp,
        ),
        _buildControlIcons(),
        SizedBox(
          height: 32.dp,
        ),
        _buildItem(
            LocaleKeys.remote_control,
            null,
            Image.asset(
              AppIcons.imgMainPageRemoteControlIcon,
              width: 21.5.dp,
              height: 21.5.dp,
            )),
        _buildItem(
            LocaleKeys.kinetic_energy_model,
            null,
            Image.asset(
              AppIcons.imgMainPageLightningIcon,
              width: 15.5.dp,
              height: 24.5.dp,
            )),
        _buildLocationItem(),
        _buildItem(
            LocaleKeys.trip_recorder,
            null,
            Image.asset(
              AppIcons.imgMainPageLocationIcon,
              width: 18.dp,
              height: 24.dp,
            )),
        _buildItem(
            LocaleKeys.vehicle_condition_information,
            null,
            Image.asset(
              AppIcons.imgMainPageAtvInfoIcon,
              width: 28.dp,
              height: 14.dp,
            )),
        _buildItem(
            LocaleKeys.safety,
            null,
            Image.asset(
              AppIcons.imgMainPageSafeIcon,
              width: 20.5.dp,
              height: 20.5.dp,
            )),
        _buildItem(
            LocaleKeys.service,
            null,
            Image.asset(
              AppIcons.imgMainPageServiceIcon,
              width: 19.dp,
              height: 19.dp,
            )),
        _buildItem(
            LocaleKeys.upgrade,
            null,
            Image.asset(
              AppIcons.imgMainPageUpgrade,
              width: 21.dp,
              height: 21.dp,
            )),
        SizedBox(
          height: bottomBarHeight,
        )
      ],
    );
  }

  Widget _buildNaviIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          padding: EdgeInsets.symmetric(horizontal: 20.dp),
          iconSize: 51.57.dp,
          onPressed: () {
            LogUtil.d('点击了sviwo图标');
          },
          icon: Image.asset(
            AppIcons.imgMainPageSviwoIcon,
            width: 51.67.dp,
            height: 12.33.dp,
          ),
        ),
        IconButton(
            padding: EdgeInsets.symmetric(horizontal: 20.dp),
            onPressed: () {
              pagePush(AppRoute.mine);
              LogUtil.d('点击了我的图标');
            },
            iconSize: 25.67.dp,
            icon: Image.asset(
              AppIcons.imgMainPageMineIcon,
              width: 25.67.dp,
              height: 22.67.dp,
            ))
      ],
    );
  }

  Widget _buildCar() {
    return SizedBox(
      height: 165.dp,
      child: Center(
        child: Image.asset(
          AppIcons.imgMainPageCarIcon,
          width: 212.dp,
          height: 165.dp,
        ),
      ),
    );
  }

  Widget _buildCarStatus() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.dp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppIcons.imgMainPageQuantityOfElectricityIcon,
                  width: 37.dp,
                  height: 16.dp,
                ),
                SizedBox(
                  width: 8.5.dp,
                ),
                Text(
                  '100' + LocaleKeys.km.tr(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '28℃',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(
                  width: 10.dp,
                ),
                Image.asset(
                  AppIcons.imgMainPageTemperatureIcon,
                  width: 44.dp,
                  height: 15.5.dp,
                ),
              ],
            )
          ],
        ));
  }

  Widget _buildControlIcons() {
    return Padding(
        padding: EdgeInsets.only(left: 11.dp, right: 20.dp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                padding: EdgeInsets.symmetric(horizontal: 20.dp),
                onPressed: () {
                  LogUtil.d('点击了锁图标');
                },
                iconSize: 41.dp,
                icon: Image.asset(
                  AppIcons.imgMainPageLockIcon,
                  width: 41.dp,
                  height: 41.dp,
                )),
            IconButton(
                padding: EdgeInsets.symmetric(horizontal: 20.dp),
                onPressed: () {
                  LogUtil.d('点击了喇叭图标');
                },
                iconSize: 27.dp,
                icon: Image.asset(
                  AppIcons.imgMainPageTrumpetIcon,
                  width: 27.dp,
                  height: 23.5.dp,
                )),
            IconButton(
                padding: EdgeInsets.symmetric(horizontal: 20.dp),
                onPressed: () {
                  LogUtil.d('点击了灯光图标');
                },
                iconSize: 32.5.dp,
                icon: Image.asset(
                  AppIcons.imgMainPageLamplightIcon,
                  width: 32.5.dp,
                  height: 20.dp,
                ))
          ],
        ));
  }

  Widget _buildItem(String? title, Widget? leftWidget, Widget icon) {
    LogUtil.d(title);
    // assert(
    // title.isNullOrEmpty() && leftWidget == null, 'title或者leftWidget至少有一个');
    Widget? _lWiget = null;
    if (leftWidget != null) {
      _lWiget = leftWidget;
    } else if (title != null) {
      _lWiget = Text(
        title.tr(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          // fontWeight: LWFontWeight.bold
        ),
      );
    }
    return InkWell(
        onTap: () {
          LogUtil.d('点击了$title');
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(40.dp, 15.dp, 42.dp, 15.dp),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: _lWiget ?? Container()),
              SizedBox(
                width: 28.dp,
                child: Center(
                  child: icon,
                ),
              )
            ],
          ),
        ));
  }

  Widget _buildLocationItem() {
    Widget? _lWiget = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.place.tr(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            // fontWeight: LWFontWeight.bold
          ),
        ),
        SizedBox(
          height: 5.5.dp,
        ),
        Text(
          '成都市高新区都说了带你飞克里斯蒂娜发啦凯撒到哪发啦萨达；那份；单开放大；开朗；答案发生；你',
          style: TextStyle(
            color: Colors.white,
            fontSize: 9.5.sp,
            // fontWeight: LWFontWeight.bold
          ),
        ),
      ],
    );
    return InkWell(
        onTap: () {
          LogUtil.d('点击了地点');
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(40.dp, 15.dp, 42.dp, 15.dp),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _lWiget),
              SizedBox(
                width: 28.dp,
                child: Center(
                  child: Image.asset(
                    AppIcons.imgMainPageNavigationIcon,
                    width: 17.5.dp,
                    height: 22.dp,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
