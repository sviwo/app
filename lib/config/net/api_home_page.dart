import 'package:atv/archs/data/entity/res_data.dart';
import 'package:atv/archs/data/entity/res_empty.dart';
import 'package:atv/archs/data/entity/res_list.dart';
import 'package:atv/archs/data/net/http.dart';
import 'package:atv/archs/data/net/http_helper.dart';
import 'package:atv/config/data/entity/User/user_basic_info.dart';
import 'package:atv/config/data/entity/User/user_real_name_info.dart';
import 'package:atv/config/data/entity/mainPage/main_page_model.dart';
import 'package:atv/config/data/entity/tripRecorder/trip_recorder.dart';
import 'package:atv/pages/MainPage/define/trip_recorder_list_request.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class ApiHomePage {
  ApiHomePage._();

  /// 获取首页数据
  static Future<ResData<HomePageModel>> getHomeData() async {
    try {
      var data = await Http.instance().get('api/home/get/data');
      return await HttpHelper.httpDataConvert(
          data, (json) => HomePageModel.fromJson(json));
    } catch (e) {
      throw HttpHelper.handleException(e);
    }
  }

  /// 获取最新版本信息
  static Future<ResData<HomePageVersion>> getRecentlyVersionInfo() async {
    try {
      var data = await Http.instance().get('api/version/info');
      return await HttpHelper.httpDataConvert(
          data, (json) => HomePageVersion.fromJson(json));
    } catch (e) {
      throw HttpHelper.handleException(e);
    }
  }

  /// 获取用户实名信息
  static Future<ResData<UserRealNameInfo>> getUserRealNameInfo() async {
    try {
      var data = await Http.instance().get('api/user/get/auth');
      return await HttpHelper.httpDataConvert(
          data, (json) => UserRealNameInfo.fromJson(json));
    } catch (e) {
      throw HttpHelper.handleException(e);
    }
  }

  /// 提交用户实名信息
  static Future<ResEmpty> submmitUserRealNameInfo(
      {String? authFirstName,
      String? authLastName,
      XFile? certificateFrontImgFile,
      XFile? certificateBackImgFile}) async {
    try {
      Map<String, dynamic> params = {};
      if (authFirstName != null) {
        params['authFirstName'] = authFirstName;
      }
      if (authLastName != null) {
        params['authLastName'] = authLastName;
      }
      if (certificateFrontImgFile != null) {
        final mimeType = lookupMimeType(certificateFrontImgFile.path);
        var fileData = await MultipartFile.fromFile(
            certificateFrontImgFile.path,
            contentType: MediaType.parse(mimeType ?? 'image/jpeg'));
        params['certificateFrontImg'] = fileData;
      }
      if (certificateBackImgFile != null) {
        final mimeType = lookupMimeType(certificateBackImgFile.path);
        var fileData = await MultipartFile.fromFile(certificateBackImgFile.path,
            contentType: MediaType.parse(mimeType ?? 'image/jpeg'));
        params['certificateBackImg'] = fileData;
      }
      var formData = FormData.fromMap(params);
      var data =
          await Http.instance().post('api/user/submit/auth', data: formData);
      return await HttpHelper.httpEmptyConvert(data);
    } catch (e) {
      throw HttpHelper.handleException(e);
    }
  }

  /// 获取用户基本信息
  static Future<ResData<UserBasicInfo>> getUserBasicInfo() async {
    try {
      var data = await Http.instance().get('api/user/info');
      return await HttpHelper.httpDataConvert(
          data, (json) => UserBasicInfo.fromJson(json));
    } catch (e) {
      throw HttpHelper.handleException(e);
    }
  }

  /// 编辑用户基本信息
  static Future<ResEmpty> submmitUserBasicInfo(UserBasicInfo? model,
      {bool isHeader = false, XFile? file}) async {
    try {
      if (isHeader == true && file != null) {
        final mimeType = lookupMimeType(file.path);
        var fileData = await MultipartFile.fromFile(file.path,
            contentType: MediaType.parse(mimeType ?? 'image/jpeg'));

        var params = UserBasicInfo().toJson();
        params['headImg'] = fileData;
        var formData = FormData.fromMap(params);
        var data =
            await Http.instance().post('api/user/edit/info', data: formData);
        return await HttpHelper.httpEmptyConvert(data);
      } else {
        var data =
            await Http.instance().post('api/user/edit/info', data: model);
        return await HttpHelper.httpEmptyConvert(data);
      }
    } catch (e) {
      throw HttpHelper.handleException(e);
    }
  }

  /// 获取行程列表
  static Future<ResData<ResList<TripRecorder>>> getTripRecorderList(
      TripRecorderListRequest request) async {
    try {
      var data = await Http.instance()
          .get('api/travelRecord/list/get', params: request.toJson());
      return await HttpHelper.httpDataConvert<ResList<TripRecorder>>(data,
          (json) {
        return ResList<TripRecorder>.fromJson(json, (j) {
          return TripRecorder.fromJson(j);
        });
      });
    } catch (e) {
      throw HttpHelper.handleException(e);
    }
  }

  /// 删除行程
  static Future<ResEmpty> deleteTripRecorder(String travelRecordId) async {
    try {
      var data = await Http.instance().post('api/travelRecord/delete',
          data: {'travelRecordId': travelRecordId});
      return await HttpHelper.httpEmptyConvert(data);
    } catch (e) {
      throw HttpHelper.handleException(e);
    }
  }
}
