import 'package:atv/archs/data/entity/res_data.dart';
import 'package:atv/archs/data/entity/res_empty.dart';
import 'package:atv/archs/data/net/http.dart';
import 'package:atv/archs/data/net/http_helper.dart';
import 'package:atv/config/data/entity/common/media_content.dart';
import 'package:atv/config/data/entity/common/media_tree.dart';

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

  /// 获取APP媒体标题树
  /// 页面类型：0=帮助页，1=注册用户页，2=视屏教程页
  static Future<ResData<List<MediaTree>>> getHttpPageTree(int pageType) async {
    try {
      var data = await Http.instance()
          .get('app/media/get/tree', params: {'pageType': pageType});
      return await HttpHelper.httpListConvert(
          data, (json) => json.map((e) => MediaTree.fromJson(e)).toList());
    } catch (e) {
      throw HttpHelper.handleException(e);
    }
  }

  /// 获取APP文本内容
  static Future<ResData<MediaContent>> getHttpPageContent(String id) async {
    try {
      var data =
          await Http.instance().get('app/media/get/detail', params: {'id': id});
      return await HttpHelper.httpDataConvert(
          data, (json) => MediaContent.fromJson(data));
    } catch (e) {
      throw HttpHelper.handleException(e);
    }
  }
}
