import 'package:atv/archs/base/base_view_model.dart';
import 'package:atv/archs/base/event_manager.dart';
import 'package:atv/config/conf/app_event.dart';
import 'package:atv/config/data/entity/User/user_basic_info.dart';
import 'package:atv/config/net/api_home_page.dart';
import 'package:atv/generated/locale_keys.g.dart';
import 'package:atv/pages/Mine/define/user_info_enum.dart';
import 'package:atv/widgetLibrary/complex/toast/lw_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';

class UserInfoPageViewModel extends BaseViewModel {
  UserBasicInfo? userInfo;

  UserInfoEditType editType = UserInfoEditType.avatar;

  getData() {
    loadApiData<UserBasicInfo>(
      ApiHomePage.getUserBasicInfo(),
      handlePageState: false,
      showLoading: true,
      dataSuccess: (data) {
        userInfo = data;
        pageRefresh();
      },
    );
  }

  updataData({bool isHeader = false, XFile? headerFile}) {
    if (checkInput() == false) {
      return;
    }
    loadApiData(
      ApiHomePage.submmitUserBasicInfo(userInfo,
          isHeader: isHeader, file: headerFile),
      handlePageState: false,
      showLoading: true,
      voidSuccess: () {
        if (isHeader == false) {
          pagePop();
        }
        EventManager.post(AppEvent.userBaseInfoChange);
      },
    );
  }

  bool resetUserData() {
    bool isValid = true;
    switch (editType) {
      case UserInfoEditType.lastName:
        var value = userInfo?.lastName;
        userInfo = UserBasicInfo();
        userInfo?.lastName = value;
        break;
      case UserInfoEditType.firstName:
        var value = userInfo?.firstName;
        userInfo = UserBasicInfo();
        userInfo?.firstName = value;
        break;
      case UserInfoEditType.address:
        var value = userInfo?.userAddress;
        userInfo = UserBasicInfo();
        userInfo?.userAddress = value;
        break;
      case UserInfoEditType.mobilePhone:
        var value = userInfo?.mobilePhone;
        userInfo = UserBasicInfo();
        userInfo?.mobilePhone = value;
        break;
      default:
        break;
    }
    return isValid;
  }

  bool checkInput() {
    bool isValid = true;
    switch (editType) {
      case UserInfoEditType.lastName:
        isValid = userInfo?.lastName?.isNotEmpty ?? false;
        if (isValid == false) {
          LWToast.show(LocaleKeys.input_name.tr());
        }
        break;
      case UserInfoEditType.firstName:
        isValid = userInfo?.firstName?.isNotEmpty ?? false;
        if (isValid == false) {
          LWToast.show(LocaleKeys.input_faimily_name.tr());
        }
        break;
      case UserInfoEditType.address:
        isValid = userInfo?.userAddress?.isNotEmpty ?? false;
        if (isValid == false) {
          LWToast.show(LocaleKeys.input_address.tr());
        }
        break;
      case UserInfoEditType.mobilePhone:
        isValid = userInfo?.mobilePhone?.isNotEmpty ?? false;
        if (isValid == false) {
          LWToast.show(LocaleKeys.input_mobilephone.tr());
        }
        break;
      default:
        break;
    }
    return isValid;
  }

  valueChanged(String value) {
    switch (editType) {
      case UserInfoEditType.lastName:
        userInfo?.lastName = value;
        break;
      case UserInfoEditType.firstName:
        userInfo?.firstName = value;
        break;
      case UserInfoEditType.address:
        userInfo?.userAddress = value;
        break;
      case UserInfoEditType.mobilePhone:
        userInfo?.mobilePhone = value;
        break;
      default:
        break;
    }
  }

  String? get defaultEditValue {
    switch (editType) {
      case UserInfoEditType.lastName:
        return userInfo?.lastName;
      case UserInfoEditType.firstName:
        return userInfo?.firstName;
      case UserInfoEditType.address:
        return userInfo?.userAddress;
      case UserInfoEditType.mobilePhone:
        return userInfo?.mobilePhone;
      default:
        return null;
    }
  }

  @override
  void initialize(args) {
    // TODO: implement initialize
    if (args == null) {
      getData();
    } else {
      if (args is Map<String, dynamic>) {
        editType = UserInfoEditType.getTypeByName(args['type'] ?? '');
        userInfo = UserBasicInfo.fromJson(args['user']);
        resetUserData();
      }
    }
  }

  @override
  void release() {
    // TODO: implement release
  }
}
