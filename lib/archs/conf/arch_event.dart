/// 事件
class ArchEvent {
  ArchEvent._();

  static String pageVisible = 'event/pageVisible'; // 页面可见性
  static String storagePermission = 'event/storagePermission'; // 申请权限
  static String tokenInvalid = 'event/tokenInvalid'; // 主要用于通知native登录token失效
  static String showLoading = 'event/showLoading'; // 展示进度弹窗
  static String hideLoading = 'event/hideLoading'; // 隐藏进度弹窗
  static String pagePop = 'event/pagePop'; // 主要用于VM通知BasePage退出页面
  static String pagePush = 'event/pagePush'; // 主要用于VM通知BasePage跳转页面
  static String pagePushAndRemoveUtil =
      'event/pagePushAndRemoveUtil'; // 主要用于VM通知BasePage跳转到某页面，并且移除之前的
  static String pageRefresh = 'event/pageRefresh'; // 页面刷新（主要用于VM触发）
  static String dataRefresh = 'event/dataRefresh'; // 数据刷新
  static String dataRefreshFinished =
      'event/dataRefreshFinished'; // 数据刷新结束，用于结束下拉或者上拉刷新状态
  static String pageStateChanged = 'event/pageStateChanged'; // 页面状态发生变化
  static String httpConfigChanged = 'event/httpConfigChanged'; // http配置变化
}
