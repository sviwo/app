// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> zh = {
    "sign_in_now": "立即登录",
    "user_register": "用户注册",
    "by_registering_you_agree": "注册即代表您同意",
    "user_agreement": "《用户协议》",
    "and": "和",
    "privacy_policy": "《隐私政策》",
    "login": "登录",
    "email": "电子邮箱",
    "password": "密码",
    "please_enter_your_email_address": "请输入电子邮箱",
    "enter_your_PIN": "请输入密码",
    "next_step": "下一步",
    "forget_the_password": "忘记密码",
    "sign_in_via_facebook": "通过Facebook登录",
    "sign_in_via_apple": "通过Apple登录",
    "create_a_user": "创建用户",
    "email_verification_code": "邮箱验证码",
    "please_enter_your_email_verification_code": "请输入邮箱验证码",
    "confirm_password": "确认密码",
    "please_enter_your_confirmation_password": "请输入确认密码",
    "submit": "提交",
  };
  static const Map<String, dynamic> en = {
    "sign_in_now": "sign in now",
    "user_register": "user register",
    "by_registering_you_agree": "By registering, you agree",
    "user_agreement": "《user agreement》",
    "and": "and",
    "privacy_policy": "《privacy policy》",
    "login": "login",
    "email": "email",
    "password": "password",
    "please_enter_your_email_address": "Please enter your email address",
    "enter_your_PIN": "enter your PIN",
    "next_step": "next step",
    "forget_the_password": "forget the password",
    "sign_in_via_facebook": "Sign in via Facebook",
    "sign_in_via_apple": "Sign in via Apple",
    "create_a_user": "Create a user",
    "email_verification_code": "Email verification code",
    "please_enter_your_email_verification_code":
        "Please enter your email verification code",
    "confirm_password": "confirm password",
    "please_enter_your_confirmation_password":
        "Please enter your confirmation password",
    "submit": "submit"
  };
  static const Map<String, dynamic> fr = {};
  static const Map<String, dynamic> es = {};
  static const Map<String, Map<String, dynamic>> mapLocales = {
    "zh": zh,
    "en": en,
    "fr": fr,
    "es": es
  };
}
