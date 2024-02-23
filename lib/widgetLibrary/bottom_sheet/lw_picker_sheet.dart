
import 'package:flutter/cupertino.dart';

import '../basic/colors/lw_colors.dart';
import 'lw_bottom_sheet.dart';
import 'lw_bottom_sheet_model.dart';
import 'lw_bottom_sheet_title.dart';

class LWPickerSheet extends StatefulWidget {
  /// 推荐直接调用静态方法
  static Future show(
    BuildContext context, {
    Key? key,
    required List<LWSheetModel> dataList,
    String? title,
    bool? isDismissible,
    Function(LWSheetModel model)? onConfirm,
    Function()? onCancel,
  }) {
    return LWPickerSheet(
      context,
      dataList: dataList,
      title: title,
      onConfirm: onConfirm,
      isDismissible: isDismissible,
    ).showSheet;
  }

  Future get showSheet => LWBottomSheet.show(context, child: this, isDismissible: isDismissible);

  //// sheet显示的上下文
  final BuildContext context;

  /// sheet列表数据
  final List<LWSheetModel> dataList;

  /// 标题
  final String? title;

  /// 点击背景是否关闭，默认true
  final bool? isDismissible;

  /// 点击取消
  final Function()? onCancel;

  /// 点击确认
  final Function(LWSheetModel model)? onConfirm;

  const LWPickerSheet(
    this.context, {
    Key? key,
    required this.dataList,
    this.title,
    this.onConfirm,
    this.isDismissible,
    this.onCancel,
  }) : super(key: key);

  @override
  State<LWPickerSheet> createState() => _LWPickerSheetState();
}

class _LWPickerSheetState extends State<LWPickerSheet> {
  final double _itemHeight = 52;
  late LWSheetModel _selectedItem;
  late final LWBottomSheetTitle _title;
  final _scrollController = FixedExtentScrollController();

  @override
  void initState() {
    _title = _getTitle();
    _selectedItem = widget.dataList.first;
    Future.delayed(Duration.zero).then(
      (value) {
        for (var item in widget.dataList) {
          if (item.isSelected && _scrollController.hasClients) {
            _scrollController.jumpToItem(widget.dataList.indexOf(item));
            break;
          }
        }
      },
    );
    super.initState();
  }

  _getListView(List<LWSheetModel> dataList) {
    return Expanded(
      child: Stack(
        children: <Widget>[
          _buildSelectionOverlay(),
          Positioned.fill(
            child: ListWheelScrollView.useDelegate(
              itemExtent: _itemHeight,
              controller: _scrollController,
              physics: const FixedExtentScrollPhysics(),
              diameterRatio: widget.dataList.length * _itemHeight,
              perspective: 0.0003,
              overAndUnderCenterOpacity: 0.6,
              onSelectedItemChanged: (value) {
                _selectedItem = dataList[value];
              },
              childDelegate: ListWheelChildBuilderDelegate(
                childCount: dataList.length,
                builder: (context, index) {
                  LWSheetModel model = dataList[index];
                  return Center(
                    child: Text(
                      model.label,
                      style: TextStyle(
                        color: LWColors.gray1,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionOverlay() {
    final double height = _itemHeight;
    return IgnorePointer(
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
      title: widget.title,
      titleAlign: TextAlign.center,
      onCancel: widget.onCancel,
      onConfirm: () {
        if (widget.onConfirm != null) {
          widget.onConfirm!(_selectedItem);
        }
      },
      items: const [LWBottomSheetTitleItem.cancel, LWBottomSheetTitleItem.title, LWBottomSheetTitleItem.confirm],
    );
  }

  double get height {
    double height = _title.height;
    if (widget.dataList.length > 5) {
      height += 5 * _itemHeight;
    } else {
      height += 3 * _itemHeight;
    }
    return height;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _title,
          _getListView(widget.dataList),
        ],
      ),
    );
  }
}
