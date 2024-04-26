import 'package:atv/archs/base/base_view_model.dart';
import 'package:atv/archs/utils/log_util.dart';
import 'package:atv/config/data/entity/mainPage/geo_location_define.dart';

class MapNaviPageViewModel extends BaseViewModel {
  GeoLocationDefine? initialLoation;

  @override
  void initialize(args) {
    // TODO: implement initialize
    LogUtil.d('------$args');
    if (args is Map<String, dynamic>) {
      LogUtil.d('------$args');
      initialLoation = GeoLocationDefine.fromJson(args);
    }
  }

  @override
  void release() {
    // TODO: implement release
  }
}
