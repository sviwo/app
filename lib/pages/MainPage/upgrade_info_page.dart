import 'package:atv/archs/base/base_mvvm_page.dart';
import 'package:atv/archs/utils/log_util.dart';
import 'package:atv/config/conf/app_icons.dart';
import 'package:atv/generated/locale_keys.g.dart';
import 'package:atv/pages/MainPage/viewModel/upgrade_info_page_view_model.dart';
import 'package:atv/widgetLibrary/utils/size_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class UpgradeInfoPage extends BaseMvvmPage {
  @override
  State<StatefulWidget> createState() => _UpgradeInfoPageState();
}

class _UpgradeInfoPageState
    extends BaseMvvmPageState<UpgradeInfoPage, UpgradeInfoPageViewModel> {
  @override
  UpgradeInfoPageViewModel viewModelProvider() => UpgradeInfoPageViewModel();
  @override
  String? titleName() => LocaleKeys.upgrade.tr();
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 29.dp, vertical: 40.dp),
      child: Column(
        children: [
          InkWell(
              onTap: () {
                LogUtil.d('点击了软件升级');
              },
              child: Stack(
                fit: StackFit.loose,
                children: [
                  Image.asset(AppIcons.imgUpgradeSoftwareIcon,
                      width: 316.3.dp, height: 174.dp),
                  Positioned(
                    left: 16.7.dp,
                    top: 21.3.dp,
                    child: Text(
                      LocaleKeys.software_upgrade.tr(),
                      style: TextStyle(fontSize: 14.dp, color: Colors.white),
                    ),
                  )
                ],
              )),
          SizedBox(
            height: 36.dp,
          ),
          InkWell(
              onTap: () {
                LogUtil.d('点击了延长保修');
              },
              child: Stack(
                fit: StackFit.loose,
                children: [
                  Image.asset(AppIcons.imgUpgradeSviwoAfterServiceIcon,
                      width: 316.3.dp, height: 174.dp),
                  Positioned(
                    left: 16.7.dp,
                    top: 20.dp,
                    child: Text(
                      LocaleKeys.sviwo_after_service.tr(),
                      style: TextStyle(fontSize: 14.dp, color: Colors.white),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
