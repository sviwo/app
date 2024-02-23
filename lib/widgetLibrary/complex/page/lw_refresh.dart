import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'lw_refresh_footer.dart';
import 'lw_refresh_header.dart';

class LWRefresh extends StatefulWidget {
  const LWRefresh({Key? key, this.controller, required this.child, this.enablePullDown = true, this.enablePullUp = true,
  this.onRefresh,this.onLoading,this.footer,this.header, this.scrollController, this.onControllerCallback})
      : super(key: key);
  final RefreshController? controller;
  final ScrollController? scrollController;
  final bool enablePullUp;
  final bool enablePullDown;
  final Widget child;
  final Widget? header;
  final Widget? footer;
  final VoidCallback? onRefresh;
  final Function(RefreshController)? onControllerCallback;

  /// callback when footer loading more data
  ///
  /// when the callback is happening,you should use [RefreshController]
  /// to end loading state,else it will keep loading state
  final VoidCallback? onLoading;
  @override
  _LWRefreshState createState() => _LWRefreshState();
}

class _LWRefreshState extends State<LWRefresh> {
  RefreshController? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = RefreshController();
      widget.onControllerCallback?.call(_controller!);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: widget.controller ?? _controller!,
      header: widget.header ?? const LWRefreshHeader(),
      footer: widget.header ?? const LWRefreshFooter(),
      enablePullDown: widget.enablePullDown,
      enablePullUp: widget.enablePullUp,
      onRefresh: widget.onRefresh,
      onLoading: widget.onLoading,
      scrollController: widget.scrollController,
      child: widget.child,
    );
  }
}
