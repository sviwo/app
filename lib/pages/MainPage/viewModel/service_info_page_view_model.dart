import 'package:atv/archs/base/base_view_model.dart';
import 'package:atv/archs/utils/log_util.dart';
import 'package:atv/config/conf/route/app_route_settings.dart';
import 'package:atv/config/data/entity/common/media_content.dart';
import 'package:atv/config/data/entity/common/media_tree.dart';
import 'package:atv/config/net/api_public.dart';

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

  List<MediaTree> treeData = [];

  requestData({bool showLoading = true}) async {
    return await loadApiData<List<MediaTree>>(
      ApiPublic.getHttpPageTree(2),
      showLoading: showLoading,
      handlePageState: false,
      dataSuccess: (data) {
        treeData.clear();
        treeData.addAll(data);
        pageRefresh();
      },
    );
  }

  /// 获取跳转链接或者内容
  void requestMediaData(
      {required MediaTree model, Function(MediaTree?)? callback}) async {
    if (model.children?.isNotEmpty == true) {
      pagePush(AppRoute.childrenWebPage, params: model.toJson());
      return;
    }
    if (model.displayType == 1) {
      // 跳转外链
      if (callback != null) {
        callback(model);
      }
    } else if (model.displayType == 0) {
      // 加载html字符串
      // 获取html内容
      if (model.content?.isNotEmpty == true) {
        //已经获取过存进来了，就不用再请求接口了
        if (callback != null) {
          callback(model);
        }
      } else {
        await loadApiData<MediaContent>(
          ApiPublic.getHttpPageContent(model.id ?? ''),
          showLoading: true,
          handlePageState: false,
          dataSuccess: (data1) {
            model.content = data1.content;
            if (callback != null) {
              callback(model);
            }
          },
        );
      }
    }
  }

  @override
  void initialize(args) {
    // TODO: implement initialize
    if (args != null && args is Map<String, dynamic>) {
      servicePhone = args['servicePhone'];
    }
    requestData();
  }

  @override
  void release() {
    // TODO: implement release
  }
}
