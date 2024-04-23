import 'package:atv/archs/base/base_mvvm_page.dart';
import 'package:atv/archs/utils/log_util.dart';
import 'package:atv/config/conf/app_icons.dart';
import 'package:atv/config/conf/route/app_route_settings.dart';
import 'package:atv/generated/locale_keys.g.dart';
import 'package:atv/pages/Mine/viewModel/account_info_page_view_model.dart';
import 'package:atv/widgetLibrary/utils/size_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AccountInfoPage extends BaseMvvmPage {
  @override
  State<StatefulWidget> createState() => _AccountInfoPageState();
}

class _AccountInfoPageState
    extends BaseMvvmPageState<AccountInfoPage, AccountInfoPageViewModel> {
  @override
  AccountInfoPageViewModel viewModelProvider() => AccountInfoPageViewModel();
  @override
  String? titleName() => LocaleKeys.account.tr();
  @override
  Widget? headerBackgroundWidget() {
    return Image.asset(
      AppIcons.imgMainPageBg,
      fit: BoxFit.cover,
    );
  }

  @override
  bool isSupportScrollView() => false;
  @override
  Widget buildBody(BuildContext context) {
    // TODO: implement buildBody
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 40.dp,
        ),
        _buildContactRow(),
        SizedBox(
          height: 20.dp,
        ),
        _buildLockRow()
      ],
    );
  }

  Widget _buildContactRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.dp, vertical: 10.dp),
      child: InkWell(
          onTap: () {
            LogUtil.d('点击了联系信息');
            pagePush(AppRoute.userInfo);
          },
          child: Row(
            children: [
              Image.asset(
                AppIcons.imgAccountContactIcon,
                width: 18.7.dp,
                height: 21.3.dp,
              ),
              SizedBox(
                width: 30.dp,
              ),
              Expanded(
                child: Text(
                  LocaleKeys.contact_info.tr(),
                  style: TextStyle(fontSize: 14.dp, color: Colors.white),
                ),
              ),
              Image.asset(
                AppIcons.imgServiceIndicatorIcon,
                width: 7.4.dp,
                height: 12.4.dp,
              ),
            ],
          )),
    );
  }

  Widget _buildLockRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.dp, vertical: 10.dp),
      child: InkWell(
          onTap: () {
            pagePush(AppRoute.resetPassword);
            LogUtil.d('点击了重置密码');
          },
          child: Row(
            children: [
              Image.asset(
                AppIcons.imgAccountLockIcon,
                height: 23.7.dp,
                width: 17.7.dp,
              ),
              SizedBox(
                width: 31.dp,
              ),
              Expanded(
                child: Text(
                  LocaleKeys.reset_password.tr(),
                  style: TextStyle(fontSize: 14.dp, color: Colors.white),
                ),
              ),
              Image.asset(
                AppIcons.imgServiceIndicatorIcon,
                width: 7.4.dp,
                height: 12.4.dp,
              ),
            ],
          )),
    );
  }
}
