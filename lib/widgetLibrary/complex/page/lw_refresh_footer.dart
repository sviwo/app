import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:svgaplayer_flutter/svgaplayer_flutter.dart';
class LWRefreshFooter extends StatefulWidget {
  const LWRefreshFooter({Key? key,this.bgColor}) : super(key: key);
  final Color? bgColor;
  @override
  _LWRefreshFooterState createState() => _LWRefreshFooterState();
}

class _LWRefreshFooterState extends State<LWRefreshFooter> {
  @override
  Widget build(BuildContext context) {
    return CustomFooter(builder: (BuildContext context, LoadStatus? mode) {
     return Container(
        decoration: BoxDecoration(color:widget.bgColor),
        width: 20,
        height: 20,
        child: const SVGASimpleImage(
          assetsName:
          'packages/fe_widget_flutter/assets/images/ic_loading.svga',
        ),
      );

    },);
  }
}