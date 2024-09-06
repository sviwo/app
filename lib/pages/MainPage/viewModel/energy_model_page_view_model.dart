import 'package:atv/archs/base/base_view_model.dart';
import 'package:atv/archs/base/event_manager.dart';
import 'package:atv/config/conf/app_event.dart';
import 'package:atv/config/data/entity/mainPage/main_page_model.dart';
import 'package:atv/config/net/api_home_page.dart';
import 'package:atv/config/net/api_vehicle.dart';
import 'package:atv/generated/locale_keys.g.dart';
import 'package:atv/widgetLibrary/complex/toast/lw_toast.dart';
import 'package:easy_localization/easy_localization.dart';

class EnergyModelPageViewModel extends BaseViewModel {
  HomePageModel? homeModel;

  bool get ecoIsOn => homeModel?.drivingMode == 0;
  bool get sportIsOn => homeModel?.drivingMode == 1;
  bool get rageIson => homeModel?.drivingMode == 2;

  changeDriveMode(int driveMode) {
    if ([0, 1, 2].contains(driveMode) == false) {
      return;
    }
    loadApiData(
      ApiVehicle.switchDriveMode(driveMode),
      handlePageState: false,
      showLoading: true,
      voidSuccess: () {
        homeModel?.drivingMode = driveMode;
        pageRefresh();
        EventManager.post(AppEvent.vehicleInfoChange);
      },
      onFailed: (errorMsg) {
        if (errorMsg?.isNotEmpty == true) {
          LWToast.show(errorMsg!);
          Future.delayed(const Duration(seconds: 2), () {
            pageRefresh();
          });
        } else {
          pageRefresh();
        }
      },
    );
  }

  changeEnergyRecovery(int energyRecoveryType) {
    if ([0, 1, 2].contains(energyRecoveryType) == false) {
      return;
    }
    loadApiData(
      ApiVehicle.switchEnergyRecovery(energyRecoveryType),
      handlePageState: false,
      showLoading: true,
      voidSuccess: () {
        homeModel?.energyRecovery = energyRecoveryType;
        pageRefresh();
        EventManager.post(AppEvent.vehicleInfoChange);
      },
      onFailed: (errorMsg) {
        if (errorMsg?.isNotEmpty == true) {
          LWToast.show(errorMsg!);
          Future.delayed(const Duration(seconds: 2), () {
            pageRefresh();
          });
        } else {
          pageRefresh();
        }
      },
    );
  }

  String get sliderText {
    var sliderValue = homeModel?.energyRecovery ?? 0;
    if (sliderValue == 0) {
      return LocaleKeys.none.tr();
    } else if (sliderValue == 1) {
      return LocaleKeys.middle.tr();
    } else if (sliderValue == 2) {
      return LocaleKeys.strong.tr();
    }
    return '';
  }

  @override
  void initialize(args) {
    if (args is Map<String, dynamic>) {
      homeModel = HomePageModel.fromJson(args['home']);
    }
  }

  @override
  void release() {
    // TODO: implement release
  }
}
