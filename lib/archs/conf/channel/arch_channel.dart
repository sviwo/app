import 'package:flutter/services.dart';
import '../../../widgetLibrary/complex/toast/lw_toast.dart';
import '../../data/entity/page_router.dart';
import 'arch_channel_util.dart';

import '../../lw_arch.dart';
import 'arch_channel_msg_send.dart';

class ArchChannel {
  ArchChannel._internal();

  static String channelName = 'com.sviwo.common';

  static const String _prefix = 'com.sviwo.atv';

  static const MethodChannel _common =
      MethodChannel('$_prefix.common'); // 通用channel

  /// 发送Event事件至native，native容器负责转发至native的消息分发中心和其他flutterEngine
  static Future sendEvent(String name, {String? data}) {
    if (LWArch.mixDevelop) {
      return _common.sendNative(ArchChannelMsgSend.commonEvent,
          params: {"name": name, "data": data});
    } else {
      LWToast.show('纯Flutter项目，不支持原生调用(sendEvent)');
      return Future(() => null);
    }
  }

  /// 打开native页面
  static Future nativePush(PageRouter params) {
    if (LWArch.mixDevelop) {
      return _common.sendNative(ArchChannelMsgSend.commonNativePush,
          params: params.toJson());
    } else {
      LWToast.show('纯Flutter项目，不支持原生调用(nativePush)');
      return Future(() => null);
    }
  }

  /// 发送flutter消息至native
  static Future sendNative(String methodName, {Map<String, dynamic>? params}) {
    if (LWArch.mixDevelop) {
      return _common.invokeMethod(methodName, params);
    } else {
      // LWToast.show('纯Flutter项目，不支持原生调用(sendNative)');
      return Future(() => null);
    }
  }

  static void takeNatives(String methodName, String handlerName,
      Future<dynamic> Function(MethodCall call)? handler) {
    _common.takeNatives(methodName, handlerName, handler);
  }

  static void removeTakeNatives(String methodName, String handlerName) {
    _common.removeTakeNatives(methodName, handlerName);
  }
}
