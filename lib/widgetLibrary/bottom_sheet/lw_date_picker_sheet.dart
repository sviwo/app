import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../basic/colors/lw_colors.dart';
import 'lw_bottom_sheet.dart';
import 'lw_bottom_sheet_title.dart';

enum TimePickerType {
  year,
  month,
  day,
  hour,
  minute,
  second,
}

typedef DateChangedCallback = Function(DateTime time);
typedef DateCancelledCallback = Function();

class LWDatePickerSheet extends StatefulWidget {
  /// 推荐直接调用静态方法
  static Future show(
    BuildContext context, {
    Key? key,
    required List<TimePickerType> type,
    String? title,
    DateTime? currentTime,
    DateTime? minDateTime,
    DateTime? maxDateTime,
    bool? isDismissible,
    DateChangedCallback? onChanged,
    DateChangedCallback? onConfirm,
    DateCancelledCallback? onCancel,
  }) {
    return LWDatePickerSheet(
      context: context,
      type: type,
      title: title,
      currentTime: currentTime,
      minDateTime: minDateTime,
      maxDateTime: maxDateTime,
      onConfirm: onConfirm,
      isDismissible: isDismissible,
    ).showSheet;
  }

  List<TimePickerType> type;
  DateChangedCallback? onChanged;
  DateChangedCallback? onConfirm;
  DateCancelledCallback? onCancel;

  DateTime? currentTime;
  DateTime? minDateTime;
  DateTime? maxDateTime;

  Future get showSheet =>
      LWBottomSheet.show(context, child: this, isDismissible: isDismissible);

  //// sheet显示的上下文
  final BuildContext context;

  /// 标题
  final String? title;

  /// 点击背景是否关闭，默认true
  final bool? isDismissible;

  LWDatePickerSheet({
    Key? key,
    required this.context,
    required this.type,
    this.currentTime,
    this.minDateTime,
    this.maxDateTime,
    this.onChanged,
    this.onConfirm,
    this.onCancel,
    this.title = "选择时间",
    this.isDismissible,
  }) : super(key: key);

  @override
  State<LWDatePickerSheet> createState() => _LWDatePickerSheetState();
}

class _LWDatePickerSheetState extends State<LWDatePickerSheet> {
  final double _itemHeight = 52;
  late final LWBottomSheetTitle _title;
  late FixedExtentScrollController yearScrollController;
  late FixedExtentScrollController monthScrollController;
  late FixedExtentScrollController dayScrollController;
  late FixedExtentScrollController hourScrollController;
  late FixedExtentScrollController minScrollController;
  late FixedExtentScrollController secScrollController;
  late DateTime currentTime;
  late DateTime minDateTime;
  late DateTime maxDateTime;

  @override
  void initState() {
    currentTime = widget.currentTime ?? DateTime.now();
    minDateTime = widget.minDateTime ?? currentTime;
    maxDateTime =
        widget.maxDateTime ?? currentTime.add(const Duration(days: 365 * 50));
    if (maxDateTime.millisecondsSinceEpoch <
        minDateTime.millisecondsSinceEpoch) {
      maxDateTime = minDateTime.add(const Duration(days: 365 * 50));
    }
    if (currentTime.millisecondsSinceEpoch <
        minDateTime.millisecondsSinceEpoch) {
      currentTime = minDateTime;
    } else if (currentTime.millisecondsSinceEpoch >
        maxDateTime.millisecondsSinceEpoch) {
      currentTime = maxDateTime;
    }

    yearScrollController = FixedExtentScrollController(
        initialItem: currentTime.year - minDateTime.year);
    monthScrollController =
        FixedExtentScrollController(initialItem: currentTime.month - 1);
    dayScrollController =
        FixedExtentScrollController(initialItem: currentTime.day - 1);
    hourScrollController =
        FixedExtentScrollController(initialItem: currentTime.hour);
    minScrollController =
        FixedExtentScrollController(initialItem: currentTime.minute);
    secScrollController =
        FixedExtentScrollController(initialItem: currentTime.second);

    _title = _getTitle();

    super.initState();
  }

