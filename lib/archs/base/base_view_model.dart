import 'package:atv/archs/base/event_manager.dart';
import 'package:atv/archs/utils/log_util.dart';
import 'package:atv/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../widgetLibrary/complex/loading/lw_loading.dart';
import '../../widgetLibrary/complex/toast/lw_toast.dart';
import '../conf/arch_event.dart';
import '../data/entity/res_data.dart';
import '../data/err/http_error_exception.dart';
import 'base_mvvm_page.dart';
import 'event_bus.dart';

abstract class BaseViewModel with ChangeNotifier {
  /// 归属页面的哈希值（业务逻辑调用者不可赋值）
  int pageHashCode = 0;
  @protected
  bool dataReady = false;

  @protected
  void initialize(dynamic args);

  /// 需要重置所有数据/变量为初始状态。
  @protected
  void release();

  /// 展示加载中
  void showLoading() {
    EventManager.post(ArchEvent.showLoading);
  }

  /// 隐藏加载中
  void hideLoading() {
    EventManager.post(ArchEvent.hideLoading);
  }

  /// 退出页面
  ///   - 退回指定某一路由（未实现）
  void pagePop(
      {Map<String, dynamic>? resultParams,
      List<String>? untilRoutes,
      bool forceQuick = false}) {
    Map<String, dynamic> paramsCarry = resultParams ?? {};
    paramsCarry['carry_untilRoutes'] = untilRoutes;
    paramsCarry['carry_forceQuick'] = forceQuick;
    EventManager.post(ArchEvent.pagePop, data: paramsCarry);
  }

  /// 页面跳转
  ///   - 兼容flutter与本地容器跳转
  ///   - jumpNative模式不支持replace
  void pagePush(String route,
      {Map<String, dynamic>? params,
      Function? callback,
      bool jumpNative = false,
      bool needReplace = false,
      bool fullscreenDialog = false}) {
    Map<String, dynamic> paramsCarry = params ?? {};
    paramsCarry['carry_route'] = route;
    paramsCarry['carry_callback'] = callback;
    paramsCarry['carry_jumpNative'] = jumpNative;
    paramsCarry['carry_needReplace'] = needReplace;
    paramsCarry['fullscreenDialog'] = fullscreenDialog;
    EventManager.post(ArchEvent.pagePush, data: paramsCarry);
  }

  /// 页面跳转到某页面 并删除之前的路由页面
  void pagePushAndRemoveUtil(String route,
      {Map<String, dynamic>? params,
      Function? callback,
      bool fullscreenDialog = true}) {
    Map<String, dynamic> paramsCarry = params ?? {};
    paramsCarry['carry_route'] = route;
    paramsCarry['carry_callback'] = callback;
    paramsCarry['fullscreenDialog'] = fullscreenDialog;
    EventManager.post(ArchEvent.pagePushAndRemoveUtil, data: paramsCarry);
  }

  /// 通知关联页面刷新
  void pageRefresh({bool? dataReady}) {
    this.dataReady = dataReady ?? this.dataReady;
    EventManager.post(ArchEvent.pageRefresh,
        data: {'hashCode': pageHashCode, 'dataReady': dataReady});
  }

  // @override
  // void notifyListeners() {
  //   pageRefresh();
  // }

  /// 刷新页面状态（慎用）
  ///   - pageState, 仅限PageState.empty, PageState.error, PageState.content
  ///   - stateMsg, 配合PageState.error、PageState.empty使用
  void updatePageState(PageState pageState,
      {String? stateMsg, bool? dataReady}) {
    this.dataReady = dataReady ?? this.dataReady;
    EventManager.post(ArchEvent.pageStateChanged, data: {
      'pageState': pageState.value,
      'stateMsg': stateMsg,
      'hashCode': pageHashCode,
      'dataReady': dataReady
    });
  }

  /// 通知关联页面刷新数据
  void dataRefresh() {
    EventManager.post(ArchEvent.dataRefresh, data: {'hashCode': pageHashCode});
  }

  /// 通知关联页面数据
  void dataRefreshFinished() {
    EventManager.post(ArchEvent.dataRefreshFinished,
        data: {'hashCode': pageHashCode});
  }

  /// 默认的数据加载器（需业务VM继承重写）
  Future<void> loadData({isRefresh = true, bool showLoading = false}) async {}

  /// 请求接口，并对根据情况刷新页面状态
  /// params:
  ///   - errorMsg 发生异常时优先展示，如果没有则展示异常信息
  Future<ResData<T>?> loadApiData<T>(Future<ResData<T>> api,
      {bool showLoading = false,
      String? errorMsg,
      bool handlePageState = true,
      Function(T data)? dataSuccess,
      Function()? voidSuccess,
      Function(String? errorMsg)? onFailed}) async {
    String? newErrorMsg;
    var pageState = PageState.loading;
    showLoading = false;
    try {
      //
      if (showLoading) {
        try {
          await LWLoading.showLoading2();
        } catch (e) {}
      }

      //
      var res = await api;
      pageState = PageState.content;

      if (showLoading) {
        await LWLoading.dismiss(animation: false);
      }

      if (res.data != null) {
        await dataSuccess?.call(res.data!);
      } else {
        await voidSuccess?.call();
      }
      return res;
    } on HttpErrorException catch (e) {
      if (showLoading) {
        await LWLoading.dismiss(animation: false);
      }

      pageState = PageState.error;
      newErrorMsg = e.message;
      if (e.code == '-1') {
        newErrorMsg =
            errorMsg ?? newErrorMsg ?? LocaleKeys.network_access_error.tr();
      } else {
        newErrorMsg = newErrorMsg ??
            errorMsg ??
            LocaleKeys.network_data_unknown_error.tr();
      }
      if (onFailed == null && !handlePageState) {
        LWToast.show(newErrorMsg);
      } else {
        onFailed?.call(newErrorMsg);
      }
      return null;
    } on Exception catch (e) {
      if (showLoading) {
        await LWLoading.dismiss(animation: false);
      }
      pageState = PageState.error;
      newErrorMsg = e.toString();
      onFailed?.call(newErrorMsg);
      return null;
    } finally {
      if (handlePageState) {
        updatePageState(pageState, stateMsg: errorMsg ?? newErrorMsg);
      }
    }
  }
}
