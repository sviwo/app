import 'package:atv/archs/base/base_view_model.dart';
import 'package:atv/config/conf/app_conf.dart';
import 'package:atv/config/conf/route/app_route_settings.dart';
import 'package:atv/config/data/entity/Login/login_response.dart';
import 'package:atv/config/data/entity/common/media_content.dart';
import 'package:atv/config/data/entity/common/media_tree.dart';
import 'package:atv/config/net/api_login.dart';
import 'package:atv/config/net/api_public.dart';
import 'package:atv/generated/locale_keys.g.dart';
import 'package:atv/widgetLibrary/complex/toast/lw_toast.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginViewModel extends BaseViewModel {
  /// 是否选中了同意协议
  var isSelectedProtocol = false;

  /// 登录的邮箱名
  String emailName = '';

  /// 登录的密码
  String password = '';

  bool judgeEmailAndPassword() {
    return emailName.isNotEmpty && password.isNotEmpty;
  }

  void userNameLogin() async {
    if (judgeEmailAndPassword()) {
      if (isSelectedProtocol == false) {
        LWToast.show(LocaleKeys.agree_regist_or_login_tips.tr());
        return;
      }
      await loadApiData<LoginResponse>(
        ApiLogin.login(username: emailName, password: password),
        showLoading: true,
        handlePageState: false,
        dataSuccess: (data) {
          AppConf.afterLoginSuccess(
              Authorization: data.Authorization, Publickey: data.Publickey);
          // pagePush(AppRoute.main, needReplace: true, fullscreenDialog: true);
          pagePushAndRemoveUtil(
            AppRoute.main,
          );
        },
      );
    }
  }

  List<MediaTree> treeData = [];

  requestData({bool showLoading = true}) async {
    return await loadApiData<List<MediaTree>>(
      ApiPublic.getHttpPageTree(1),
      showLoading: showLoading,
      handlePageState: false,
      dataSuccess: (data) {
        treeData.clear();
        treeData.addAll(data);
      },
    );
  }

  /// 0表示用户协议 1表示隐私政策  苟架构表示已经严格排序
  void requestMediaData(
      {int type = 0, Function(int, String?)? callback}) async {
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
        callback(1, data.content);
      }
    } else if (data.displayType == 0) {
      // 加载html字符串
      // 获取html内容
      await loadApiData<MediaContent>(
        ApiPublic.getHttpPageContent(data.id ?? ''),
        showLoading: true,
        handlePageState: false,
        dataSuccess: (data1) {
          if (callback != null) {
            callback(0, data1.content);
          }
        },
      );
    }
  }

  @override
  void initialize(args) {
    // TODO: implement initialize
    requestData(showLoading: false);
  }

  @override
  void release() {
    // TODO: implement release
  }
}
