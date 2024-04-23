import 'package:atv/archs/base/base_mvvm_page.dart';
import 'package:atv/archs/utils/log_util.dart';
import 'package:atv/config/conf/app_icons.dart';
import 'package:atv/generated/locale_keys.g.dart';
import 'package:atv/pages/Login/viewModel/register_view_model.dart';
import 'package:atv/widgetLibrary/basic/button/lw_button.dart';
import 'package:atv/widgetLibrary/basic/font/lw_font_weight.dart';
import 'package:atv/widgetLibrary/utils/size_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginRegisterPage extends BaseMvvmPage {
  @override
  State<StatefulWidget> createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState
    extends BaseMvvmPageState<LoginRegisterPage, RegisterViewModel> {
  @override
  RegisterViewModel viewModelProvider() => RegisterViewModel();
  @override
  bool isSupportScrollView() => true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _verifyCodeController = TextEditingController();
  final TextEditingController _confirmPwdController = TextEditingController();

  @override
  Widget? headerBackgroundWidget() {
    return Image.asset(
      AppIcons.imgLoginBg,
      fit: BoxFit.cover,
    );
  }

  @override
  String? titleName() => LocaleKeys.create_a_user.tr();

  @override
  Widget buildBody(BuildContext context) {
    var isInputAll = viewModel.judgeIsInputAll;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 30.dp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 12.dp,
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
            LocaleKeys.email_verification_code.tr(),
            style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: LWFontWeight.bold),
          ),
          SizedBox(
            height: 20.dp,
          ),
          SizedBox(
            height: 43.dp,
            child: Stack(
              children: [
                _buildVerifyCodeInputField(),
                Positioned(
                    bottom: 5.dp,
                    right: 10.dp,
                    child: LWButton.text(
                      text: viewModel.sendVCodeTitle,
                      textColor: const Color(0xff36BCB3),
                      textSize: 12.sp,
                      minHeight: 40.dp,
                      onPressed: () {
                        viewModel.getVfCode();
                      },
                    )),
              ],
            ),
          ),
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
            height: 40.dp,
          ),
          Text(
            LocaleKeys.confirm_password.tr(),
            style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: LWFontWeight.bold),
          ),
          SizedBox(
            height: 20.dp,
          ),
          _buildConfirmPWDInputField(),
          SizedBox(
            height: 58.dp,
          ),
          _buildNextButton(isInputAll),
        ],
      ),
    );
  }

  Widget _buildEmailInputField() {
    return SizedBox(
      height: 42.dp,
      child: TextFormField(
          onChanged: (value) {
            viewModel.params.username = value;
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

  Widget _buildVerifyCodeInputField() {
    return SizedBox(
      height: 42.dp,
      child: TextFormField(
          onChanged: (value) {
            viewModel.params.emailVftCode = value;
            pageRefresh(() {});
          },
          onFieldSubmitted: (value) {
            LogUtil.d('-----');
          },
          controller: _verifyCodeController,
          autofocus: false,
          textAlign: TextAlign.left,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.singleLineFormatter,
            LengthLimitingTextInputFormatter(10),
            // FilteringTextInputFormatter.allow(RegExp(r'^[A-Za-z0-9]+@.$')),
          ],
          maxLines: 1,
          style: TextStyle(
              fontSize: 12.sp, color: Colors.white, height: SizeUtil.dp(1.5)),
          strutStyle: const StrutStyle(forceStrutHeight: true, leading: 0),
          decoration: InputDecoration(
            hintText: LocaleKeys.please_enter_your_email_verification_code.tr(),
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
            viewModel.params.password = value;
            pageRefresh(() {});
          },
          onFieldSubmitted: (value) {
            LogUtil.d('-----');
          },
          controller: _pwdController,
          autofocus: false,
          textAlign: TextAlign.left,
          textInputAction: TextInputAction.next,
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
            hintText: LocaleKeys.password_common_describe.tr(),
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

  Widget _buildConfirmPWDInputField() {
    return SizedBox(
      height: 42.dp,
      child: TextFormField(
          onChanged: (value) {
            viewModel.params.confirmPassword = value;
            pageRefresh(() {});
          },
          onFieldSubmitted: (value) {
            LogUtil.d('-----');
          },
          controller: _confirmPwdController,
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
            hintText: LocaleKeys.password_common_describe.tr(),
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

  Widget _buildNextButton(bool isInputAll) {
    return LWButton.text(
      text: LocaleKeys.submit.tr(),
      textColor: const Color(0xff010101),
      textSize: 16.sp,
      backgroundColor: isInputAll ? Colors.white : const Color(0xffA8A8A8),
      minWidth: 315.dp,
      minHeight: 50.dp,
      enabled: isInputAll,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.dp))),
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        viewModel.submmit();
      },
    );
  }
}