  Widget _buildSelectionOverlay() {
    final double height = _itemHeight;
    return IgnorePointer(
      key: const ValueKey("selectionOverlay"),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints.expand(
            height: height,
          ),
          child: CupertinoPickerDefaultSelectionOverlay(
            background: LWColors.theme.withOpacity(0.05),
          ),
        ),
      ),
    );
  }

  LWBottomSheetTitle _getTitle() {
    return LWBottomSheetTitle(
      key: ValueKey(widget.title),
      title: widget.title,
      titleAlign: TextAlign.center,
      onCancel: widget.onCancel,
      onConfirm: () {
        if (widget.onConfirm != null) {
          widget.onConfirm!(currentTime);
        }
      },
      items: const [
        LWBottomSheetTitleItem.cancel,
        LWBottomSheetTitleItem.title,
        LWBottomSheetTitleItem.confirm
      ],
    );
  }

  double get height {
    double height = _title.height;
    height += 230;
    return height;
  }

  _updateCurrentTime(
      {int? year, int? month, int? day, int? hour, int? minute, int? second}) {
    currentTime = DateTime(
      year ?? currentTime.year,
      month ?? currentTime.month,
      day ?? currentTime.day,
      hour ?? currentTime.hour,
      minute ?? currentTime.minute,
      second ?? currentTime.second,
    );

    if (currentTime.compareTo(minDateTime) == -1) {
      currentTime = minDateTime;
    } else if (maxDateTime.compareTo(currentTime) == -1) {
      currentTime = maxDateTime;
    }
    if (widget.type.contains(TimePickerType.month) &&
        monthScrollController.selectedItem != currentTime.month - 1) {
      monthScrollController.jumpToItem(currentTime.month - 1);
    }
    if (widget.type.contains(TimePickerType.day) &&
        dayScrollController.selectedItem != currentTime.day - 1) {
      dayScrollController.jumpToItem(currentTime.day - 1);
    }
    if (widget.type.contains(TimePickerType.hour) &&
        hourScrollController.selectedItem != currentTime.hour) {
      hourScrollController.jumpToItem(currentTime.hour);
    }
    if (widget.type.contains(TimePickerType.minute) &&
        minScrollController.selectedItem != currentTime.minute) {
      minScrollController.jumpToItem(currentTime.minute);
    }
    if (widget.type.contains(TimePickerType.second) &&
        secScrollController.selectedItem != currentTime.second) {
      secScrollController.jumpToItem(currentTime.second);
    }
  }

  int getMonthDay(year, month) {
    var a = {
      1: 31,
      2: 28,
      3: 31,
      4: 30,
      5: 31,
      6: 30,
      7: 31,
      8: 31,
      9: 30,
      10: 31,
      11: 30,
      12: 31
    };
    if (month != 2) {
      return a[month]!;
    } else {
      if (year % 400 == 0) {
        return 29;
      } else if (year % 4 == 0 && year % 100 != 0) {
        return 29;
      } else {
        return 28;
      }
    }
  }

  _getIndexStr(int index) {
    if (index < 10) {
      return "0$index";
    } else {
      return index.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _title,
          Expanded(
            child: Stack(
              children: [
                _buildSelectionOverlay(),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: () {
                        return widget.type.map<Widget>((e) {
                          if (e == TimePickerType.year) {
                            return _getColumnWidget(
                              controller: yearScrollController,
                              selectedIndex:
                                  currentTime.year - minDateTime.year,
                              itemCount:
                                  maxDateTime.year - minDateTime.year + 1,
                              itemText: (index) =>
                                  "${minDateTime.year + index}年",
                              onSelectedItemChanged: (value) {
                                _updateCurrentTime(
                                    year: minDateTime.year + value);
                                setState(() {});
                              },
                            );
                          } else if (e == TimePickerType.month) {
                            return _getColumnWidget(
                              controller: monthScrollController,
                              selectedIndex: currentTime.month - 1,
                              itemCount: 12,
                              itemText: (index) => "${index + 1}月",
                              onSelectedItemChanged: (value) {
                                var day =
                                    getMonthDay(currentTime.year, value + 1);
                                _updateCurrentTime(
                                    month: value + 1,
                                    day: min(currentTime.day, day));

                                setState(() {});
                              },
                            );
                          } else if (e == TimePickerType.day) {
                            return _getColumnWidget(
                              controller: dayScrollController,
                              selectedIndex: currentTime.day - 1,
                              itemCount: getMonthDay(
                                  currentTime.year, currentTime.month),
                              itemText: (index) =>
                                  "${_getIndexStr(index + 1)}日",
                              onSelectedItemChanged: (value) {
                                _updateCurrentTime(day: 1 + value);
                                setState(() {});
                              },
                            );
                          } else if (e == TimePickerType.hour) {
                            return _getColumnWidget(
                              controller: hourScrollController,
                              selectedIndex: currentTime.hour,
                              itemCount: 24,
                              itemText: (index) => "${_getIndexStr(index)}时",
                              onSelectedItemChanged: (value) {
                                _updateCurrentTime(hour: value);
                                setState(() {});
                              },
                            );
                          } else if (e == TimePickerType.minute) {
                            return _getColumnWidget(
                              controller: minScrollController,
                              selectedIndex: currentTime.minute,
                              itemCount: 60,
                              itemText: (index) => "${_getIndexStr(index)}分",
                              onSelectedItemChanged: (value) {
                                _updateCurrentTime(minute: value);
                                setState(() {});
                              },
                            );
                          } else if (e == TimePickerType.second) {
                            return _getColumnWidget(
                              controller: secScrollController,
                              selectedIndex: currentTime.second,
                              itemCount: 60,
                              itemText: (index) => "${_getIndexStr(index)}秒",
                              onSelectedItemChanged: (value) {
                                _updateCurrentTime(second: value);
                                setState(() {});
                              },
                            );
                          }
                          return const SizedBox();
                        }).toList();
                      }(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getColumnWidget({
    FixedExtentScrollController? controller,
    required int itemCount,
    required String Function(int index) itemText,
    int selectedIndex = 0,
    ValueChanged<int>? onSelectedItemChanged,
  }) {
    return Expanded(
      child: ListWheelScrollView.useDelegate(
        itemExtent: _itemHeight,
        controller: controller,
        physics: const FixedExtentScrollPhysics(),
        diameterRatio: 5,
        perspective: 0.0003,
        overAndUnderCenterOpacity: 0.6,
        onSelectedItemChanged: onSelectedItemChanged,
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: itemCount,
          builder: (context, index) {
            return Center(
              child: Text(
                itemText(index),
                style: selectedIndex == index
                    ? TextStyle(
                        color: LWColors.gray1,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)
                    : const TextStyle(
                        fontSize: 13,
                        color: LWColors.gray3,
                        fontWeight: FontWeight.w400),
              ),
            );
          },
        ),
      ),
    );
  }
}
