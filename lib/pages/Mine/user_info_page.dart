import 'package:atv/archs/base/base_mvvm_page.dart';
import 'package:atv/archs/base/event_manager.dart';
import 'package:atv/archs/utils/log_util.dart';
import 'package:atv/config/conf/app_event.dart';
import 'package:atv/config/conf/app_icons.dart';
import 'package:atv/config/conf/route/app_route_settings.dart';
import 'package:atv/generated/locale_keys.g.dart';
import 'package:atv/pages/Mine/define/user_info_enum.dart';
import 'package:atv/pages/Mine/viewModel/user_info_page_view_model.dart';
import 'package:atv/tools/imagePicker/image_picker_tool.dart';
import 'package:atv/widgetLibrary/basic/button/lw_button.dart';
import 'package:atv/widgetLibrary/basic/font/lw_font_weight.dart';
import 'package:atv/widgetLibrary/complex/file/lw_image_loader.dart';
import 'package:atv/widgetLibrary/utils/size_util.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class UserInfoPage extends BaseMvvmPage {
  @override
  State<StatefulWidget> createState() => _UserInfoPageState();
}

class _UserInfoPageState
    extends BaseMvvmPageState<UserInfoPage, UserInfoPageViewModel> {
  @override
  UserInfoPageViewModel viewModelProvider() => UserInfoPageViewModel();
  @override
  String? titleName() => LocaleKeys.contact_info.tr();
  @override
  Widget? headerBackgroundWidget() {
    return Image.asset(
      AppIcons.imgLoginBg,
      fit: BoxFit.cover,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    EventManager.register(context, AppEvent.userBaseInfoChange, (params) {
      viewModel.getData();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    EventManager.unregister(context, AppEvent.userBaseInfoChange);
    super.dispose();
  }

  @override
  bool isSupportScrollView() => true;
  @override
  Widget buildBody(BuildContext context) {
    // TODO: implement buildBody
    var placeHolder = '-';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50.dp,
        ),
        _buildHeaderImage(),
        SizedBox(
          height: 35.dp,
        ),
        _buildFullName(),
        SizedBox(
          height: 40.dp,
        ),
        _buildItem(
            LocaleKeys.name.tr(),
            StringUtils.isNotNullOrEmpty(viewModel.userInfo?.lastName)
                ? viewModel.userInfo?.lastName
                : placeHolder,
            LocaleKeys.edit.tr(), () {
          pagePush(AppRoute.editUserInfo, params: {
            'type': UserInfoEditType.lastName.typeName,
            'user': viewModel.userInfo?.toJson()
          });
        }),
        _buildItem(
            LocaleKeys.family_name.tr(),
            StringUtils.isNotNullOrEmpty(viewModel.userInfo?.firstName)
                ? viewModel.userInfo?.firstName
                : placeHolder,
            LocaleKeys.edit.tr(), () {
          pagePush(AppRoute.editUserInfo, params: {
            'type': UserInfoEditType.firstName.typeName,
            'user': viewModel.userInfo?.toJson()
          });
        }),
        _buildItem(
            LocaleKeys.address.tr(),
            StringUtils.isNotNullOrEmpty(viewModel.userInfo?.userAddress)
                ? viewModel.userInfo?.userAddress
                : placeHolder,
            LocaleKeys.edit.tr(), () {
          pagePush(AppRoute.editUserInfo, params: {
            'type': UserInfoEditType.address.typeName,
            'user': viewModel.userInfo?.toJson()
          });
        }),
        _buildItem(
            LocaleKeys.contact_phone.tr(),
            StringUtils.isNotNullOrEmpty(viewModel.userInfo?.mobilePhone)
                ? viewModel.userInfo?.mobilePhone
                : placeHolder,
            LocaleKeys.edit.tr(), () {
          pagePush(AppRoute.editUserInfo, params: {
            'type': UserInfoEditType.mobilePhone.typeName,
            'user': viewModel.userInfo?.toJson()
          });
        }),
        SizedBox(
          height: bottomBarHeight,
        )
      ],
    );
  }

  Widget _buildHeaderImage() {
    return Center(
      child: InkWell(
          onTap: () {
            LogUtil.d('点击了头像');
            ImagePickerTool.showChooseImagePicker(
              context,
              completion: (type, files) {
                viewModel.updataData(isHeader: true, headerFile: files.first);
              },
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40.dp),
            child: LWImageLoader.network(
                imageUrl: viewModel.userInfo?.headImg ?? '',
                width: 80.dp,
                height: 80.dp),
          )),
    );
  }

  Widget _buildFullName() {
    var placeHolder = '-';
    var fullName = '';
    if (StringUtils.isNotNullOrEmpty(viewModel.userInfo?.lastName)) {
      fullName += viewModel.userInfo?.lastName ?? '';
    }
    if (StringUtils.isNotNullOrEmpty(viewModel.userInfo?.firstName)) {
      fullName += viewModel.userInfo?.firstName ?? '';
    }
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 40.dp),
      child: Text(
        fullName.isNotEmpty ? fullName : placeHolder,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: LWFontWeight.normal),
      ),
    );
  }

  Widget _buildItem(
      String title, String? content, String editTitle, VoidCallback? callback) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 52.dp, vertical: 18.dp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: LWFontWeight.normal),
              ),
              SizedBox(
                height: 14.dp,
              ),
              Text(
                content ?? '-',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: LWFontWeight.normal),
              )
            ],
          )),
          LWButton.text(
            text: editTitle,
            textColor: Colors.white,
            textSize: 12.sp,
            padding: EdgeInsets.symmetric(horizontal: 24.dp),
            minHeight: 36.dp,
            onPressed: () {
              if (callback != null) {
                callback();
              }
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.dp),
            child: Image.asset(
              AppIcons.imgServiceIndicatorIcon,
              width: 7.4.dp,
              height: 12.4.dp,
            ),
          )
        ],
      ),
    );
  }
}
