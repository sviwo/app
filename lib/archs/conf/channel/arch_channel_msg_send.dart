/// channel通道的消息定义（flutter主动调用native）
///   - 数据交互
///   - 页面跳转
class ArchChannelMsgSend {
  ArchChannelMsgSend._internal();

  // 通用消息
  static const String commonNativePush = 'common/nativePush'; // 打开native页面
  static const String commonNativePop = 'common/nativePop'; // 关闭native容器
  static const String commonEvent = 'common/event'; // 事件
}