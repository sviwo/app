import 'dart:io';

import 'package:atv/archs/base/base_mvvm_page.dart';
import 'package:atv/archs/utils/log_util.dart';
import 'package:atv/config/conf/route/app_route_settings.dart';
import 'package:atv/generated/locale_keys.g.dart';
import 'package:atv/pages/Login/viewModel/login_view_model.dart';
import 'package:atv/tools/language/lw_language_tool.dart';
import 'package:atv/widgetLibrary/basic/button/lw_button.dart';
import 'package:atv/widgetLibrary/basic/colors/lw_colors.dart';
import 'package:atv/widgetLibrary/basic/font/lw_font_weight.dart';
import 'package:atv/widgetLibrary/form/lw_form_input.dart';
import 'package:atv/widgetLibrary/utils/size_util.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../config/conf/app_icons.dart';

class LoginPage extends BaseMvvmPage {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends BaseMvvmPageState<LoginPage, LoginViewModel> {
  @override
  LoginViewModel viewModelProvider() => LoginViewModel();
  @override
  bool isSupportScrollView() => true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  @override
  Widget? headerBackgroundWidget() {
    return Image.asset(
      AppIcons.imgLoginBg,
      fit: BoxFit.cover,
    );
  }

  @override
  String? titleName() => LocaleKeys.login.tr();

  @override
  Widget buildBody(BuildContext context) {
    var isLegal = viewModel.judgeEmailAndPassword();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 30.dp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 30.dp,
          ),
          Text(
            LocaleKeys.email.tr(),
            style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: LWFontWeight.bold),
          ),
          SizedBox(
            height: 20.dp,
          ),
          _buildEmailInputField(),
          SizedBox(
            height: 40.dp,
          ),
          Text(
            LocaleKeys.password.tr(),
            style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: LWFontWeight.bold),
          ),
          SizedBox(
            height: 20.dp,
          ),
          _buildPWDInputField(),
          SizedBox(
            height: 82.dp,
          ),
          _buildNextButton(isLegal),
          SizedBox(
            height: 10.dp,
          ),
          _buildForgetPWDButton(),
          SizedBox(
            height: 52.dp,
          ),
          _buildThirdPartLogin()
        ],
      ),
    );
  }

  Widget _buildEmailInputField() {
    return SizedBox(
      height: 42.dp,
      child: TextFormField(
          onChanged: (value) {
            viewModel.emailName = value;
            pageRefresh(() {});
          },
          onFieldSubmitted: (value) {
            LogUtil.d('-----');
          },
          controller: _emailController,
          autofocus: false,
          textAlign: TextAlign.left,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          inputFormatters: [
            FilteringTextInputFormatter.singleLineFormatter,
            // FilteringTextInputFormatter.allow(RegExp(r'^[A-Za-z0-9]+@.$')),
          ],
          maxLines: 1,
          style: TextStyle(
              fontSize: 12.sp, color: Colors.white, height: SizeUtil.dp(1.5)),
          strutStyle: const StrutStyle(forceStrutHeight: true, leading: 0),
          decoration: InputDecoration(
            hintText: LocaleKeys.please_enter_your_email_address.tr(),
            hintStyle:
                TextStyle(fontSize: 12.sp, color: const Color(0xff8E8E8E)),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 15.5.dp, vertical: 15.dp),
            isDense: true,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 1.dp, color: Colors.white)),
            focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(width: 1.dp, color: const Color(0xff36BCB3)),
            ),
          )),
    );
  }

  Widget _buildPWDInputField() {
    return SizedBox(
      height: 42.dp,
      child: TextFormField(
          onChanged: (value) {
            viewModel.password = value;
            pageRefresh(() {});
          },
          onFieldSubmitted: (value) {
            LogUtil.d('-----');
          },
          controller: _pwdController,
          autofocus: false,
          textAlign: TextAlign.left,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          inputFormatters: [
            FilteringTextInputFormatter.singleLineFormatter,
            // FilteringTextInputFormatter.allow(RegExp(r'^[A-Za-z0-9]+@.$')),
          ],
          maxLines: 1,
          style: TextStyle(
              fontSize: 12.sp, color: Colors.white, height: SizeUtil.dp(1.5)),
          strutStyle: const StrutStyle(forceStrutHeight: true, leading: 0),
          decoration: InputDecoration(
            hintText: LocaleKeys.enter_your_PIN.tr(),
            hintStyle:
                TextStyle(fontSize: 12.sp, color: const Color(0xff8E8E8E)),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 15.5.dp, vertical: 15.dp),
            isDense: true,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 1.dp, color: Colors.white)),
            focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(width: 1.dp, color: const Color(0xff36BCB3)),
            ),
          )),
    );
  }

  Widget _buildNextButton(bool isLegal) {
    return LWButton.text(
      text: LocaleKeys.next_step.tr(),
      textColor: const Color(0xff010101),
      textSize: 16.sp,
      backgroundColor: isLegal ? Colors.white : const Color(0xffA8A8A8),
      minWidth: 315.dp,
      minHeight: 50.dp,
      enabled: isLegal,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.dp))),
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        viewModel.userNameLogin();
      },
    );
  }

  Widget _buildForgetPWDButton() {
    return Center(
        child: LWButton.text(
      text: LocaleKeys.forget_the_password.tr(),
      textColor: Colors.white.withOpacity(0.67),
      textSize: 12.sp,
      backgroundColor: Colors.transparent,
      minWidth: 70.dp,
      minHeight: 30.dp,
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        pagePush(AppRoute.resetPassword);
      },
    ));
  }

  Widget _buildThirdPartLogin() {
    return Row(
      mainAxisAlignment: Platform.isIOS
          ? MainAxisAlignment.spaceAround
          : MainAxisAlignment.center,
      children: [
        LWButton.text(
          text: LocaleKeys.sign_in_via_facebook.tr(),
          textColor: Colors.white.withOpacity(0.67),
          textSize: 12.sp,
          backgroundColor: Colors.transparent,
          // minWidth: 70.dp,
          // minHeight: 30.dp,
          iconDirection: IconDirection.bottom,
          iconSpacing: 18.dp,
          iconWidget: Image.asset(
            AppIcons.imgLoginByFacebook,
            width: 28.dp,
            height: 28.dp,
          ),
          onPressed: () {
            LogUtil.d('点击了通过Facebook登录');
          },
        ),
        Visibility(
            visible: Platform.isIOS,
            child: LWButton.text(
              text: LocaleKeys.sign_in_via_apple.tr(),
              textColor: Colors.white.withOpacity(0.67),
              textSize: 12.sp,
              backgroundColor: Colors.transparent,
              // minWidth: 70.dp,
              // minHeight: 30.dp,
              iconDirection: IconDirection.bottom,
              iconSpacing: 18.dp,
              iconWidget: Image.asset(
                AppIcons.imgLoginByApple,
                width: 28.dp,
                height: 28.dp,
              ),
              onPressed: () {
                LogUtil.d('点击了通过Apple登录');
              },
            ))
      ],
    );
  }
}
