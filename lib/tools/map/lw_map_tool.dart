import 'dart:io';

import 'package:atv/config/conf/app_conf.dart';
import 'package:atv/config/data/entity/mainPage/geo_location_define.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';

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

  static geocoding(String address) async {
    final api = await _getGoogleGeocordingApi();
    final language = await AppConf.getLauguage();
    final searchResults = await api.search(address, language: language);
    return searchResults.results.toString();
  }

  static Future<GoogleGeocodingApi> _getGoogleGeocordingApi() async {
    var apiKey = AppConf.iosMapApiKey;
    if (Platform.isAndroid) {
      apiKey = AppConf.androidMapApiKey;
    }
    var environment = await AppConf.environment();
    bool isDebug = false;
    // if (environment != 'prod') {
    //   isDebug = true;
    // }
    return GoogleGeocodingApi(apiKey, isLogged: isDebug);
  }
}
