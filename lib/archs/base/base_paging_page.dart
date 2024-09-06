
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../widgetLibrary/complex/page/lw_refresh.dart';
import 'base_mvvm_page.dart';
import 'paging_view_model.dart';

/// 列表分页基类
abstract class BasePagingPage<VM extends PagingViewModel> extends BaseMvvmPage {
  BasePagingPage({super.key, super.route, super.args});
}

abstract class BasePagingPageState<T extends BasePagingPage, VM extends PagingViewModel>
    extends BaseMvvmPageState<T, VM> {
  RefreshController? refreshController;

  @override
  void onPageStateChanged() {
    if (!mounted) return;
    if (pageState != PageState.loading) {
      refreshController?.refreshCompleted();
      refreshController?.loadComplete();
    }
  }

  @override
  void dataRefresh() {
    if (!mounted) return;
    if (pageState != PageState.content || refreshController == null) {
      viewModel.loadData(showLoading: true);
    } else {
      refreshController?.requestRefresh(duration: const Duration(milliseconds: 100));
    }
  }

  @override
  Widget bodyBuilder() {
    if (pageState == PageState.empty || pageState == PageState.error) {
      return super.bodyBuilder();
    } else {
      return LWRefresh(
        onRefresh: () => viewModel.loadData(isRefresh: true, showLoading: false),
        onLoading: () => viewModel.loadData(isRefresh: false, showLoading: false),
        enablePullUp: viewModel.enablePullUp,
        enablePullDown: viewModel.enablePullDown,
        onControllerCallback: (controller) => refreshController = controller,
        child: super.bodyBuilder(),
      );
    }
  }
}
