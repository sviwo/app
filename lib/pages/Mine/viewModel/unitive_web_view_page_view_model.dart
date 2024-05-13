import 'package:atv/archs/base/base_view_model.dart';
import 'package:atv/config/data/entity/common/media_tree.dart';

class MultiLanguagePageViewModel extends BaseViewModel {
  MediaTree? treeData;
  @override
  void initialize(args) {
    if (args != null && args is Map<String, dynamic>) {
      treeData = MediaTree.fromJson(args);
      pageRefresh();
    }
  }

  @override
  void release() {
    // TODO: implement release
  }
}
