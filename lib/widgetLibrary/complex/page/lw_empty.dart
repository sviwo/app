import 'package:atv/generated/locale_keys.g.dart';
import 'package:atv/widgetLibrary/utils/size_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../basic/button/lw_button.dart';
import '../../basic/colors/lw_colors.dart';
import '../../lw_widget.dart';

enum LWEmptyType { notData, netAnomaly, loadFailed }

class LWEmpty extends StatelessWidget {
  const LWEmpty({
    Key? key,
    this.padding,
    this.emptyTips,
    this.emptyType = LWEmptyType.notData,
    this.emptyImage,
    this.actionText,
    this.actionCustom,
    this.onTapAction,
  }) : super(key: key);

  final LWEmptyType emptyType;
  final Widget? emptyImage;

  /// 默认值 notData：无数据 netAnomaly：网络异常 loadFailed：加载失败
  final String? emptyTips;

  /// 内边距，默认为null
  final EdgeInsetsGeometry? padding;

  /// 按钮文字，null不显示按钮
  final String? actionText;
  final Function()? onTapAction;

  /// 自定义的按钮，可以为任意的widget，而且点击事件完全由外部实现
  final Widget? actionCustom;

  _getText() {
    String _text = LocaleKeys.no_data_tips.tr();
    if (emptyType == LWEmptyType.loadFailed) {
      _text = LocaleKeys.load_fail_tips.tr();
    } else if (emptyType == LWEmptyType.netAnomaly) {
      _text = LocaleKeys.server_exception.tr();
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Text(
        emptyTips ?? _text,
        textAlign: TextAlign.center,
        maxLines: 2,
        style: const TextStyle(
            fontSize: 12,
            color: LWColors.gray4,
            overflow: TextOverflow.ellipsis),
      ),
    );
  }

  _getImage() {
    if (emptyType == LWEmptyType.loadFailed) {
      // return Icon(
      //   Icons.error_outline_sharp,
      //   size: 200.dp,
      //   color: Colors.white,
      // );
      return LWWidget.assetSvg(
        'ic_empty_load_failed.svg',
        width: 220,
        height: 220,
      );
    } else if (emptyType == LWEmptyType.netAnomaly) {
      // return Icon(
      //   Icons.forward_to_inbox_sharp,
      //   size: 200.dp,
      //   color: Colors.white,
      // );
      return LWWidget.assetSvg(
        'ic_empty_network_anomaly.svg',
        width: 220,
        height: 220,
      );
    }
    // return Icon(
    //   Icons.no_adult_content,
    //   size: 200.dp,
    //   color: Colors.white,
    // );
    return LWWidget.assetSvg(
      'ic_empty_not_data.svg',
      width: 220,
      height: 220,
    );
  }

  _getButton() {
    if (actionCustom != null) {
      return actionCustom;
    }
    return actionText == null
        ? Container()
        : LWButton.custom(
            text: actionText,
            minHeight: 26,
            minWidth: 64,
            backgroundColor: LWColors.gray6,
            textColor: LWColors.gray2,
            textSize: 12,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            onPressed: onTapAction,
          );
  }

  @override
  Widget build(BuildContext context) {
    Widget image;
    if (emptyImage != null) {
      image = SizedBox(width: 220, child: emptyImage);
    } else {
      image = _getImage();
    }
    return Container(
      color: Colors.transparent,
      padding: padding,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            image,
            Visibility(
              visible: emptyTips != '',
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  _getText(),
                ],
              ),
            ),
            const SizedBox(height: 10),
            _getButton(),
          ],
        ),
      ),
    );
  }
}
