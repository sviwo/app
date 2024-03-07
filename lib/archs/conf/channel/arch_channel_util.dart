
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/log_util.dart';

/// Method便捷调用封装
///   - receiveNative，链式监听native调用（需缓存handler）
class ArchChannelUtil {
  // AppChannelUtil._internal();
  // static final AppChannelUtil _singleton = AppChannelUtil._internal();
  // factory AppChannelUtil.instance() => _singleton;
  static final ArchChannelUtil _singleton = ArchChannelUtil();

  // 逐级缓存 channel -> method -> handler
  final Map _cacheHandler = {};

  // 缓存channel，用来判断有无init
  final List _cacheChannels = [];

  // 添加handler缓存
  static void addMethodCallHandler(
      MethodChannel channel, String methodName, String handlerName, Future<dynamic> Function(MethodCall call) handler) {
    LogUtil.d('addMethodCallHandler: methodName:$methodName,handlerName:$handlerName');
    String channelName = channel.name;
    if (!_singleton._cacheChannels.contains(channel)) {
      channel._init();
      _singleton._cacheChannels.add(channel);
    }

    //
    Map channelMap = _singleton._cacheHandler[channelName] ?? {};
    Map methodMap = channelMap[methodName] ?? {};
    methodMap[handlerName] = handler;
    channelMap[methodName] = methodMap;
    _singleton._cacheHandler[channelName] = channelMap;
    // LogUtil.d(channelMap.keys.map((e) => e.toString()).toList().join('\n'));
  }

  // 移除handler缓存
  static void removeMethodCallHandler(MethodChannel channel, String methodName, String handlerName) {
    String channelName = channel.name;
    Map channelMap = _singleton._cacheHandler[channelName] ?? {};
    Map methodMap = channelMap[methodName] ?? {};
    LogUtil.d(
        'removeMethodCallHandler: methodName:${methodName},handlerName:${handlerName}, ${methodMap[handlerName]}');
    methodMap.remove(handlerName);
    channelMap[methodName] = methodMap;
    _singleton._cacheHandler[channelName] = channelMap;
  }
}

/// 扩展Channel
extension XCMethodChannel on MethodChannel {
  // Future sendEvent(String name, {String? data}) {
  //   return sendNative(ArchChannelMsgSend.commonEvent, params: {"name": name, "data": data});
  // }

  /// 发送flutter消息至native
  Future sendNative(String methodName, {Map<String, dynamic>? params}) {
    return invokeMethod(methodName, params);
  }

  // /// 打开native页面
  // Future nativePush(PageRouter params) {
  //   return sendNative(ArchChannelMsgSend.commonNativePush, params: params.toJson());
  // }

  _init() {
    setMethodCallHandler((call) async {
      // 1. 从缓存中找到指定channel
      Map channelMap = ArchChannelUtil._singleton._cacheHandler[name] ?? {};
      // 2. 从缓存中找到指定事件
      Map methodMap = channelMap[call.method] ?? {};

      methodMap.forEach((key, value) {
        LogUtil.d('channel receivedMsg: methodName:${call.method},handlerName:${key}');
        value(call);
      });
    });
  }

  /// 监听同一个native消息，其中一个调用方可以出发全部调用方的响应逻辑
  /// methodName & handlerName合起来进行唯一标识
  ///   - methodName 事件名称
  ///   - handlerName 监听对象
  takeNatives(String methodName, String handlerName, Future<dynamic> Function(MethodCall call)? handler) {
    LogUtil.d('takeNatives: channelName:$name, methodName:$methodName, handlerName:$handlerName');
    if (handler != null) {
      ArchChannelUtil.addMethodCallHandler(this, methodName, handlerName, handler);
    }
  }

  /// 解除监听同一个native消息，防止其他调用方触发当前调用方的响应逻辑
  /// methodName & handlerName合起来进行唯一标识
  ///   - methodName 事件名称
  ///   - handlerName 监听对象
  removeTakeNatives(String methodName, String handlerName) {
    ArchChannelUtil.removeMethodCallHandler(this, methodName, handlerName);
  }
}
