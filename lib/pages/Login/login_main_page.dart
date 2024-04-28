import 'package:atv/tools/imagePicker/image_picker_tool.dart';
import 'package:atv/widgetLibrary/complex/loading/lw_loading.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:atv/archs/base/base_mvvm_page.dart';
import 'package:atv/archs/utils/log_util.dart';
import 'package:atv/config/conf/app_icons.dart';
import 'package:atv/config/conf/route/app_route_settings.dart';
import 'package:atv/generated/locale_keys.g.dart';
import 'package:atv/pages/Login/viewModel/login_view_model.dart';
import 'package:atv/widgetLibrary/basic/button/lw_button.dart';
import 'package:atv/widgetLibrary/lw_widget.dart';
import 'package:atv/widgetLibrary/utils/size_util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginMainPage extends BaseMvvmPage {
  @override
  State<StatefulWidget> createState() => _LoginMainPageState();
}

class _LoginMainPageState
    extends BaseMvvmPageState<LoginMainPage, LoginViewModel> {
  @override
  LoginViewModel viewModelProvider() => LoginViewModel();

  @override
  bool isSupportSmoothTitleBar() => false;

  @override
  bool isSupportScrollView() => true;

  @override
  Widget? headerBackgroundWidget() {
    return ShaderMask(
        shaderCallback: (bounds) {
          return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [
                0.0,
                0.2,
                0.47,
                1.0
              ],
              colors: [
                const Color(0xff2f251b).withOpacity(0.75),
                const Color(0xff2f251b).withOpacity(0.75),
                const Color(0xff261d22).withOpacity(0.75),
                const Color(0xff0b0612).withOpacity(0.75),
              ]).createShader(bounds);
        },
        blendMode: BlendMode.srcOver,
        child: Image.asset(
          AppIcons.imgBgLoginMain,
          fit: BoxFit.cover,
        ));
  }

  @override
  Widget buildBody(BuildContext context) {
    return _buildContents();
  }

  _buildContents() {
    return SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 182.67.dp,
            ),
            Image.asset(
              AppIcons.imgLoginMainSviwoIcon,
              width: 203.33.dp,
              height: 51.33.dp,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 320.dp,
            ),
            LWButton.text(
              text: LocaleKeys.sign_in_now.tr(),
              textColor: Colors.white,
              textSize: 16.sp,
              backgroundColor: LWWidget.themeColor,
              minWidth: 315.dp,
              minHeight: 50.dp,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.dp))),
              onPressed: () {
                pagePush(AppRoute.login, fullscreenDialog: true);
              },
            ),
            SizedBox(
              height: 21.dp,
            ),
            LWButton.text(
              text: LocaleKeys.user_register.tr(),
              textColor: const Color(0xff010101),
              textSize: 16.sp,
              backgroundColor: Colors.white,
              minWidth: 315.dp,
              minHeight: 50.dp,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.dp))),
              onPressed: () {
                LogUtil.d('点击了用户注册');
                pagePush(AppRoute.register, fullscreenDialog: true);
              },
            ),
          ],
        ));
  }
}
