import 'package:atv/archs/base/base_mvvm_page.dart';
import 'package:atv/archs/utils/log_util.dart';
import 'package:atv/config/conf/app_icons.dart';
import 'package:atv/config/conf/route/app_route_settings.dart';
import 'package:atv/config/data/entity/common/media_tree.dart';
import 'package:atv/config/data/entity/mainPage/geo_location_define.dart';
import 'package:atv/generated/locale_keys.g.dart';
import 'package:atv/pages/MainPage/viewModel/service_info_page_view_model.dart';
import 'package:atv/pages/Mine/define/web_list_config_tool.dart';
import 'package:atv/tools/map/lw_map_tool.dart';
import 'package:atv/widgetLibrary/basic/button/lw_button.dart';
import 'package:atv/widgetLibrary/utils/size_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ServiceInfoPage extends BaseMvvmPage {
  @override
  State<StatefulWidget> createState() => _ServiceInfoPageState();
}

class _ServiceInfoPageState
    extends BaseMvvmPageState<ServiceInfoPage, ServiceInfoPageViewModel> {
  @override
  ServiceInfoPageViewModel viewModelProvider() => ServiceInfoPageViewModel();
  @override
  String? titleName() => LocaleKeys.service.tr();
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 40.dp,
        ),
        Center(
          child: Image.asset(
            AppIcons.imgServiceSviwoIcon,
            width: 335.dp,
            height: 172.7.dp,
          ),
        ),
        SizedBox(
          height: 32.dp,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.dp),
          child: LWButton.custom(
            text: LocaleKeys.service_reservation.tr(),
            minHeight: 50.dp,
            textColor: const Color(0xff131313),
            textSize: 16.dp,
            backgroundColor: Colors.white,
            borderRadius: 25.dp,
            onPressed: () {
              LogUtil.d('点击了服务预约');
              viewModel.callNumber();
            },
          ),
        ),
        // SizedBox(
        //   height: 40.dp,
        // ),
        // _buildVideoRow(),
        // SizedBox(
        //   height: 20.dp,
        // ),
        // _buildSettingRow(),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(top: 40.dp),
          itemBuilder: (context, index) {
            return _buildItem((viewModel.treeData[index]));
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 30.dp,
            );
          },
          itemCount: viewModel.treeData.length,
        )
      ],
    );
  }

  Widget _buildItem(MediaTree model) {
    var iconName = model.icon ?? '';
    Widget img = WebListConfigTool.iconImage(name: iconName);
    Widget space = WebListConfigTool.iconSpace(name: iconName);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.dp, vertical: 10.dp),
      child: InkWell(
          onTap: () {
            viewModel.requestMediaData(
              model: model,
              callback: (p0) {
                pagePush(AppRoute.webPage, params: p0?.toJson());
              },
            );
          },
          child: Row(
            children: [
              img,
              space,
              Expanded(
                child: Text(
                  model.title ?? '-',
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

  Widget _buildVideoRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.dp, vertical: 10.dp),
      child: InkWell(
          onTap: () {
            LogUtil.d('点击了视频教程');
          },
          child: Row(
            children: [
              Image.asset(
                AppIcons.imgServicePlayIcon,
                width: 17.7.dp,
                height: 17.7.dp,
              ),
              SizedBox(
                width: 18.dp,
              ),
              Expanded(
                child: Text(
                  LocaleKeys.video_course.tr(),
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

  Widget _buildSettingRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.dp, vertical: 10.dp),
      child: InkWell(
          onTap: () {
            LogUtil.d('点击了支持');
          },
          child: Row(
            children: [
              Image.asset(
                AppIcons.imgServiceSettingIcon,
                width: 17.7.dp,
                height: 17.7.dp,
              ),
              SizedBox(
                width: 18.dp,
              ),
              Expanded(
                child: Text(
                  LocaleKeys.support.tr(),
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
