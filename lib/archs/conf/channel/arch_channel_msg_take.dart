/// channel通道的消息定义（flutter被动接收native）
///   - 数据交互
///   - 页面跳转
class ArchChannelMsgTake {
  ArchChannelMsgTake._internal();

  // 通用消息
  static const String commonPagePush = 'common/pagePush'; // 打开flutter页面
  static const String commonNativeWillPop = "common/nativeWillPop"; // 关闭flutter页面
}
