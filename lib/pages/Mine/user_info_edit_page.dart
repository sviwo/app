import 'package:atv/archs/base/base_mvvm_page.dart';
import 'package:atv/archs/utils/log_util.dart';
import 'package:atv/config/conf/app_icons.dart';
import 'package:atv/generated/locale_keys.g.dart';
import 'package:atv/pages/Mine/define/user_info_enum.dart';
import 'package:atv/pages/Mine/viewModel/user_info_page_view_model.dart';
import 'package:atv/widgetLibrary/basic/button/lw_button.dart';
import 'package:atv/widgetLibrary/basic/font/lw_font_weight.dart';
import 'package:atv/widgetLibrary/complex/file/lw_image_loader.dart';
import 'package:atv/widgetLibrary/utils/size_util.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserInfoEditPage extends BaseMvvmPage {
  @override
  State<StatefulWidget> createState() => _UserInfoEditPageState();
}

class _UserInfoEditPageState
    extends BaseMvvmPageState<UserInfoEditPage, UserInfoPageViewModel> {
  @override
  UserInfoPageViewModel viewModelProvider() => UserInfoPageViewModel();
  @override
  String? titleName() => viewModel.editType.displayName;
  @override
  Widget? headerBackgroundWidget() {
    return Image.asset(
      AppIcons.imgCommonBgDownStar,
      fit: BoxFit.cover,
    );
  }

  @override
  List<MapEntry<String, Function>>? buildTitleActions() {
    return [
      MapEntry(LocaleKeys.complete_action.tr(), () {
        viewModel.updataData();
      }),
    ];
  }

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50.dp,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.dp),
          child: _buildInputField(),
        )
      ],
    );
  }

  Widget _buildInputField() {
    return SizedBox(
      height: 42.dp,
      child: TextFormField(
          onChanged: (value) {
            viewModel.valueChanged(value);
            pageRefresh(() {});
          },
          onFieldSubmitted: (value) {
            LogUtil.d('-----');
          },
          autofocus: false,
          textAlign: TextAlign.left,
          textInputAction: TextInputAction.done,
          keyboardType: viewModel.editType == UserInfoEditType.mobilePhone
              ? TextInputType.number
              : TextInputType.text,
          inputFormatters: [
            FilteringTextInputFormatter.singleLineFormatter,
            // FilteringTextInputFormatter.allow(RegExp(r'^[A-Za-z0-9]+@.$')),
          ],
          initialValue: viewModel.defaultEditValue,
          maxLines: 1,
          style: TextStyle(
              fontSize: 12.sp, color: Colors.white, height: SizeUtil.dp(1.5)),
          strutStyle: const StrutStyle(forceStrutHeight: true, leading: 0),
          decoration: InputDecoration(
            hintText: LocaleKeys.please_enter.tr(),
            hintStyle:
                TextStyle(fontSize: 12.sp, color: const Color(0xff8E8E8E)),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 15.5.dp, vertical: 15.dp),
            isDense: true,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: 1.dp, color: Colors.white)),
            focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(width: 1.dp, color: const Color(0xff36BCB3)),
            ),
          )),
    );
  }
}
