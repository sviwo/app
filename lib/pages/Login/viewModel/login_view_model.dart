import 'package:atv/archs/base/base_view_model.dart';
import 'package:basic_utils/basic_utils.dart';

class LoginViewModel extends BaseViewModel {
  /// 登录的邮箱名
  String emailName = '';

  /// 登录的密码
  String password = '';

  bool judgeEmailAndPassword() {
    return EmailUtils.isEmail(emailName) && password.isNotEmpty;
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
