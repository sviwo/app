import 'package:atv/archs/base/base_mvvm_page.dart';
import 'package:atv/archs/base/base_page.dart';
import 'package:atv/archs/utils/log_util.dart';
import 'package:atv/config/conf/app_icons.dart';
import 'package:atv/config/data/entity/mainPage/geo_location_define.dart';
import 'package:atv/generated/locale_keys.g.dart';
import 'package:atv/pages/MainPage/viewModel/map_navi_page_view_model.dart';
import 'package:atv/tools/map/lw_map_tool.dart';
import 'package:atv/widgetLibrary/basic/font/lw_font_weight.dart';
import 'package:atv/widgetLibrary/utils/size_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MapNaviPage extends BaseMvvmPage {
  @override
  State<StatefulWidget> createState() => _MapNaviPageState();
}

class _MapNaviPageState
    extends BaseMvvmPageState<MapNaviPage, MapNaviPageViewModel> {
  @override
  MapNaviPageViewModel viewModelProvider() => MapNaviPageViewModel();

  var _slidingController = PanelController();
  late GoogleMapController _mapController;

  StateSetter? listStateSetter;

  void _onMapCreated(GoogleMapController controller) {
    LogUtil.d('map created');
    _mapController = controller;
  }

  bool _isFirstBuild = true;

  @override
  Widget build(BuildContext context) {
    if (_isFirstBuild) {
      initializeVM();
      _isFirstBuild = false;
      viewModel.request(
        viewModel.searchKey,
        callBack: () {
          pageRefresh(() {});
        },
      );
      // viewModel.request(
      //   viewModel.searchKey,
      //   callBack: () {
      //     if (listStateSetter != null) {
      //       listStateSetter?.call;
      //     }
      //   },
      // );
    }
    return Scaffold(
      body: SlidingUpPanel(
        controller: _slidingController,
        panelBuilder: (sc) => _buildPannel(sc),
        minHeight: 105.dp,
        maxHeight: 370.dp,
        body: _buildMapAndNavi(),
      ),
    );
  }

  Widget _buildPannel(ScrollController sc) {
    return Container(
      color: const Color(0xff050505),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              // 由于未使用关闭状态，使用近似值来控制
              var position = _slidingController.panelPosition;
              if ((position - 0).abs() < 0.0001) {
                _slidingController.open();
              } else if ((position - 1).abs() < 0.0001) {
                _slidingController.close();
              }
            },
            child: Padding(
                padding: EdgeInsets.all(30.dp),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(22.5.dp),
                    child: Container(
                      height: 45.dp,
                      color: Colors.white,
                      child: Row(
                        children: [
                          Expanded(child: _buildInputField()),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.5.dp),
                            child: Image.asset(
                              AppIcons.imgMapDottedLine,
                              width: 1.dp,
                              height: 28.dp,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              LogUtil.d('点击了前往');
                              viewModel.jumpToGoogleMap();
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.dp, vertical: 10.dp),
                              child: Text(
                                LocaleKeys.towards.tr(),
                                maxLines: 1,
                                style: TextStyle(
                                    color: const Color(0xff050505),
                                    fontSize: 14.sp),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.dp,
                          )
                        ],
                      ),
                    ))),
          ),
          SizedBox(
            height: 2.dp,
          ),
          Padding(
            padding: EdgeInsets.only(left: 30.dp),
            child: Row(
              children: [
                Text(
                  LocaleKeys.nearby.tr(),
                  maxLines: 1,
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
                SizedBox(
                  width: 12.dp,
                ),
                Image.asset(
                  AppIcons.imgMapNavigationIcon,
                  width: 11.dp,
                  height: 15.dp,
                )
              ],
            ),
          ),
          _buildSearchResultList(sc)
        ],
      ),
    );
  }

  Widget _buildInputField() {
    return SizedBox(
      height: 45.dp,
      child: TextFormField(
          onChanged: (value) {
            viewModel.valueChanged(
              value,
              callBack: () {
                if (listStateSetter != null) {
                  listStateSetter!(() {});
                }
                if (viewModel.carIsCenter == false) {
                  viewModel.centerLocation = viewModel.carLoation;
                  updateState(() {});
                  _mapController.animateCamera(CameraUpdate.newCameraPosition(
                      CameraPosition(
                          target: LatLng(
                              viewModel.centerLocation?.latitude ?? 0,
                              viewModel.centerLocation?.longitude ?? 0),
                          zoom: 15)));
                }
              },
            );
            // pageRefresh(() {});
          },
          autofocus: false,
          textAlign: TextAlign.left,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          inputFormatters: [
            FilteringTextInputFormatter.singleLineFormatter,
            LengthLimitingTextInputFormatter(50)
            // FilteringTextInputFormatter.allow(RegExp(r'^[A-Za-z0-9]+@.$')),
          ],
          // initialValue: viewModel.searchKey,
          maxLines: 1,
          style: TextStyle(
              fontSize: 12.sp,
              color: const Color(0xff050505),
              height: SizeUtil.dp(1.5)),
          strutStyle: const StrutStyle(forceStrutHeight: true, leading: 0),
          decoration: InputDecoration(
            hintText: LocaleKeys.input_address.tr(),
            hintStyle:
                TextStyle(fontSize: 12.sp, color: const Color(0xffC9C9C9)),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 15.5.dp, vertical: 15.dp),
            isDense: true,
            prefixIconConstraints: BoxConstraints(
                minHeight: 20.dp,
                maxHeight: 45.dp,
                minWidth: 44.dp,
                maxWidth: 44.dp),
            prefixIcon: Image.asset(
              AppIcons.imgMapSearchIcon,
              width: 20.dp,
              height: 20.dp,
            ),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 1.dp, color: Colors.white)),
            focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(width: 1.dp, color: const Color(0xff36BCB3)),
            ),
          )),
    );
  }

  Widget _buildSearchResultList(ScrollController sc) {
    return StatefulBuilder(builder: (context, setState1) {
      listStateSetter = setState1;
      return Expanded(
          child: ListView.separated(
        controller: sc,
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 29.dp,
          );
        },
        itemBuilder: (context, index) {
          GoogleGeocodingResult model = viewModel.searchResult[index];
          return InkWell(
              onTap: () {
                viewModel.centerLocation = GeoLocationDefine(
                    latitude: model.geometry?.location.lat,
                    longitude: model.geometry?.location.lng,
                    locationString: model.formattedAddress);
                updateState(() {});
                _mapController.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: LatLng(viewModel.centerLocation?.latitude ?? 0,
                            viewModel.centerLocation?.longitude ?? 0),
                        zoom: 15)));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.dp),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 2.dp),
                      child: Image.asset(
                        AppIcons.imgMapLocationIcon,
                        width: 19.4.dp,
                        height: 25.7.dp,
                      ),
                    ),
                    SizedBox(
                      width: 17.dp,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.formattedAddress,
                          style:
                              TextStyle(color: Colors.white, fontSize: 14.sp),
                        ),
                        SizedBox(
                          height: 5.dp,
                        ),
                        Text(
                          viewModel.distance(model),
                          style:
                              TextStyle(color: Colors.white, fontSize: 12.sp),
                        ),
                      ],
                    ))
                  ],
                ),
              ));
        },
        itemCount: viewModel.searchResult.length,
      ));
    });
  }

  Set<Marker> _computeMarkers() {
    var markers = {
      Marker(
          markerId: const MarkerId('car'),
          position: LatLng(viewModel.carLoation?.latitude ?? 0,
              viewModel.carLoation?.longitude ?? 0))
    };
    if (viewModel.carIsCenter == false) {
      markers.add(Marker(
          markerId: const MarkerId('destination'),
          position: LatLng(viewModel.centerLocation?.latitude ?? 0,
              viewModel.centerLocation?.longitude ?? 0)));
    }
    return markers;
  }

  Widget _buildMapAndNavi() {
    return Stack(
      fit: StackFit.expand,
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
              target: LatLng(viewModel.centerLocation?.latitude ?? 0,
                  viewModel.centerLocation?.longitude ?? 0),
              zoom: 15),
          mapToolbarEnabled: false,
          myLocationButtonEnabled: false,
          onMapCreated: _onMapCreated,
          onTap: (argument) {
            LogUtil.d('点击了');
          },
          markers: _computeMarkers(),
        ),
        Positioned(
            top: statusBarHeight,
            left: 10.dp,
            child: SizedBox(
              width: 44.dp,
              height: titleBarHeight - 5,
              child: IconButton(
                  onPressed: () => pagePop(),
                  // iconSize: titleBarHeight,
                  alignment: Alignment.center,
                  icon: Image.asset(
                    AppIcons.imgCommonBackIcon,
                    width: 7.33.dp,
                    height: 12.67.dp,
                    color: Colors.white,
                  )),
            )),
        Positioned(
            top: statusBarHeight,
            child: SizedBox(
              width: SizeUtil.screenWidth,
              height: titleBarHeight,
              child: Center(
                child: Text(
                  LocaleKeys.place.tr(),
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: LWFontWeight.bold,
                      color: Colors.white),
                ),
              ),
            )),
        Positioned(
            right: 29.dp,
            bottom: 386.dp,
            child: InkWell(
              onTap: () {
                _mapController.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: LatLng(viewModel.carLoation?.latitude ?? 0,
                            viewModel.carLoation?.longitude ?? 0),
                        zoom: 15)));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.dp),
                child: Container(
                  width: 32.dp,
                  height: 32.dp,
                  color: Colors.white,
                  child: Center(
                    child: Image.asset(
                      AppIcons.imgMapCurrentLocationIcon,
                      width: 18.5.dp,
                      height: 18.5.dp,
                    ),
                  ),
                ),
              ),
            ))
      ],
    );
  }

  @override
  Widget buildBody(Object context) {
    // TODO: implement buildBody
    return Container();
  }
}
