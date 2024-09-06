import 'dart:io';

import 'package:atv/config/data/entity/common/media_tree.dart';
import 'package:atv/widgetLibrary/complex/loading/lw_loading.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class LWWebView extends StatefulWidget {
  const LWWebView(
      {Key? key,
      required this.mediaData,
      this.navigationDelegate,
      this.onPageStarted,
      this.onPageFinished,
      this.onProgress,
      this.onWebResourceError,
      this.onCallback})
      : super(key: key);
  final MediaTree mediaData;
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
      ..setUserAgent(
          'Mozilla/5.0 (flutter; ${Platform.isIOS ? 'iPhone' : 'Android'}) Mobile')
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: widget.onPageStarted,
        onPageFinished: widget.onPageFinished,
        onProgress: widget.onProgress,
        onWebResourceError: widget.onWebResourceError,
      ));
    if (widget.mediaData.displayType == 0) {
      // 内容
      _controller?.loadHtmlString(widget.mediaData.content ?? '');
      LWLoading.dismiss();
    } else if (widget.mediaData.displayType == 1) {
      //外链
      _controller?.loadRequest(Uri.parse(widget.mediaData.content ?? ''));
    }
    widget.onCallback?.call(_controller!);
  }

  @override
  void dispose() {
    debugPrint("-----webview dispose");
    // if (await _controller?.canGoBack() == true) {
    //   _controller?.goBack();
    // }
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
