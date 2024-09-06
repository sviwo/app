// ignore_for_file: must_be_immutable


import 'package:flutter/material.dart';
import '../../utils/size_util.dart';

import '../../basic/colors/lw_colors.dart';
import '../../basic/font/lw_font_weight.dart';
import 'lw_tab_indicator.dart';

/// 对TabBar的封装
class LWTabBar extends StatefulWidget {
  LWTabBar({
    Key? key,
    required this.tabs,
    this.tabsPadding,
    this.controller,
    this.onTap,
    this.backgroundColor = Colors.transparent,
    this.isScrollable = false,
    this.clickable = true,
    this.height,
    this.selectedTextSize,
    this.selectedTextColor,
    this.unselectTextSize,
    this.unselectTextColor,
    this.indicatorWidth,
    this.indicatorHeight,
    this.indicatorPadding,
  }) : super(key: key);

  List<String> tabs;
  EdgeInsets? tabsPadding;
  TabController? controller;
  ValueChanged<int>? onTap;

  Color backgroundColor = Colors.transparent;
  bool isScrollable = false;
  bool clickable = true;
  double? height; // default is 44.dp
  double? selectedTextSize; // default is 14.sp
  Color? selectedTextColor; // default is LWColors.grey1
  double? unselectTextSize; // default is 14.sp
  Color? unselectTextColor; // default is LWColors.grey3
  double? indicatorWidth; // default is 16.dp
  double? indicatorHeight; // default is 3.dp
  double? indicatorPadding; // default is 6.dp

  @override
  State<StatefulWidget> createState() => _LWTabBarState();
}

class _LWTabBarState extends State<LWTabBar> {
  double _height = 44.dp;
  double _selectedTextSize = 14.sp;
  Color _selectedTextColor = LWColors.gray1;
  double _unselectTextSize = 14.sp;
  Color _unselectTextColor = LWColors.gray3;
  double _indicatorWidth = 16.dp;
  double _indicatorHeight = 3.dp;
  double _paddingTB = 0;

  @override
  void initState() {
    super.initState();
    _height = widget.height ?? _height;
    _selectedTextSize = widget.selectedTextSize ?? _selectedTextSize;
    _selectedTextColor = widget.selectedTextColor ?? _selectedTextColor;
    _unselectTextSize = widget.unselectTextSize ?? _unselectTextSize;
    _unselectTextColor = widget.unselectTextColor ?? _unselectTextColor;
    _indicatorWidth = widget.indicatorWidth ?? _indicatorWidth;
    _indicatorHeight = widget.indicatorHeight ?? _indicatorHeight;
    _paddingTB = (_height - _indicatorHeight - _selectedTextSize - (widget.indicatorPadding ?? 6.dp)) / 2;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      child: IgnorePointer(
        ignoring: !widget.clickable,
        child: TabBar(
          isScrollable: widget.isScrollable,
          tabs: widget.tabs
              .map(
                (e) => Tab(
                  height: _height,
                  child: Container(
                    padding: EdgeInsets.only(top: _paddingTB),
                    alignment: Alignment.topCenter,
                    child: Text(e, strutStyle: const StrutStyle(forceStrutHeight: true)),
                  ),
                ),
              )
              .toList(),
          labelStyle: TextStyle(fontSize: _selectedTextSize, fontWeight: LWFontWeight.bold),
          unselectedLabelStyle: TextStyle(fontSize: _unselectTextSize, fontWeight: LWFontWeight.normal),
          labelColor: _selectedTextColor,
          unselectedLabelColor: _unselectTextColor,
          labelPadding: widget.tabsPadding,
          indicator: LWUnderlineTabIndicator(
            borderSide: BorderSide(width: _indicatorHeight, color: LWColors.theme),
            width: _indicatorWidth,
            strokeCap: StrokeCap.round,
          ),
          indicatorPadding: EdgeInsets.only(bottom: _paddingTB),
          controller: widget.controller,
          onTap: widget.onTap,
        ),
      ),
    );
  }
}
