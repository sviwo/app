import 'package:atv/archs/base/base_view_model.dart';
import 'package:atv/archs/base/event_manager.dart';
import 'package:atv/archs/utils/extension/ext_string.dart';
import 'package:atv/config/conf/app_event.dart';
import 'package:atv/config/data/entity/vehicle/vehicle_info.dart';
import 'package:atv/config/net/api_vehicle.dart';
import 'package:atv/generated/locale_keys.g.dart';
import 'package:atv/widgetLibrary/complex/toast/lw_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class VehicleConditionInformationPageViewModel extends BaseViewModel {
  bool isOwn = false;

  VehicleInfo? dataModel;
  getData() {
    loadApiData<VehicleInfo>(
      ApiVehicle.getCurrentVehicleInfo(),
      handlePageState: false,
      showLoading: true,
      dataSuccess: (data) {
        dataModel = data;
        pageRefresh();
      },
    );
  }

  changeVehicleName(String vehicleName, Function(bool isSuccess)? callback) {
    if (vehicleName.isNullOrEmpty()) {
      LWToast.show(LocaleKeys.please_enter_vehicle_name.tr());
      if (callback != null) {
        callback(false);
      }
      return;
    }
    loadApiData(
      ApiVehicle.editVehicleName(vehicleName),
      handlePageState: false,
      showLoading: true,
      voidSuccess: () {
        dataModel?.nickname = vehicleName;
        if (callback != null) {
          callback(true);
        }
        pageRefresh();
        EventManager.post(AppEvent.vehicleInfoChange);
      },
      onFailed: (errorMsg) {
        if (errorMsg?.isNotEmpty == true) {
          LWToast.show(errorMsg!);

          Future.delayed(const Duration(seconds: 2), () {
            if (callback != null) {
              callback(false);
            }
            pageRefresh();
          });
        } else {
          if (callback != null) {
            callback(false);
          }
          pageRefresh();
        }
      },
    );
  }

  @override
  void initialize(args) {
    // TODO: implement initialize
    if (args is Map<String, dynamic>) {
      isOwn = args['userDeviceType'] == 0;
    }
    getData();
  }

  @override
  void release() {
    // TODO: implement release
  }
}
