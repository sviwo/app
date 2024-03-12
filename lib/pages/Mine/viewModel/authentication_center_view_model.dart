import 'package:atv/archs/base/base_view_model.dart';
import 'package:basic_utils/basic_utils.dart';

class AuthenticationCenterViewModel extends BaseViewModel {
  /// 名
  var name = '';

  /// 姓
  var familyName = '';

  bool get isLegal => name.isNotEmpty && familyName.isNotEmpty;

  @override
  void initialize(args) {
    // TODO: implement initialize
  }

  @override
  void release() {
    // TODO: implement release
  }
}
