import 'package:atv/archs/base/base_view_model.dart';
import 'package:atv/config/data/entity/mainPage/geo_location_define.dart';

class MapNaviPageViewModel extends BaseViewModel {
  GeoLocationDefine? initialLoation;

  @override
  void initialize(args) {
    // TODO: implement initialize
    if (args is Map<String, dynamic>) {
      initialLoation = GeoLocationDefine.fromJson(args['location']);
    }
  }

  @override
  void release() {
    // TODO: implement release
  }
}
