import 'package:atv/archs/base/base_mvvm_page.dart';
import 'package:atv/archs/base/base_page.dart';
import 'package:atv/archs/utils/log_util.dart';
import 'package:atv/config/conf/app_icons.dart';
import 'package:atv/config/data/entity/mainPage/geo_location_define.dart';
import 'package:atv/generated/locale_keys.g.dart';
import 'package:atv/pages/MainPage/viewModel/map_navi_page_view_model.dart';
import 'package:atv/pages/MainPage/viewModel/service_info_page_view_model.dart';
import 'package:atv/tools/map/lw_map_tool.dart';
import 'package:atv/widgetLibrary/basic/button/lw_button.dart';
import 'package:atv/widgetLibrary/complex/titleBar/lw_title_bar.dart';
import 'package:atv/widgetLibrary/utils/size_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapNaviPage extends BaseMvvmPage {
  @override
  State<StatefulWidget> createState() => _MapNaviPageState();
}

class _MapNaviPageState
    extends BaseMvvmPageState<MapNaviPage, MapNaviPageViewModel> {
  @override
  MapNaviPageViewModel viewModelProvider() => MapNaviPageViewModel();

  @override
  String? titleName() => LocaleKeys.place.tr();

  @override
  Widget? headerBackgroundWidget() {
    return Image.asset(
      AppIcons.imgCommonBgDownStar,
      fit: BoxFit.cover,
    );
  }

  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    LogUtil.d('map created');
    mapController = controller;
  }

  bool _isFirstBuild = true;

  @override
  Widget build(BuildContext context) {
    if (_isFirstBuild) {
      initializeVM();
      LogUtil.d('++++++$args');
      _isFirstBuild = false;
    }
    // TODO: implement build
    return Stack(
      fit: StackFit.expand,
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
              target: LatLng(viewModel.initialLoation?.latitude ?? 0,
                  viewModel.initialLoation?.longitude ?? 0),
              zoom: 15),
          onMapCreated: _onMapCreated,
          onTap: (argument) {
            LogUtil.d('点击了');
          },
          markers: <Marker>{
            Marker(
                markerId: const MarkerId('current'),
                position: LatLng(viewModel.initialLoation?.latitude ?? 0,
                    viewModel.initialLoation?.longitude ?? 0))
          },
        ),
        // GestureDetector(
        //   behavior: HitTestBehavior.translucent,
        //   child: pageBuilder(
        //     titleName(),
        //     titleBar: LWTitleBar(
        //       titleName: titleName(),
        //       backgroundAlpha: 0,
        //       // actions: _titleActionsBuilder()
        //     ),
        //     backgroundColor: Colors.transparent,
        //     body: Column(),
        //     bottomBar: bottomBarBuilder(),
        //   ),
        // )
      ],
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // color: Colors.red,
          width: 375.dp,
          height: 442.dp,
          child: Stack(
            fit: StackFit.expand,
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(viewModel.initialLoation?.latitude ?? 0,
                        viewModel.initialLoation?.longitude ?? 0)),
                onMapCreated: _onMapCreated,
                onTap: (argument) {
                  LogUtil.d('点击了');
                },
                // markers: <Marker>{},
              ),
            ],
          ),
        ),
        Expanded(
            child: Container(
          color: Colors.red,
        ))
      ],
    );
  }
}
