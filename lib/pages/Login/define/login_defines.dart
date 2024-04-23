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
