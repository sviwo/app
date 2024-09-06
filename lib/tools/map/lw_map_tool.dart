import 'dart:io';

import 'package:atv/archs/utils/log_util.dart';
import 'package:atv/config/conf/app_conf.dart';
import 'package:atv/config/data/entity/mainPage/geo_location_define.dart';
import 'package:atv/generated/locale_keys.g.dart';
import 'package:atv/widgetLibrary/complex/loading/lw_loading.dart';
import 'package:atv/widgetLibrary/complex/toast/lw_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_launcher/map_launcher.dart';

class LWMapTool {
  LWMapTool._();

  static Future<String> reverseGeocoding(GeoLocationDefine location) async {
    final api = await _getGoogleGeocordingApi();
    final language = await AppConf.getLauguage();
    final reversedSearchResults = await api.reverse(
        '${location.latitude},${location.longitude}',
        language: language);
    var result = '';
    if (reversedSearchResults.results.isNotEmpty) {
      result = (reversedSearchResults.results.toList()).first.formattedAddress;
    }
    return result;
  }

  static Future<List<GoogleGeocodingResult>> geocoding(String address) async {
    final api = await _getGoogleGeocordingApi();
    final language = await AppConf.getLauguage();
    final searchResults = await api.search(address, language: language);
    return searchResults.results.toList();
  }

  static Future<GoogleGeocodingApi> _getGoogleGeocordingApi() async {
    var apiKey = AppConf.iosMapApiKey;
    if (Platform.isAndroid) {
      apiKey = AppConf.androidMapApiKey;
    }
    // var environment = await AppConf.environment();
    bool isDebug = false;
    // if (environment != 'prod') {
    //   isDebug = true;
    // }
    return GoogleGeocodingApi(apiKey, isLogged: isDebug);
  }

  static double distanceBetween({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) {
    return Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
  }

  static void jumpToGoogleMap(
      {required double destinationLatitude,
      required double destinationLongtitude,
      String? destinationTitle,
      required double orginLatitude,
      required double originLongtitude,
      String? originTitle}) async {
    try {
      LogUtil.d('+++++jumpToGoogleMap');
      var isHaveGoogleMap = await MapLauncher.isMapAvailable(MapType.google);
      LogUtil.d('---jumpToGoogleMap:$isHaveGoogleMap');
      if (isHaveGoogleMap == true) {
        MapLauncher.showDirections(
            mapType: MapType.google,
            destination: Coords(destinationLatitude, destinationLongtitude),
            destinationTitle: destinationTitle,
            origin: Coords(orginLatitude, originLongtitude),
            originTitle: originTitle);
      } else {
        // 提示 本机没有安装
        LWToast.show(LocaleKeys.google_map_not_installed.tr());
      }
    } catch (e) {
      LWToast.show(e.toString());
    }
  }
}
