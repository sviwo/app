import 'package:atv/archs/base/base_view_model.dart';
import 'package:basic_utils/basic_utils.dart';

class RegisterViewModel extends BaseViewModel {
  /// 登录的邮箱名
  String emailName = '';

  /// 登录的密码
  String password = '';

  /// 邮箱验证码
  String verifyCode = '';

  /// 确认密码
  String confirmPassword = '';

  /// 判断所有输入是否合法
  bool judgeIsLegal() {
    return EmailUtils.isEmail(emailName) &&
        verifyCode.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        password == confirmPassword;
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
