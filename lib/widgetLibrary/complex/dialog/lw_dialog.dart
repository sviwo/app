
import 'package:flutter/material.dart';
import 'package:atv/widgetLibrary/utils/size_util.dart';

import '../../basic/button/lw_button.dart';
import '../../basic/colors/lw_colors.dart';
import '../../basic/font/lw_font_weight.dart';
import '../../basic/lw_click.dart';
import '../../lw_widget.dart';

enum DialogAction { cancel, confirm }

class LWDialog extends StatelessWidget {
  const LWDialog({Key? key}) : super(key: key);

  /// 消息框
  static message(
    BuildContext context, {
    String? message,
    TextAlign? messageAlign,
    bool withEmotion = false,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: _buildMessageContent(context, message, withEmotion, messageAlign: messageAlign),
          contentPadding: EdgeInsets.zero,
          shape: _shapeBorder(),
        );
      },
      barrierDismissible: false,
    );
  }

  /// 提示框
  static prompt(
    BuildContext context, {
    Widget? icon,
    String? title,
    String? message,
    double? messageSize,
    Color? messageColor,
    TextAlign? messageAlign,
    String? confirmButtonText,
    bool withEmotion = false,
    Function()? callback,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: _buildContent(context, icon, title, message, withEmotion,
              messageSize: messageSize, messageColor: messageColor, messageAlign: messageAlign),
          contentPadding: EdgeInsets.zero,
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actionsPadding: EdgeInsets.zero,
          actions: <Widget>[
            Row(
              children: [
                Expanded(
                  child: _buildConfirmButton(context, confirmButtonText, callback: (action) {
                    callback?.call();
                    return true;
                  }),
                ),
              ],
            )
          ],
          shape: _shapeBorder(),
          scrollable: true,
        );
      },
      barrierDismissible: false,
    );
  }

  /// 确认框
  static confirm(
    BuildContext context, {
    Widget? icon,
    String? title,
    Widget? child,
    String? message,
    double? messageSize,
    Color? messageColor,
    TextAlign? messageAlign,
    String? cancelButtonText,
    String? confirmButtonText,
    bool Function(DialogAction)? callback,
    bool withEmotion = false,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content:
              _buildContent(context, icon, title, message, withEmotion, messageSize: messageSize, messageColor: messageColor, messageAlign: messageAlign, messageCustom: child),
          contentPadding: EdgeInsets.zero,
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actionsPadding: EdgeInsets.zero,
          actions: <Widget>[
            Row(
              children: [
                Expanded(
                  child: _buildCancelButton(context, cancelButtonText, callback: callback),
                ),
                Expanded(
                  child: _buildConfirmButton(context, confirmButtonText, callback: callback),
                ),
              ],
            )
          ],
          shape: _shapeBorder(),
          scrollable: true,
        );
      },
      barrierDismissible: false,
    );
  }

  /// 自定义
  static custom(
    BuildContext context, {
    Widget? icon,
    String? title,
    Widget? child,
    String? cancelButtonText,
    String? confirmButtonText,
    bool Function(DialogAction)? callback,
    bool withEmotion = false,
    bool showClose = false,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: _buildContent(context, icon, title, null, withEmotion, messageCustom: child, showClose: showClose),
          contentPadding: EdgeInsets.zero,
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actionsPadding: EdgeInsets.zero,
          actions: <Widget>[
            Row(
              children: [
                Visibility(
                  visible: cancelButtonText != null,
                  child: Expanded(
                    child: _buildCancelButton(context, cancelButtonText, callback: callback),
                  ),
                ),
                Visibility(
                  visible: confirmButtonText != null,
                  child: Expanded(
                    child: _buildConfirmButton(context, confirmButtonText, callback: callback),
                  ),
                ),
              ],
            )
          ],
          shape: _shapeBorder(),
          scrollable: true,
        );
      },
      barrierDismissible: false,
    );
  }

  static Widget? _buildClose(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        LWClick.onClick(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: EdgeInsets.all(10.dp),
            child: LWWidget.assetSvg('ic_dialog_close.svg', width: 20.dp, height: 20.dp),
          ),
        )
      ],
    );
  }

  static Widget? _buildTitle(String? title) {
    if (title == null) {
      return null;
    }
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18.sp, fontWeight: LWFontWeight.bold, color: LWColors.gray1),
    );
  }

  static Widget? _buildMessage(BuildContext context, String? message, bool hasTitle,
      {double? messageSize, Color? messageColor, TextAlign? messageAlign}) {
    if (message == null) {
      return null;
    }
    // 无标题时，限制最小高度为 60（上下 padding 分别 20，加起来就是 100）
    return Container(
      constraints: BoxConstraints(
        minHeight: hasTitle ? 0 : 60.dp,
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                message,
                textAlign: messageAlign ?? TextAlign.center,
                style: TextStyle(fontSize: messageSize ?? 14.sp, color: messageColor ?? LWColors.gray3),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget? _buildMessageContent(
    BuildContext context,
    String? message,
    bool withEmotion, {
    TextAlign? messageAlign,
  }) {
    return Stack(
      children: [
        Visibility(
          visible: withEmotion == true,
          child: Positioned(
            right: 0,
            top: 0,
            child: LWWidget.assetSvg('ic_dialog_emotion.svg', width: 75.dp, height: 70.dp),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.dp),
              child: _buildClose(context),
            ),
            Visibility(
              visible: message != null,
              child: Padding(
                padding: EdgeInsets.only(left: 20.dp, right: 20.dp, bottom: 20.dp),
                child: _buildMessage(context, message, false, messageAlign: messageAlign),
              ),
            ),
          ],
        ),
      ],
    );
  }

  static Widget? _buildContent(BuildContext context, Widget? icon, String? title, String? message, bool withEmotion,
      {double? messageSize,
      Color? messageColor,
      TextAlign? messageAlign,
      Widget? messageCustom,
      bool showClose = false}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.dp),
      child: Stack(
        children: [
          Visibility(
            visible: withEmotion == true,
            child: Positioned(
              right: 0,
              top: 0,
              child: LWWidget.assetSvg('ic_dialog_emotion.svg', width: 75.dp, height: 70.dp),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: icon != null,
                child: Padding(padding: EdgeInsets.only(top: 32.dp), child: icon),
              ),
              Visibility(
                visible: title != null,
                child: Padding(
                  padding: EdgeInsets.only(top: 20.dp, left: 20.dp, right: 20.dp),
                  child: _buildTitle(title),
                ),
              ),
              Visibility(
                visible: message != null && messageCustom == null,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.dp, vertical: 20.dp),
                  child: _buildMessage(context, message, icon != null || title != null,
                      messageSize: messageSize, messageColor: messageColor, messageAlign: messageAlign),
                ),
              ),
              Visibility(
                visible: messageCustom != null,
                child: messageCustom ?? Container(),
              ),
            ],
          ),
          Visibility(
            visible: showClose,
            child: Positioned(
              right: 0,
              top: 0,
              child: _buildClose(context) ?? Container(),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildCancelButton(BuildContext context, String? text, {bool Function(DialogAction)? callback}) {
    return Column(
      children: [
        const Divider(height: 1, color: LWColors.gray6),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: LWButton.text(
                text: text ?? "辅助操作",
                textSize: 16.sp,
                textColor: LWColors.gray1,
                minHeight: 50.dp,
                onPressed: () {
                  bool result = callback?.call(DialogAction.cancel) ?? true;
                  if (result == true) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
            Container(
              width: 0.5,
              height: 50.dp,
              color: LWColors.gray6,
            ),
          ],
        ),
      ],
    );
  }

  static Widget _buildConfirmButton(BuildContext context, String? text, {bool Function(DialogAction)? callback}) {
    return Column(
      children: [
        const Divider(height: 1, color: LWColors.gray6),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: LWButton.text(
                text: text ?? "主要操作",
                textSize: 16.sp,
                textColor: LWColors.theme,
                minHeight: 50.dp,
                onPressed: () {
                  bool result = callback?.call(DialogAction.confirm) ?? true;
                  if (result == true) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  static ShapeBorder _shapeBorder() {
    return RoundedRectangleBorder(
      side: const BorderSide(color: Colors.white, width: 1, style: BorderStyle.solid),
      borderRadius: BorderRadius.all(Radius.circular(10.dp)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
