/// 事件
class AppEvent {
  AppEvent._internal();

  // 通用
  static String respectGreat = 'event/respectGreat'; // 致敬XX
  static String deptRefresh = 'event/deptRefresh'; // 组织请求刷新
  static String deptLoadFailed = 'event/deptLoadFailed'; // 组织加载失败
  static String shareMiniProgram = 'event/shareMiniProgram'; // 分享小程序

  /// 设置屏幕方向
  static String setOrientation = 'event/setOrientation';

  /// 用户信息改变(编辑之后)
  static String userBaseInfoChange = 'event/userBaseInfoChange';

  /// 选择的语言切换了
  static String languageChange = 'event/languageChange';

  /// 车辆信息变更
  static String vehicleInfoChange = 'event/vehicleInfoChange';
}
