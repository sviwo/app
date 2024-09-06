import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:svgaplayer_flutter/svgaplayer_flutter.dart';

class LWRefreshHeader extends StatefulWidget {

  const LWRefreshHeader({Key? key,this.bgColor}) : super(key: key);
  final Color? bgColor;
  @override
  _LWRefreshHeaderState createState() => _LWRefreshHeaderState();
}

class _LWRefreshHeaderState extends State<LWRefreshHeader> {
  @override
  Widget build(BuildContext context) {
    return CustomHeader(builder: (BuildContext context, RefreshStatus? mode) {
      return Container(
        decoration: BoxDecoration(color: widget.bgColor),
        width: 20,
        height: 20,
        child: const SVGASimpleImage(
          assetsName:
          'packages/fe_widget_flutter/assets/images/ic_loading.svga',
        ),
      );
    },
    );
  }
}