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
    EventBus.instance().post(ArchEvent.showLoading);
  }

  /// 隐藏加载中
  void hideLoading() {
    EventBus.instance().post(ArchEvent.hideLoading);
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
    EventBus.instance().post(ArchEvent.pagePop, paramsCarry);
  }

  /// 页面跳转
  ///   - 兼容flutter与本地容器跳转
  ///   - jumpNative模式不支持replace
  void pagePush(String route,
      {Map<String, dynamic>? params,
      Function? callback,
      bool jumpNative = false,
      bool needReplace = false}) {
    Map<String, dynamic> paramsCarry = params ?? {};
    paramsCarry['carry_route'] = route;
    paramsCarry['carry_callback'] = callback;
    paramsCarry['carry_jumpNative'] = jumpNative;
    paramsCarry['carry_needReplace'] = needReplace;
    EventBus.instance().post(ArchEvent.pagePush, paramsCarry);
  }

  /// 通知关联页面刷新
  void pageRefresh({bool? dataReady}) {
    this.dataReady = dataReady ?? this.dataReady;
    EventBus.instance().post(ArchEvent.pageRefresh,
        {'hashCode': pageHashCode, 'dataReady': dataReady});
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
    EventBus.instance().post(ArchEvent.pageStateChanged, {
      'pageState': pageState.value,
      'stateMsg': stateMsg,
      'hashCode': pageHashCode,
      'dataReady': dataReady
    });
  }

  /// 通知关联页面刷新数据
  void dataRefresh() {
    EventBus.instance().post(ArchEvent.dataRefresh, {'hashCode': pageHashCode});
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
    try {
      //
      if (showLoading) {
        try {
          await LWLoading.showLoading2().timeout(const Duration(seconds: 3));
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
        newErrorMsg = errorMsg ?? newErrorMsg ?? '网络访问错误';
      } else {
        newErrorMsg = newErrorMsg ?? errorMsg ?? '网络数据未知错误';
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
