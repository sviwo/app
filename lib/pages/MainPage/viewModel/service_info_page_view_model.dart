import 'package:atv/archs/base/base_view_model.dart';
import 'package:atv/archs/utils/log_util.dart';

import 'package:url_launcher/url_launcher.dart';

class ServiceInfoPageViewModel extends BaseViewModel {
  String servicePhone = '';

  void callNumber() async {
    LogUtil.d('-----phone:$servicePhone');
    if (servicePhone.isEmpty) {
      return;
    }
    try {
      if (await canLaunchUrl(Uri(scheme: 'tel', path: servicePhone))) {
        await launchUrl(Uri(scheme: 'tel', path: servicePhone));
      } else {
        LogUtil.d('Cannot launch phone number');
      }
    } catch (e) {
      LogUtil.d(e);
    }
  }

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
