import 'package:atv/archs/data/entity/res_data.dart';
import 'package:atv/archs/data/entity/res_empty.dart';
import 'package:atv/archs/data/net/http.dart';
import 'package:atv/archs/data/net/http_helper.dart';
import 'package:atv/archs/utils/extension/ext_string.dart';
import 'package:atv/config/data/entity/vehicle/vehicle_info.dart';
import 'package:atv/config/data/entity/vehicle/vehicle_list_model.dart';
import 'package:atv/config/data/entity/vehicle/vehicle_share_key.dart';

class ApiVehicle {
  ApiVehicle._();

  /// 控制车辆 指令：0=灯光，1=鸣笛（不可输入其他指令）
  static Future<ResEmpty> controlVehicle({int instructions = 0}) async {
    try {
      var data = await Http.instance()
          .post('api/car/control/lamp', params: {'instructions': instructions});
      return await HttpHelper.httpEmptyConvert(data);
    } catch (e) {
      throw HttpHelper.handleException(e);
    }
  }

  /// 车主绑定车辆
  static Future<ResEmpty> bindVehicle(int deviceCode) async {
    try {
      var data = await Http.instance()
          .post('api/car/binding', params: {'deviceCode': deviceCode});
      return await HttpHelper.httpEmptyConvert(data);
    } catch (e) {
      throw HttpHelper.handleException(e);
    }
  }

  /// 切换驾驶模式 驾驶模式：0=ECO模式，1=运动模式，2=狂暴模式
  static Future<ResEmpty> switchDriveMode(int drivingModeType) async {
    try {
      var data = await Http.instance().post('api/car/control/switch/dt',
          params: {'drivingModeType': drivingModeType});
      return await HttpHelper.httpEmptyConvert(data);
    } catch (e) {
      throw HttpHelper.handleException(e);
    }
  }

  /// 切换动能回收模式 动能回收类型：0=无，1=中，2=强
  static Future<ResEmpty> switchEnergyRecovery(int energyRecoveryType) async {
    try {
      var data = await Http.instance().post('api/car/control/switch/ert',
          params: {'energyRecoveryType': energyRecoveryType});
      return await HttpHelper.httpEmptyConvert(data);
    } catch (e) {
      throw HttpHelper.handleException(e);
    }
  }

  /// 编辑车辆昵称
  static Future<ResEmpty> editVehicleName(String nickname) async {
    try {
      var data = await Http.instance()
          .post('api/car/edit/nickname', params: {'nickname': nickname});
      return await HttpHelper.httpEmptyConvert(data);
    } catch (e) {
      throw HttpHelper.handleException(e);
    }
  }

  /// 开启/关闭蓝牙钥匙
  static Future<ResEmpty> onOrCloseMobileKey() async {
    try {
      var data = await Http.instance().post('api/car/enabled/mobileKey');
      return await HttpHelper.httpEmptyConvert(data);
    } catch (e) {
      throw HttpHelper.handleException(e);
    }
  }

  /// 开启/关闭速度限制
  static Future<ResEmpty> onOrClosSpeedLimit() async {
    try {
      var data = await Http.instance().post('api/car/enabled/speedLimit');
      return await HttpHelper.httpEmptyConvert(data);
    } catch (e) {
      throw HttpHelper.handleException(e);
    }
  }

  /// 获取车况信息
  static Future<ResData<VehicleInfo>> getCurrentVehicleInfo() async {
    try {
      var data = await Http.instance().get('api/car/get/detail');
      return await HttpHelper.httpDataConvert(
          data, (json) => VehicleInfo.fromJson(json));
    } catch (e) {
      throw HttpHelper.handleException(e);
    }
  }

  /// 获取车钥匙 此接口限制30秒访问一次
  static Future<ResData<VehicleShareKey>> getSharedKey() async {
    try {
      var data = await Http.instance().get('api/car/get/key');
      return await HttpHelper.httpDataConvert(
          data, (json) => VehicleShareKey.fromJson(json));
    } catch (e) {
      throw HttpHelper.handleException(e);
    }
  }

  /// 获取车辆列表
  static Future<ResData<List<VehicleListModel>>> getVehicleList() async {
    try {
      var data = await Http.instance().get('api/car/get/list');
      return await HttpHelper.httpListConvert(data,
          (json) => json.map((e) => VehicleListModel.fromJson(e)).toList());
    } catch (e) {
      throw HttpHelper.handleException(e);
    }
  }

  /// 邀请绑定车辆
  static Future<ResEmpty> inviteBindCar(String carKey) async {
    try {
      var data = await Http.instance()
          .post('api/car/invite/bind', params: {'carKey': carKey});
      return await HttpHelper.httpEmptyConvert(data);
    } catch (e) {
      throw HttpHelper.handleException(e);
    }
  }

  /// 删除（解绑）车辆
  static Future<ResEmpty> unbindCar({String? userDeviceId}) async {
    try {
      var params = <String, dynamic>{};
      if (userDeviceId.isNullOrEmpty() == false) {
        params['userDeviceId'] = userDeviceId;
      }
      var data = await Http.instance().post('api/car/remove', params: params);
      return await HttpHelper.httpEmptyConvert(data);
    } catch (e) {
      throw HttpHelper.handleException(e);
    }
  }

  /// 切换车辆
  static Future<ResEmpty> changeSelectVehicle(String deviceId) async {
    try {
      var data = await Http.instance()
          .post('api/car/switch', params: {'deviceId': deviceId});
      return await HttpHelper.httpEmptyConvert(data);
    } catch (e) {
      throw HttpHelper.handleException(e);
    }
  }
}
