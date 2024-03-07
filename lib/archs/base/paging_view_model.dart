import 'base_mvvm_page.dart';
import 'base_view_model.dart';
import '../data/entity/res_data.dart';
import '../data/entity/res_list.dart';

/// 分页数据VM
abstract class PagingViewModel<T> extends BaseViewModel {
  int _pageNum = 1;
  int _pageSize = 20;
  int _totalSize = 0;
  bool enablePullUp = false;
  bool enablePullDown = false;
  List<T> listData = [];

  @override
  void release() {
    _pageNum = 1;
    _pageSize = 20;
    _totalSize = 0;
    enablePullUp = false;
    enablePullDown = false;
    listData = [];
  }

  /// 获取当前页数
  int getPageNum(bool isRefresh) {
    return isRefresh ? 1 : _pageNum;
  }

  /// 获取每页条数
  int getPageSize() {
    return _pageSize;
  }

  /// 设置每页条数
  void setPageSize(int pageSize) {
    _pageSize = pageSize;
  }

  /// 获取记录总条数
  int getTotalSize() {
    return _totalSize;
  }

  /// 请求并加载分页数据
  Future<ResData<ResList<T>>?> loadPaging(Future<ResData<ResList<T>>> api, bool isRefresh, {bool showLoading = false, String? errorMsg}) async {
    if (isRefresh) {
      _pageNum = 1;
    } else if (listData.length >= _totalSize) {
      return null;
    }

    try {
      enablePullDown = false;
      var res = await loadApiData(api, showLoading: showLoading, errorMsg: errorMsg, handlePageState: false,
          onFailed: (newErrorMsg) {
        updatePageState(PageState.error, stateMsg: newErrorMsg ?? '未获取到有效数据');
        return null;
      });
      // 异常返回，配合onFailed使用
      if (res == null) {
        return null;
      }

      // 无异常返回
      if (res.data == null) {
        updatePageState(PageState.error, stateMsg: errorMsg ?? res.msg ?? '未获取到有效数据');
        return null;
      }
      var data = res.data!;
      enablePullDown = true;

      //
      _totalSize = data.total;
      if (_totalSize == 0) {
        listData = [];
      } else if (isRefresh) {
        listData = data.list ?? [];
      } else {
        listData.addAll(data.list ?? []);
      }
      enablePullUp = listData.length < _totalSize;
      if (enablePullUp) {
        _pageNum++;
      }
      updatePageState(_totalSize <= 0 ? PageState.empty : PageState.content);
      return res;
    } catch (e) {
      updatePageState(PageState.error, stateMsg: errorMsg ?? e.toString());
      return null;
    }
  }
}
