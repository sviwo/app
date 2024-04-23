import 'package:atv/archs/data/entity/res_data.dart';
import 'package:atv/archs/data/entity/res_empty.dart';
import 'package:atv/archs/data/net/http.dart';
import 'package:atv/archs/data/net/http_helper.dart';
import 'package:atv/config/data/entity/Login/login_response.dart';
import 'package:atv/pages/Login/define/login_defines.dart';

class ApiLogin {
  ApiLogin._();

  /// 注册
  static Future<ResEmpty> registUser(RegistParams paramsData) async {
    try {
      var data = await Http.instance().post('user/register', data: paramsData);
      return await HttpHelper.httpEmptyConvert(data);
    } catch (e) {
      throw HttpHelper.handleException(e);
    }
  }

  /// 重置密码
  static Future<ResEmpty> resetPassword(ResetPasswordParams paramsData) async {
    try {
      var data =
          await Http.instance().post('user/update/password', data: paramsData);
      return await HttpHelper.httpEmptyConvert(data);
    } catch (e) {
      throw HttpHelper.handleException(e);
    }
  }

  /// 登录
  /// -loginType：登陆类型：1=账号+密码，2=第三方
  static Future<ResData<LoginResponse>> login(
      {String username = '', String password = '', int loginType = 1}) async {
    try {
      Map<String, dynamic> params = {'loginType': loginType};
      if (username.isNotEmpty) {
        params['username'] = username;
      }
      if (password.isNotEmpty) {
        params['password'] = password;
      }
      var data = await Http.instance().post('api/login', data: params);
      return await HttpHelper.httpDataConvert<LoginResponse>(
          data, (json) => LoginResponse.fromJson(json));
    } catch (e) {
      throw HttpHelper.handleException(e);
    }
  }
}
