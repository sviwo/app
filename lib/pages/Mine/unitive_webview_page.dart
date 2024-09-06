import 'package:atv/archs/base/base_mvvm_page.dart';
import 'package:atv/config/conf/app_icons.dart';
import 'package:atv/config/data/entity/common/media_tree.dart';
import 'package:atv/pages/Mine/viewModel/unitive_web_view_page_view_model.dart';
import 'package:atv/widgetLibrary/complex/web/lw_web_view.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class UnitiveWebViewPage extends BaseMvvmPage {
  @override
  State<StatefulWidget> createState() => _UnitiveWebViewState();
}

class _UnitiveWebViewState
    extends BaseMvvmPageState<UnitiveWebViewPage, MultiLanguagePageViewModel> {
  @override
  MultiLanguagePageViewModel viewModelProvider() =>
      MultiLanguagePageViewModel();

  @override
  String? titleName() => viewModel.treeData?.title;

  @override
  Widget? headerBackgroundWidget() {
    return Image.asset(
      AppIcons.imgCommonBgNoStar,
      fit: BoxFit.cover,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // showLoading();
  }

  @override
  Widget buildBody(BuildContext context) {
    return viewModel.treeData == null
        ? Container()
        : LWWebView(
            mediaData: viewModel.treeData!,
            onPageFinished: (url) => hideLoading(),
            onWebResourceError: (error) {
              hideLoading();
            },
          );
  }
}
