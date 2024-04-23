import 'dart:convert';

import 'package:atv/archs/base/event_manager.dart';
import 'package:atv/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgetLibrary/complex/loading/lw_loading.dart';
import '../conf/arch_event.dart';
import '../conf/channel/arch_channel.dart';
import '../conf/channel/arch_channel_msg_send.dart';
import '../conf/channel/arch_channel_msg_take.dart';
import '../lw_arch.dart';
import '../utils/log_util.dart';
import 'event_bus.dart';
import 'route_manager.dart';

abstract class BaseApp extends StatefulWidget {
  const BaseApp({Key? key}) : super(key: key);

  static String? rootRoot;

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() {
    registerRoutes();
    return BaseAppState(build);
  }

  Widget build(BuildContext context, Widget page);

  void registerRoutes();
}

class BaseAppState extends State<BaseApp> {
  Function buildImpl;

  Widget _currPage = RouteManager.instance.getPage('/');

  String _uniqueKey() {
    String uniqueKey = toString();
    int lastIndex = uniqueKey.indexOf("(");
    if (lastIndex == -1) {
      return uniqueKey;
    } else {
      return uniqueKey.substring(0, lastIndex);
    }
  }

  @override
  void dispose() {
    ArchChannel.removeTakeNatives(
        ArchChannelMsgTake.commonPagePush, _uniqueKey());
    ArchChannel.removeTakeNatives(ArchChannelMsgSend.commonEvent, _uniqueKey());
    EventManager.unregister(_uniqueKey(), ArchEvent.showLoading);
    EventManager.unregister(_uniqueKey(), ArchEvent.hideLoading);
    super.dispose();
  }

  BaseAppState(this.buildImpl) {
    // 打开指定页面（native外部调用）
    ArchChannel.takeNatives(ArchChannelMsgTake.commonPagePush, _uniqueKey(),
        (call) async {
      if (mounted) {
        LWArch.initData()
            .then((value) => _initPage(jsonDecode(call.arguments)));
      }
    });
    // 接收
    ArchChannel.takeNatives(ArchChannelMsgSend.commonEvent, _uniqueKey(),
        (call) async {
      // LogUtil.d('-------------channel receive msg, data is ${call.arguments}');
      if (mounted) {
        var eventName = call.arguments['name'];
        Map? eventData;
        if (call.arguments['data'] != null) {
          if (call.arguments['data'] is Map) {
            eventData = call.arguments['data'];
          } else {
            eventData = jsonDecode(call.arguments['data']!.toString());
          }
        }
        EventBus.instance().post(eventName, eventData);
      }
    });

    // 加载中展示隐藏事件
    EventManager.register(_uniqueKey(), ArchEvent.showLoading, (arg) {
      if (mounted) {
        LWLoading.showLoading2(text: LocaleKeys.is_loading.tr());
      }
    });
    EventManager.register(_uniqueKey(), ArchEvent.hideLoading, (arg) {
      if (mounted) {
        LWLoading.dismiss();
      }
    });
  }

  void _initPage(dynamic json) async {
    var route = json['route'];
    var params = json['params'];
    BaseApp.rootRoot = route;
    //
    // Map<String, dynamic> paramsCarry = (params == null ? null : jsonDecode(params)) ?? {};
    // paramsCarry['carry_route'] = route;
    // paramsCarry['carry_callback'] = null;
    // paramsCarry['carry_jumpNative'] = false;
    // paramsCarry['carry_needReplace'] = false;
    // EventBus.instance().post(AppEvent.pagePush, paramsCarry);
    var page = RouteManager.instance.getPage(route);
    page.route = route;
    if (params != null) {
      page.args = jsonDecode(params);
    } else {
      page.args = {};
    }

    setState(() {
      _currPage = page;
    });
    LogUtil.d('BaseApp: pagePush=${jsonEncode(json)}');
  }

  @override
  Widget build(BuildContext context) {
    LogUtil.d('rebuild app');
    return buildImpl.call(context, _currPage);
  }
}
