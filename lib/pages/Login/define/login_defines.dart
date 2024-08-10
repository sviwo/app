import 'package:basic_utils/basic_utils.dart';

class RegistParams {
  RegistParams({
    this.username = '',
    this.emailVftCode = '',
    this.password = '',
    this.confirmPassword = '',
  });
  String username;
  String emailVftCode;
  String password;
  String confirmPassword;

  /// 判断是否都有输入
  bool get judgeIsInputAll {
    return username.isNotEmpty &&
        emailVftCode.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty;
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'username': username,
      'emailVftCode': emailVftCode,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }
}

class ResetPasswordParams {
  ResetPasswordParams({
    this.username = '',
    this.emailVftCode = '',
    this.newPassword = '',
    this.confirmPassword = '',
  });
  String username;
  String emailVftCode;
  String newPassword;
  String confirmPassword;

  /// 判断是否都有输入
  bool get judgeIsInputAll {
    return username.isNotEmpty &&
        emailVftCode.isNotEmpty &&
        newPassword.isNotEmpty &&
        confirmPassword.isNotEmpty;
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'username': username,
      'emailVftCode': emailVftCode,
      'newPassword': newPassword,
      'confirmPassword': confirmPassword,
    };
  }
}

class LoginParams {
  LoginParams(
      {this.username,
      this.password,
      this.userIdentifier,
      this.identityToken,
      this.accessToken,
      this.loginType = 1});
  String? username;
  String? password;
  String? userIdentifier;
  String? identityToken;
  String? accessToken;

  ///登陆类型:1=账号+密码，2=apple，3=facebook
  int loginType;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'username': username,
      'password': password,
      'userIdentifier': userIdentifier,
      'identityToken': identityToken,
      'accessToken': accessToken,
      'loginType': loginType,
    };
  }
}
