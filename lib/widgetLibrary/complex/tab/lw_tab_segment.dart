import 'package:flutter/material.dart';
import '../../utils/size_util.dart';

import '../../basic/colors/lw_colors.dart';

/// TabBar Segment 样式
class LWTabSegment extends StatefulWidget {
  LWTabSegment({
    Key? key,
    required this.tabs,
    this.onTap,
    this.clickable = true,
    this.initialIndex,
    this.adaptiveWidth = true,
    this.height,
    this.textSize,
  }) : super(key: key);

  List<String> tabs;
  ValueChanged<int>? onTap;

  /// The initial index of the selected tab.
  int? initialIndex;

  bool clickable = true;
  bool adaptiveWidth = true; // 自适应宽度
  double? height; // default is 44.dp
  double? textSize; // default is 14.sp

  @override
  State<StatefulWidget> createState() => _LWTabSegmentState();
}

class _LWTabSegmentState extends State<LWTabSegment> {
  double _height = 30.dp;
  double _textSize = 13.sp;

  int _activedIndex = 0;

  @override
  void initState() {
    super.initState();
    _height = widget.height ?? _height;
    _textSize = widget.textSize ?? _textSize;
    resetActivedIndex();
  }

  @override
  void didUpdateWidget(LWTabSegment segment) {
    super.didUpdateWidget(segment);
    resetActivedIndex();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.clickable,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: LWColors.theme, width: 0.5.dp),
          borderRadius: BorderRadius.all(Radius.circular(4.dp)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: tabList(context),
        ),
      ),
    );
  }

  void resetActivedIndex() {
    _activedIndex = widget.initialIndex ?? _activedIndex;
  }

  List<Widget> tabList(BuildContext context) {
    List<Widget> list = [];
    for (int index = 0; index < widget.tabs.length; index++) {
      bool actived = index == _activedIndex;
      String text = widget.tabs[index];
      var tabChild = InkWell(
        child: Container(
          height: _height,
          padding: EdgeInsets.symmetric(horizontal: 10.dp),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: actived ? LWColors.theme : Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(actived && index == 0 ? 4.dp : 0),
              bottomLeft: Radius.circular(actived && index == 0 ? 4.dp : 0),
              topRight: Radius.circular(
                  actived && index == widget.tabs.length - 1 ? 4.dp : 0),
              bottomRight: Radius.circular(
                  actived && index == widget.tabs.length - 1 ? 4.dp : 0),
            ),
          ),
          child: Text(
            text,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: actived ? Colors.white : LWColors.theme,
                fontSize: _textSize),
          ),
        ),
        onTap: () {
          setState(() {
            _activedIndex = index;
          });
          widget.onTap?.call(index);
        },
      );
      var tab = !widget.adaptiveWidth ? tabChild : Expanded(child: tabChild);
      list.add(tab);
      if (index < widget.tabs.length - 1) {
        list.add(Container(
          color: LWColors.theme,
          width: 0.5.dp,
          height: _height,
        ));
      }
    }
    return list;
  }
}
