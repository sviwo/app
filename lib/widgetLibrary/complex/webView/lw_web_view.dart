import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import 'js_bridge_util.dart';
import 'js_callback.dart';

class LWWebView extends StatefulWidget {
  const LWWebView(
      {Key? key,
      required this.url,
      this.callBack,
      this.navigationDelegate,
      this.onPageStarted,
      this.onPageFinished,
      this.onProgress,
      this.onWebResourceError,
      this.onCallback})
      : super(key: key);
  final String url;
  final JsCallBack? callBack;
  final NavigationDelegate? navigationDelegate;
  final Function(String url)? onPageStarted;
  final Function(String url)? onPageFinished;
  final Function(int)? onProgress;
  final Function(WebResourceError error)? onWebResourceError;
  final Function(WebViewController)? onCallback;

  @override
  State<LWWebView> createState() => _LWWebViewState();
}

class _LWWebViewState extends State<LWWebView> {
  WebViewController? _controller;

  @override
  void initState() {
    debugPrint("-----webview initState");
    super.initState();
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    _controller = WebViewController.fromPlatformCreationParams(params);
    _controller!
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent('Mozilla/5.0 (flutter; ${Platform.isIOS ? 'iPhone' : 'Android'})')
      // ..setUserAgent('Mozilla/5.0 flutter')
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: widget.onPageStarted,
        onPageFinished: widget.onPageFinished,
        onProgress: widget.onProgress,
        onWebResourceError: widget.onWebResourceError,
      ))
      ..addJavaScriptChannel("LWFlutterJsBridge", onMessageReceived: (message) {
        LWJsUtils.executeMethod(_controller, message.message, widget.callBack);
      })
      ..loadRequest(Uri.parse(widget.url));
    widget.onCallback?.call(_controller!);
  }

  @override
  void dispose() {
    debugPrint("-----webview dispose");
    // if (await _controller?.canGoBack() == true) {
    //   _controller?.goBack();
    // }
    _controller?.removeJavaScriptChannel("LWFlutterJsBridge");
    _controller?.clearCache();
    _controller?.clearLocalStorage();
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      controller: _controller!,
    );
  }
}
