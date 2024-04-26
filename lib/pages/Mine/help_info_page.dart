import 'package:atv/archs/base/base_mvvm_page.dart';
import 'package:atv/archs/utils/log_util.dart';
import 'package:atv/config/conf/app_icons.dart';
import 'package:atv/generated/locale_keys.g.dart';
import 'package:atv/pages/Mine/viewModel/help_info_page_view_model.dart';
import 'package:atv/widgetLibrary/utils/size_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HelpInfoPage extends BaseMvvmPage {
  @override
  State<StatefulWidget> createState() => _HelpInfoPageState();
}

class _HelpInfoPageState
    extends BaseMvvmPageState<HelpInfoPage, HelpInfoPageViewModel> {
  @override
  HelpInfoPageViewModel viewModelProvider() => HelpInfoPageViewModel();
  @override
  String? titleName() => LocaleKeys.help.tr();
  @override
  Widget? headerBackgroundWidget() {
    return Image.asset(
      AppIcons.imgCommonBgDownStar,
      fit: BoxFit.cover,
    );
  }

  @override
  bool isSupportScrollView() => true;
  @override
  Widget buildBody(BuildContext context) {
    // TODO: implement buildBody
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50.dp,
        ),
        _buildAlertRow(),
        SizedBox(
          height: 30.dp,
        ),
        _buildDialogRow(),
        SizedBox(
          height: 30.dp,
        ),
        _buildMaintainRow(),
      ],
    );
  }

  Widget _buildAlertRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.dp, vertical: 10.dp),
      child: InkWell(
          onTap: () {
            LogUtil.d('车辆无法启动');
          },
          child: Row(
            children: [
              Image.asset(
                AppIcons.imgHelpAlertIcon,
                width: 17.3.dp,
                height: 15.3.dp,
              ),
              SizedBox(
                width: 15.dp,
              ),
              Expanded(
                child: Text(
                  LocaleKeys.vehicle_cannot_start.tr(),
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

  Widget _buildDialogRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.dp, vertical: 10.dp),
      child: InkWell(
          onTap: () {
            LogUtil.d('点击了联系我们');
          },
          child: Row(
            children: [
              Image.asset(
                AppIcons.imgHelpDialogIcon,
                height: 14.3.dp,
                width: 16.3.dp,
              ),
              SizedBox(
                width: 16.dp,
              ),
              Expanded(
                child: Text(
                  LocaleKeys.how_to_contact_us.tr(),
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

  Widget _buildMaintainRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.dp, vertical: 10.dp),
      child: InkWell(
          onTap: () {
            LogUtil.d('车辆如何保养');
          },
          child: Row(
            children: [
              Image.asset(
                AppIcons.imgHelpMaintainIcon,
                width: 14.3.dp,
                height: 14.3.dp,
              ),
              SizedBox(
                width: 18.dp,
              ),
              Expanded(
                child: Text(
                  LocaleKeys.how_is_the_vehicle_maintained.tr(),
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
