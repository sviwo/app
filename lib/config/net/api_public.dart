import 'package:atv/archs/data/entity/res_empty.dart';
import 'package:atv/archs/data/net/http.dart';
import 'package:atv/archs/data/net/http_helper.dart';

class ApiPublic {
  ApiPublic._();

  /// 获取验证码
  static Future<ResEmpty> getVftCode(String email) async {
    try {
      var data = await Http.instance()
          .get('common/getVftCode', params: {'email': email});
      return await HttpHelper.httpEmptyConvert(data);
    } catch (e) {
      throw HttpHelper.handleException(e);
    }
  }
}
