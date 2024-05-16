import 'package:atv/archs/base/base_mvvm_page.dart';
import 'package:atv/archs/utils/extension/ext_string.dart';
import 'package:atv/archs/utils/log_util.dart';
import 'package:atv/config/conf/app_icons.dart';
import 'package:atv/config/conf/route/app_route_settings.dart';
import 'package:atv/config/data/entity/common/media_tree.dart';
import 'package:atv/pages/Mine/define/web_list_config_tool.dart';
import 'package:atv/pages/Mine/viewModel/children_webview_page_view_model.dart';
import 'package:atv/widgetLibrary/utils/size_util.dart';
import 'package:flutter/material.dart';

class ChildrenWebViewPage extends BaseMvvmPage {
  @override
  State<StatefulWidget> createState() => _ChildrenWebViewPageState();
}

class _ChildrenWebViewPageState extends BaseMvvmPageState<ChildrenWebViewPage,
    ChildrenWebViewPageViewModel> {
  @override
  ChildrenWebViewPageViewModel viewModelProvider() =>
      ChildrenWebViewPageViewModel();
  @override
  String? titleName() => viewModel.treeData?.title;
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
    LogUtil.d('-------------${viewModel.treeData?.children?.length ?? 0}');
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 50.dp),
      itemBuilder: (context, index) {
        return _buildItem((viewModel.treeData?.children?[index])!);
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 30.dp,
        );
      },
      itemCount: viewModel.treeData?.children?.length ?? 0,
    );
  }

  Widget _buildItem(MediaTree model) {
    var iconName = '';
    if (model.icon.isNullOrEmpty() == false) {
      iconName = model.icon!;
    } else if (viewModel.treeData?.icon?.isNullOrEmpty() == false) {
      iconName = (viewModel.treeData?.icon)!;
    }
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
}
