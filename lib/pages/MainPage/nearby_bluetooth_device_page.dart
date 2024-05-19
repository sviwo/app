import 'package:atv/archs/base/base_mvvm_page.dart';
import 'package:atv/config/conf/app_icons.dart';
import 'package:atv/generated/locale_keys.g.dart';
import 'package:atv/pages/MainPage/viewModel/nearby_bluetooth_device_page_view_model.dart';
import 'package:atv/tools/language/lw_language_tool.dart';
import 'package:atv/widgetLibrary/basic/font/lw_font_weight.dart';
import 'package:atv/widgetLibrary/utils/size_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class NearByBluetoothDevicesPage extends BaseMvvmPage {
  @override
  State<StatefulWidget> createState() => _NearByBluetoothDevicesPageState();
}

class _NearByBluetoothDevicesPageState extends BaseMvvmPageState<
    NearByBluetoothDevicesPage, NearByBluetoothDevicesPageViewModel> {
  @override
  NearByBluetoothDevicesPageViewModel viewModelProvider() =>
      NearByBluetoothDevicesPageViewModel();
  @override
  String? titleName() => LocaleKeys.nearby_devices.tr();
  @override
  Widget? headerBackgroundWidget() {
    return Image.asset(
      AppIcons.imgCommonBgNoStar,
      fit: BoxFit.cover,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  bool isSupportScrollView() => false;
  @override
  Widget buildBody(BuildContext context) {
    // TODO: implement buildBody
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30.dp,
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.dp),
            child: Text(
              LocaleKeys.nearby_devices.tr(),
              style: TextStyle(
                  color: const Color(0xff36BCB3),
                  fontSize: 16.sp,
                  fontWeight: LWFontWeight.normal),
            )),
        Expanded(
            child: StreamBuilder<List<ScanResult>>(
          initialData: const [],
          stream: viewModel.bluetoothDeviceList,
          builder: (context, snapshot) {
            var peripherals = snapshot.data ?? [];
            return ListView.separated(
                // shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  // device.platformName 蓝牙名称
                  // device.remoteId.str 蓝牙mac
                  var device = peripherals[index];
                  var isCurrent = viewModel.isCurrent(device);
                  return InkWell(
                      onTap: () {
                        //MAKR: 选择设备
                        viewModel.chooseDevice(device);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.dp, vertical: 20.dp),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              viewModel.bluetoothName(device),
                              style: TextStyle(
                                  color: isCurrent
                                      ? Colors.white
                                      : const Color(0xff8E8E8E),
                                  fontSize: 14.sp,
                                  fontWeight: LWFontWeight.normal),
                            )),
                            SizedBox(
                              width: 10.dp,
                            ),
                            Visibility(
                                visible: isCurrent,
                                child: Image.asset(
                                  AppIcons.imgCommonCheck,
                                  width: 12.dp,
                                  height: 8.3.dp,
                                ))
                          ],
                        ),
                      ));
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 1.dp,
                  );
                },
                itemCount: peripherals.length);
          },
        ))
      ],
    );
  }
}
