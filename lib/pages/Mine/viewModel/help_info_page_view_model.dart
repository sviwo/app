import 'package:atv/archs/base/base_view_model.dart';
import 'package:atv/config/data/entity/common/media_content.dart';
import 'package:atv/config/data/entity/common/media_tree.dart';
import 'package:atv/config/net/api_public.dart';

class HelpInfoPageViewModel extends BaseViewModel {
  List<MediaTree> treeData = [];

  requestData({bool showLoading = true}) async {
    return await loadApiData<List<MediaTree>>(
      ApiPublic.getHttpPageTree(0),
      showLoading: showLoading,
      handlePageState: false,
      dataSuccess: (data) {
        treeData.clear();
        treeData.addAll(data);
        pageRefresh();
      },
    );
  }

  /// 0表示用户协议 1表示隐私政策  苟架构表示已经严格排序
  void requestMediaData({int type = 0, Function(MediaTree?)? callback}) async {
    if (treeData.isEmpty) {
      await requestData();
    }
    if (treeData.length <= type) {
      return;
    }
    MediaTree data = treeData[type];
    if (data.displayType == 1) {
      // 跳转外链
      if (callback != null) {
        callback(data);
      }
    } else if (data.displayType == 0) {
      // 加载html字符串
      // 获取html内容
      if (data.content?.isNotEmpty == true) {
        //已经获取过存进来了，就不用再请求接口了
        if (callback != null) {
          callback(data);
        }
      } else {
        await loadApiData<MediaContent>(
          ApiPublic.getHttpPageContent(data.id ?? ''),
          showLoading: true,
          handlePageState: false,
          dataSuccess: (data1) {
            data.content = data1.content;
            if (callback != null) {
              callback(data);
            }
          },
        );
      }
    }
  }

  @override
  void initialize(args) {
    // TODO: implement initialize
    requestData();
  }

  @override
  void release() {
    // TODO: implement release
  }
}
