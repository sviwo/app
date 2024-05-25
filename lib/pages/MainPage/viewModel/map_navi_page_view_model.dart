import 'dart:async';

import 'package:atv/archs/base/base_view_model.dart';
import 'package:atv/archs/utils/log_util.dart';
import 'package:atv/config/data/entity/mainPage/geo_location_define.dart';
import 'package:atv/generated/locale_keys.g.dart';
import 'package:atv/tools/map/lw_map_tool.dart';
import 'package:atv/widgetLibrary/complex/loading/lw_loading.dart';
import 'package:atv/widgetLibrary/complex/toast/lw_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';

class MapNaviPageViewModel extends BaseViewModel {
  GeoLocationDefine? carLoation;

  GeoLocationDefine? centerLocation;

  Timer? _timer;

  var searchKey = '';

  List<GoogleGeocodingResult> searchResult = [];

  @override
  void initialize(args) {
    // TODO: implement initialize
    if (args is Map<String, dynamic>) {
      carLoation = GeoLocationDefine.fromJson(args);
      centerLocation = carLoation;
      searchKey = carLoation?.locationString ?? "";
    }
  }

  bool get carIsCenter {
    if (centerLocation == null) {
      return true;
    }
    if (carLoation == centerLocation) {
      return true;
    }
    if (carLoation?.latitude == centerLocation?.latitude &&
        carLoation?.longitude == centerLocation?.longitude) {
      return true;
    }
    return false;
  }

  void valueChanged(String value, {VoidCallback? callBack}) {
    searchKey = value;
    _timer?.cancel();
    if (searchKey.isEmpty) {
      searchResult.clear();
      if (callBack != null) {
        callBack();
      }
      return;
    }
    _timer = Timer(const Duration(seconds: 1, milliseconds: 500), () {
      request(searchKey, callBack: callBack);
    });
  }

  void request(String address, {VoidCallback? callBack}) async {
    if (address.isEmpty) {
      return;
    }
    // LWLoading.showLoading2();
    try {
      searchResult = await LWMapTool.geocoding(address);
      LogUtil.d('---------${searchResult.length}');
      if (callBack != null) {
        callBack();
      }
    } catch (e) {
      LWToast.show(e.toString());
      LogUtil.d('+++++++++++++出错了：${e.toString()}');
    } finally {
      // LWLoading.dismiss();
    }
  }

  String distance(GoogleGeocodingResult model) {
    var meters = LWMapTool.distanceBetween(
        startLatitude: carLoation?.latitude ?? 0,
        startLongitude: carLoation?.longitude ?? 0,
        endLatitude: model.geometry?.location.lat ?? 0,
        endLongitude: model.geometry?.location.lng ?? 0);
    if (meters > 1000) {
      return '${LocaleKeys.geographical_distance.tr()}${meters ~/ 1000}km${(meters % 1000).toInt()}m';
    } else {
      return '${LocaleKeys.geographical_distance.tr()}${meters.toInt()}m';
    }
  }

  void jumpToGoogleMap() {
    if (carIsCenter == false) {
      LWMapTool.jumpToGoogleMap(
          destinationLatitude: centerLocation?.latitude ?? 0,
          destinationLongtitude: centerLocation?.longitude ?? 0,
          destinationTitle: centerLocation?.locationString,
          orginLatitude: carLoation?.latitude ?? 0,
          originLongtitude: carLoation?.longitude ?? 0,
          originTitle: carLoation?.locationString);
    } else {
      LWToast.show(LocaleKeys.no_map_destination_tips.tr());
    }
  }

  @override
  void release() {
    // TODO: implement release
    _timer?.cancel();
  }
}
