import 'package:atv/archs/data/entity/res_data.dart';
import 'package:atv/archs/data/entity/res_empty.dart';
import 'package:atv/archs/data/net/http.dart';
import 'package:atv/archs/data/net/http_helper.dart';
import 'package:atv/config/data/entity/vehicle/device_regist_param.dart';

class ApiDevice {
  ApiDevice._();

  /// 激活设备前置检查  deviceName 设备的唯一标识(车架号)
  static Future<ResEmpty> checkVehicleRegisterValid(String deviceName) async {
    try {
      var data = await Http.instance().post('api/device/check/device/bind',
          params: {'deviceName': deviceName});
      return await HttpHelper.httpEmptyConvert(data);
    } catch (e) {
      throw HttpHelper.handleException(e);
    }
  }

  /// 设备激活成功通知服务器 deviceName 设备的唯一标识(车架号)
  /// bluetoothAddress 蓝牙名称
  /// bluetoothSecretKey 蓝牙连接成功返回的key
  /// simID 蓝牙连接成功后返回的simID
  static Future<ResEmpty> vehicleRegisterSuccess(String deviceName,
      String bluetoothAddress, int bluetoothSecretKey, String simID) async {
    try {
      var data =
          await Http.instance().post('api/device/activation/success', params: {
        'deviceName': deviceName,
        'bluetoothAddress': bluetoothAddress,
        'bluetoothSecretKey': bluetoothSecretKey,
        'simID': simID
      });
      return await HttpHelper.httpEmptyConvert(data);
    } catch (e) {
      throw HttpHelper.handleException(e);
    }
  }

  /// DeviceRegistParam
  /// 获取注册设备到指定产品下所需要的证书 deviceName 设备的唯一标识(车架号)
  static Future<ResData<DeviceRegistParam>> getDeviceCertificate(
      String deviceName) async {
    try {
      var data = await Http.instance()
          .get('api/device/get/secret', params: {'deviceName': deviceName});
      return await HttpHelper.httpDataConvert(
          data, (json) => DeviceRegistParam.fromJson(json));
    } catch (e) {
      throw HttpHelper.handleException(e);
    }
  }

  /// DeviceRegistParam
  /// 蓝牙数据上传到服务器
  static Future<ResEmpty> uploadBluetoothDataToServer(
      Map<String, dynamic> dataMap) async {
    try {
      var data = await Http.instance().post('api/device/xxx', params: dataMap);
      return await HttpHelper.httpEmptyConvert(data);
    } catch (e) {
      throw HttpHelper.handleException(e);
    }
  }
}
