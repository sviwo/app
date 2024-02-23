
import 'package:flutter/material.dart';

import '../basic/button/lw_button.dart';
import '../basic/colors/lw_colors.dart';
import '../lw_widget.dart';
import 'lw_bottom_sheet.dart';
import 'lw_bottom_sheet_model.dart';
import 'lw_bottom_sheet_title.dart';

// UI:https://lanhuapp.com/web/#/item/project/detailDetach?pid=0f68ba35-e9f5-409c-a210-5f80d0c59f8c&image_id=43ba539a-3fee-47be-91fc-728699d87969&project_id=0f68ba35-e9f5-409c-a210-5f80d0c59f8c&fromEditor=true&type=image

// 底部单/多选
class LWSelectSheet extends StatefulWidget {
  /// 推荐直接调用静态方法
  static Future show(
    BuildContext context, {
    Key? key,
    required List<LWSheetModel> dataList,
    // 注意：同时删除_LWSelectSheetState中_selectionMarkOld方法
    @Deprecated('选中状态请设置LWSheetModel.isSelected，selectedList在未来某个时段会删除') List<LWSheetModel>? selectedList,
    String? title,
    bool isMultipleSelect = false,
    bool? isDismissible,
    Function(List<LWSheetModel> list)? onSelectComplete,
    Function()? onClose,
    Function()? onCancel,
  }) {
    return LWSelectSheet(
      context,
      dataList: dataList,
      selectedList: selectedList,
      title: title,
      onSelectComplete: onSelectComplete,
      isDismissible: isDismissible,
      isMultipleSelect: isMultipleSelect,
    ).showSheet;
  }

  Future get showSheet => LWBottomSheet.show(context, child: this, isDismissible: isDismissible);

  //// sheet显示的上下文
  final BuildContext context;

  /// sheet列表数据
  final List<LWSheetModel> dataList;

  /// sheet 默认选中的数据
  final List<LWSheetModel>? selectedList;

  /// 标题
  final String? title;

  /// 是否多选，默认 false
  final bool isMultipleSelect;

  /// 点击背景是否关闭，默认true
  final bool? isDismissible;

  /// 选择完成的回调
  final Function(List<LWSheetModel> list)? onSelectComplete;

  /// 单选点击取消，多选无效
  final Function()? onCancel;

  /// 显示标题栏时，点击关闭回调
  final Function()? onClose;

  const LWSelectSheet(
    this.context, {
    Key? key,
    required this.dataList,
    this.selectedList,
    this.title,
    this.onSelectComplete,
    this.onClose,
    this.isMultipleSelect = false,
    this.isDismissible,
    this.onCancel,
  }) : super(key: key);

  @override
  State<LWSelectSheet> createState() => _LWSelectSheetState();
}

class _LWSelectSheetState extends State<LWSelectSheet> {
  final double _bottomHeight = 54;
  final double _itemHeight = 52;

  @override
  void initState() {
    super.initState();

    _selectionMarkOld();

    if (widget.isMultipleSelect == false) {
      assert(widget.dataList.where((element) => element.isSelected).length < 2, "单选模式，选中数量不能大于1");
    }
  }

  void _selectionMarkOld() {
    widget.selectedList?.forEach((e) {
      try {
        var m = widget.dataList.firstWhere((element) => element.value == e.value && element.label == e.label);
        m.isSelected = true;
      } catch (e) {}
    });
  }

  _getListView(List<LWSheetModel> dataList) {
    return Expanded(
      child: ListView.builder(
        itemExtent: _itemHeight,
        itemCount: dataList.length,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          LWSheetModel model = dataList[index];
          bool isSelected = model.isSelected;
          return Column(
            children: [
              Expanded(
                child: ListTile(
                  onTap: () {
                    if (widget.isMultipleSelect) {
                      model.isSelected = !model.isSelected;
                    } else {
                      for (var item in dataList) {
                        item.isSelected = false;
                      }
                      model.isSelected = true;
                      _onSelectComplete();
                    }

                    setState(() {});
                  },
                  selected: isSelected,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 12,
                          child: LWWidget.assetSvg("ic_item_selected.svg", height: isSelected ? 12 : 0, width: 12, color: LWColors.theme)
                      ),
                      const SizedBox(width: 5),
                      Text(
                        model.label,
                        style: TextStyle(
                          color: isSelected ? LWColors.theme : LWColors.gray1,
                          fontSize: 14,
                          fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                        ),
                      ),
                      const SizedBox(width: 17),
                    ],
                  ),
                ),
              ),
              const Divider(
                height: 1,
                color: LWColors.gray6,
              ),
            ],
          );
        },
      ),
    );
  }

  _onSelectComplete() {
    Navigator.pop(context);
    if (widget.onSelectComplete != null) {
      if (widget.isMultipleSelect) {
        widget.onSelectComplete!(widget.dataList.where((e) => e.isSelected).toList());
      } else {
        widget.onSelectComplete!([widget.dataList.firstWhere((e) => e.isSelected)]);
      }
    }
  }

  _onCancel() {
    Navigator.pop(context);
    if (widget.onCancel != null) {
      widget.onCancel!();
    }
  }

  _getButton() {
    return Container(
      color: widget.isMultipleSelect ? Colors.white : LWColors.gray7,
      height: _bottomHeight,
      width: double.infinity,
      padding: widget.isMultipleSelect
          ? const EdgeInsets.symmetric(vertical: 8, horizontal: 18)
          : const EdgeInsets.only(top: 10),
      child: LWButton.custom(
        child: widget.isMultipleSelect
            ? const Text(
                "确定",
                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
              )
            : const Text(
                "取消",
                style: TextStyle(
                  color: LWColors.gray4,
                  fontSize: 14,
                ),
              ),
        minHeight: widget.isMultipleSelect ? 38 : 44,
        backgroundColor: widget.isMultipleSelect ? LWColors.theme : Colors.white,
        onPressed: () {
          if (widget.isMultipleSelect) {
            _onSelectComplete();
          } else {
            _onCancel();
          }
        },
      ),
    );
  }

  LWBottomSheetTitle? _getTitle() {
    return widget.title?.isNotEmpty == true
        ? LWBottomSheetTitle(
            title: widget.title,
            items: const [LWBottomSheetTitleItem.title, LWBottomSheetTitleItem.close],
          )
        : null;
  }

  @override
  Widget build(BuildContext context) {
    double bottom = MediaQuery.of(context).viewPadding.bottom;
    LWBottomSheetTitle? title = _getTitle();
    double height = widget.dataList.length * _itemHeight + _bottomHeight + bottom;
    if (title != null) {
      height += title.height;
    }
    if (height > LWBottomSheet.maxHeight(context)) {
      height -= _itemHeight * 0.5;
    }
    return SizedBox(
      height: height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          title ?? Container(),
          _getListView(widget.dataList),
          _getButton(),
          Container(
            color: Colors.white,
            height: bottom,
          )
        ],
      ),
    );
  }
}
