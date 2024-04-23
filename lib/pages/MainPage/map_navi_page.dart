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
import 'package:atv/widgetLibrary/utils/size_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapNaviPage extends BasePage {
  @override
  State<MapNaviPage> createState() => _MapNaviPageState();
}

class _MapNaviPageState extends State<MapNaviPage> {
  @override
  Widget build(BuildContext context) {
    LogUtil.d('-----');
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition:
            CameraPosition(target: LatLng(30.976311, 103.644539)),
        onMapCreated: _onMapCreated,
        // markers: <Marker>{},
      ),
    );
  }

  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    LogUtil.d('map created');
    mapController = controller;
  }
}

// class MapNaviPage extends BaseMvvmPage {
//   @override
//   State<StatefulWidget> createState() => _MapNaviPageState();
// }

// class _MapNaviPageState
//     extends BaseMvvmPageState<MapNaviPage, MapNaviPageViewModel> {
//   @override
//   MapNaviPageViewModel viewModelProvider() => MapNaviPageViewModel();
//   @override
//   String? titleName() {
//     // TODO: implement titleName
//     return '地图页面';
//   }
//   // String? titleName() => LocaleKeys.place.tr();
//   // @override
//   // Widget? headerBackgroundWidget() {
//   //   return Container();
//   // }

//   late GoogleMapController mapController;

//   void _onMapCreated(GoogleMapController controller) {
//     LogUtil.d('map created');
//     mapController = controller;
//   }

//   // @override
//   // Widget build(BuildContext context) {
//   //   // TODO: implement build
//   //   return Scaffold(
//   //     body: GoogleMap(
//   //       initialCameraPosition: CameraPosition(target: LatLng(30, 103)),
//   //       onMapCreated: _onMapCreated,
//   //       // markers: <Marker>{},
//   //     ),
//   //   );
//   // }

//   @override
//   Widget buildBody(BuildContext context) {
//     return GoogleMap(
//       initialCameraPosition: CameraPosition(target: LatLng(30, 103)),
//       // onMapCreated: _onMapCreated,
//       // markers: <Marker>{},
//     );
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           // color: Colors.red,
//           width: 375.dp,
//           height: 442.dp,
//           child: Stack(
//             fit: StackFit.expand,
//             children: [
//               GoogleMap(
//                 initialCameraPosition:
//                     CameraPosition(target: LatLng(40.43, 74)),
//                 // initialCameraPosition: CameraPosition(
//                 //     target: LatLng(viewModel.initialLoation?.latitude ?? 0,
//                 //         viewModel.initialLoation?.longitude ?? 0)),
//                 // onMapCreated: _onMapCreated,
//                 onTap: (argument) {
//                   LogUtil.d('点击了');
//                 },
//                 // markers: <Marker>{},
//               ),
//             ],
//           ),
//         ),
//         Expanded(
//             child: Container(
//           color: Colors.red,
//         ))
//       ],
//     );
//   }
// }
