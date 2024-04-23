import 'package:atv/archs/base/base_view_model.dart';
import 'package:atv/archs/base/event_manager.dart';
import 'package:atv/archs/utils/log_util.dart';
import 'package:atv/config/conf/app_event.dart';
import 'package:atv/config/data/entity/mainPage/main_page_model.dart';
import 'package:atv/config/data/entity/vehicle%20/vehicle_info.dart';
import 'package:atv/config/net/api_vehicle.dart';
import 'package:atv/widgetLibrary/complex/toast/lw_toast.dart';
import 'package:basic_utils/basic_utils.dart';

class SafetyInfoPageViewModel extends BaseViewModel {
  VehicleInfo? dataModel;
  getData() {
    loadApiData<VehicleInfo>(
      ApiVehicle.getCurrentVehicleInfo(),
      handlePageState: false,
      showLoading: true,
      dataSuccess: (data) {
        dataModel = data;
        mobileKeysIsOn = dataModel?.mobileKey ?? false;
        speedLimitIsOn = dataModel?.speedLimit ?? false;
        pageRefresh();
      },
    );
  }

  bool inDeleteMode = false;

  /// 手机钥匙是否打开
  bool mobileKeysIsOn = false;

  /// 速度限制模式是否打开
  bool speedLimitIsOn = false;

  /// 打开/关闭蓝牙钥匙
  onOrCloseMobileKeys(Function(bool isSuccess)? callback) {
    loadApiData(
      ApiVehicle.onOrCloseMobileKey(),
      handlePageState: false,
      showLoading: true,
      voidSuccess: () {
        dataModel?.mobileKey = !(dataModel?.mobileKey ?? false);
        mobileKeysIsOn = dataModel?.mobileKey ?? false;
        pageRefresh();
        EventManager.post(AppEvent.vehicleInfoChange);
      },
      onFailed: (errorMsg) {
        if (errorMsg?.isNotEmpty == true) {
          LWToast.show(errorMsg!);
          mobileKeysIsOn = dataModel?.mobileKey ?? false;
          Future.delayed(const Duration(seconds: 2), () {
            pageRefresh();
          });
        } else {
          mobileKeysIsOn = dataModel?.mobileKey ?? false;
          pageRefresh();
        }
      },
    );
  }

  /// 开启/关闭速度限制
  onOrCloseSpeedLimit(Function(bool isSuccess)? callback) {
    loadApiData(
      ApiVehicle.onOrClosSpeedLimit(),
      handlePageState: false,
      showLoading: true,
      voidSuccess: () {
        dataModel?.speedLimit = !(dataModel?.speedLimit ?? false);
        speedLimitIsOn = dataModel?.speedLimit ?? false;
        pageRefresh();
        EventManager.post(AppEvent.vehicleInfoChange);
      },
      onFailed: (errorMsg) {
        if (errorMsg?.isNotEmpty == true) {
          LWToast.show(errorMsg!);
          speedLimitIsOn = dataModel?.speedLimit ?? false;
          Future.delayed(const Duration(seconds: 2), () {
            pageRefresh();
          });
        } else {
          speedLimitIsOn = dataModel?.speedLimit ?? false;
          pageRefresh();
        }
      },
    );
  }

  /// 获取车钥匙
  getShareCarKey(Function(bool isSuccess, {String? carKey})? callback) {
    loadApiData(ApiVehicle.getSharedKey(),
        handlePageState: false, showLoading: true, dataSuccess: (data) {
      if (callback != null) {
        callback(true, carKey: data.carKey);
      }
    });
  }

  /// 解绑车辆
  deleteCar(String? userDeviceId) {
    if (StringUtils.isNullOrEmpty(userDeviceId) == false) {
      loadApiData(
        ApiVehicle.unbindCar(userDeviceId: userDeviceId),
        handlePageState: false,
        showLoading: true,
        voidSuccess: () {
          EventManager.post(AppEvent.vehicleInfoChange);
        },
      ).then((value) {
        if (value != null) {
          getData();
        }
      });
    }
  }

  // changeEnergyRecovery(int energyRecoveryType) {
  //   if ([0, 1, 2].contains(energyRecoveryType) == false) {
  //     return;
  //   }
  //   loadApiData(
  //     ApiVehicle.switchEnergyRecovery(energyRecoveryType),
  //     handlePageState: false,
  //     showLoading: true,
  //     voidSuccess: () {
  //       homeModel?.energyRecovery = energyRecoveryType;
  //       pageRefresh();
  //       EventManager.post(AppEvent.vehicleInfoChange);
  //     },
  //     onFailed: (errorMsg) {
  //       pageRefresh();
  //     },
  //   );
  // }

  @override
  void initialize(args) {
    getData();
  }

  @override
  void release() {
    // TODO: implement release
  }
}
