
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgetLibrary/utils/size_util.dart';
import '../basic/colors/lw_colors.dart';
import '../basic/lw_click.dart';
import '../lw_widget.dart';

/// 表单基类/可自定义扩展类
/// 样式结构
///   | pre |-----title------|--child-right---| suf |
///   | fix |----------child-bottom-----------| fix |
///
///   该布局从左到右分为，prefix区、content区、suffix区
///   1）content区，包含title和child
///     a）child-right，horizontal布局的child
///     b）child-bottom，vertical布局的child
///   2）prefix区，可以用于放置图标等Widget
///   3）suffix区，可以用于放置箭头等Widget
///
class LWForm extends StatefulWidget {
  LWForm({
    Key? key,
    ///必传：左上角标题
    required this.title,
    ///不必传：文字字号
    this.titleSize,
    this.valueSize,
    ///不必传：右边或底部部件
    this.child,
    ///不必传：是否必选 *
    this.required,
    ///不必传：有回调表示显示图标
    this.onTapTips,
    ///不必传：部件宽度
    this.width,
    ///不必传：部件高度
    this.height,
    ///不必传：组件内边距 默认：横向 12 纵向 16
    this.padding,
    ///不必传：控制背景样式
    this.constraints,
    ///不必传：背景颜色
    this.backgroundColor,
    ///不必传：纵向/横向布局  Axis.vertical  Axis.horizontal
    this.direction,
    ///不必传：是否动态分割title与value的空间比例
    this.dynamicSeparate = true,
  }) : super(key: key);

  LWForm.vertical({
    ///必传：左上角标题
    required String title,
    ///不必传：文字字号
    double? titleSize,
    double? valueSize,
    ///必传：右边部件
    required Widget child,
    ///不必传：是否必选 *
    bool? required,
    ///不必传：组件内边距 默认：横向 12 纵向 16
    EdgeInsets? padding,
    ///不必传：有回调表示显示图标
    Function()? onTapTips,
    ///不必传：是否动态分割title与value的空间比例
    bool dynamicSeparate = true,
  }) : this(
            title: title,
            required: required,
            child: child,
            titleSize: titleSize,
            valueSize: valueSize,
            onTapTips: onTapTips,
            padding: padding,
            direction: Axis.vertical,
            dynamicSeparate: dynamicSeparate);

  LWForm.horizontal({
    ///必传：左上角标题
    required String title,
    ///不必传：文字字号
    double? titleSize,
    double? valueSize,
    ///必传：底部部件
    required Widget child,
    ///不必传：是否必选 *
    bool? required,
    ///不必传：组件内边距 默认：横向 12 纵向 16
    EdgeInsets? padding,
    ///不必传：有回调表示显示图标
    Function()? onTapTips,
    ///不必传：是否动态分割title与value的空间比例
    bool dynamicSeparate = true,
  }) : this(
            title: title,
            required: required,
            child: child,
            titleSize: titleSize,
            valueSize: valueSize,
            onTapTips: onTapTips,
            padding: padding,
            direction: Axis.horizontal,
            dynamicSeparate: dynamicSeparate);

  String title;
  double? titleSize;
  double? valueSize;

  Widget? child;
  bool? required; // 是否必填
  Function()? onTapTips;
  double? width;
  double? height;
  EdgeInsets? padding;
  BoxConstraints? constraints;
  Color? backgroundColor;
  bool dynamicSeparate = true;

  Axis? direction; // 布局方向

  @override
  State<StatefulWidget> createState() => LWFormState();
}

class LWFormState<T extends LWForm> extends State<T> {
  @override
  void initState() {
    super.initState();
    widget.direction ??= Axis.horizontal;
  }

  /// 组件分区-prefix区
  Widget? buildPrefix() => null;

  /// 组件分区-suffix区
  Widget? buildSuffix() => null;

  /// 组件分区-childRight
  Widget? buildChildRight() => null;

  /// 组件分区-childBottom
  Widget? buildChildBottom() => null;

  @override
  Widget build(BuildContext context) {
    print('xxx, padding=${widget.padding != null}');
    return Container(
      color: widget.backgroundColor,
      width: widget.width,
      height: widget.height,
      constraints: widget.constraints,
      padding: widget.padding ?? EdgeInsets.only(left: 12.dp, top: 16.dp, right: 12.dp, bottom: 16.dp),
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildPrefix() ?? Container(),
          Expanded(
            flex: 1,
            child: _buildCenter(),
          ),
          buildSuffix() ?? Container(),
        ],
      ),
    );
  }

  Widget _buildCenter() {
    if (widget.child != null) {
      if (widget.direction == Axis.vertical) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            SizedBox(height: 12.dp),
            widget.child!,
          ],
        );
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            widget.dynamicSeparate ? _buildTitle() : Expanded(child: _buildTitle()),
            SizedBox(width: 24.dp),
            Expanded(child: Align(child: widget.child!, alignment: Alignment.centerRight)),
          ],
        );
      }
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.dynamicSeparate ? _buildTitle() : Expanded(child: _buildTitle()),
              SizedBox(width: 24.dp),
              Expanded(child: buildChildRight()!),
            ],
          ),
          widget.direction == Axis.vertical ? buildChildBottom()! : Container(),
        ],
      );
    }
  }

  /// 标题区
  Widget _buildTitle() {
    List<InlineSpan> children = [];
    children.add(TextSpan(
      text: widget.title,
      style: TextStyle(fontSize: widget.titleSize ?? 14.sp, color: LWColors.gray2, height: 1.43),
    ));
    if (widget.required == true) {
      children.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Text(' *', style: TextStyle(fontSize: widget.titleSize ?? 14.sp, color: LWColors.brand)),
        ),
      );
    }
    if (widget.onTapTips != null) {
      children.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: LWClick.onClick(
            onTap: widget.onTapTips,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: LWWidget.assetSvg('ic_form_tips.svg', height: 14.dp, width: 14.dp),
            ),
          ),
        ),
      );
    }
    return Text.rich(
      TextSpan(children: children),
      maxLines: widget.direction == Axis.vertical ? 1 : 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
