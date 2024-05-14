import 'package:atv/archs/base/base_view_model.dart';

class ServiceInfoPageViewModel extends BaseViewModel {
  String servicePhone = '';
  @override
  void initialize(args) {
    // TODO: implement initialize
    if (args != null && args is Map<String, dynamic>) {
      servicePhone = args['servicePhone'];
    }
  }

  @override
  void release() {
    // TODO: implement release
  }
}
