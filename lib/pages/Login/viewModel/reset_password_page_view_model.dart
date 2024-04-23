import 'package:atv/archs/base/base_view_model.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:atv/config/net/api_login.dart';
import 'package:atv/config/net/api_public.dart';
import 'package:atv/generated/locale_keys.g.dart';
import 'package:atv/pages/Login/define/login_defines.dart';
import 'package:atv/widgetLibrary/complex/toast/lw_toast.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:easy_localization/easy_localization.dart';

class ResetPasswordPageViewModel extends BaseViewModel {
  var params = ResetPasswordParams();

  /// 验证码是否已经发送过了
  bool vCodeIsSend = false;

  String get sendVCodeTitle => vCodeIsSend
      ? LocaleKeys.resend_verification_code.tr()
      : LocaleKeys.send_verification_code.tr();

  /// 判断是否都有输入
  bool get judgeIsInputAll => params.judgeIsInputAll;

  /// 判断所有输入是否合法
  bool judgeIsLegal() {
    if (EmailUtils.isEmail(params.username) == false) {
      LWToast.show(LocaleKeys.please_enter_the_correct_email_address.tr());
      return false;
    }
    RegExp numExp = RegExp(r'^\d{6}$');
    if (numExp.hasMatch(params.emailVftCode) == false) {
      LWToast.show(LocaleKeys.verification_code_six_digits.tr());
      return false;
    }
    RegExp pwdExp =
        RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[a-zA-Z0-9]{6,18}$');
    // r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%?])[a-zA-Z0-9!@#$%?_]{6,18}$');
    if (pwdExp.hasMatch(params.newPassword) == false) {
      LWToast.show(LocaleKeys.password_describe.tr());
      return false;
    }
    if (pwdExp.hasMatch(params.confirmPassword) == false) {
      LWToast.show(LocaleKeys.confirm_password_decribe.tr());
      return false;
    }
    if (params.newPassword != params.confirmPassword) {
      LWToast.show(LocaleKeys.entered_password_is_inconsistent.tr());
      return false;
    }

    return true;
  }

  void getVfCode() async {
    if (EmailUtils.isEmail(params.username) == false) {
      LWToast.show(LocaleKeys.please_enter_the_correct_email_address.tr());
      return;
    }
    await loadApiData(
      ApiPublic.getVftCode(params.username),
      showLoading: true,
      handlePageState: false,
      voidSuccess: () {
        LWToast.success(LocaleKeys.verification_code_send_success.tr());
      },
    );
  }

  void submmit() async {
    if (judgeIsLegal()) {
      await loadApiData(
        ApiLogin.resetPassword(params),
        handlePageState: false,
        showLoading: true,
        voidSuccess: () {
          LWToast.success(LocaleKeys.reset_password_success.tr());
          pagePop();
        },
      );
    }
  }

  @override
  void initialize(args) {
    // TODO: implement initialize
  }

  @override
  void release() {
    // TODO: implement release
  }
}
