import 'dart:convert';

import '../lw_arch.dart';
import 'event_bus.dart';
import '../conf/channel/arch_channel.dart';
class EventManager {
  EventManager._internal();

  static void register(owner, eventName, _Callback f) {
    EventBus.instance().register(owner, eventName, f);
  }

  static void unregister(owner, eventName) {
    EventBus.instance().unregister(owner, eventName);
  }

  static void post(eventName, {Map<String, dynamic>? data}) {
    // 事件直接分发给本flutterEngine内的页面
    EventBus.instance().post(eventName, data);

    // 事件通过channel分发给native和其他flutterEngine
    if (LWArch.mixDevelop) {
      ArchChannel.sendEvent(eventName, data: data == null ? null : jsonEncode(data));
    }
  }
}

// 回调签名
typedef void _Callback(args);
