
import 'package:flutter/material.dart';
import '../../utils/size_util.dart';

import '../../basic/colors/lw_colors.dart';
import '../../basic/font/lw_font_weight.dart';
import '../../lw_widget.dart';

class LWProgress {
  static BuildContext? _context;
  static var _progress = 0.0;
  static StateSetter? _progressState;

  static show(context) {
    showDialog(
      context: context,
      builder: (context) {
        _context = context;
        return _dialog(context);
      },
      // barrierDismissible: false,
    );
  }

  static dismiss() {
    if (_context != null) {
      Navigator.of(_context!).pop();
      _context = null;
      _progress = 0.0;
      _progressState = null;
    }
  }

  static update(int progress) {
    _progress = progress / 100.0;
    _progressState?.call(() {});
  }

  static _dialog(context) {
    return UnconstrainedBox(
      child: SizedBox(
        width: 180.dp,
        height: 140.dp,
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.dp))),
          contentPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.zero,
          // clipBehavior: Clip.antiAliasWithSaveLayer,
          content: Stack(
            alignment: Alignment.center,
            children: [
              LWWidget.assetSvg('ic_dialog_progress.svg', width: 180.dp),
              SizedBox(
                width: 180.dp,
                height: 140.dp,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        StatefulBuilder(builder: (context, state) {
                          _progressState = state;
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 48.dp,
                                height: 48.dp,
                                child: CircularProgressIndicator(
                                  strokeWidth: 5.dp,
                                  backgroundColor: LWColors.gray6,
                                  valueColor: AlwaysStoppedAnimation(LWColors.theme),
                                  value: _progress,
                                ),
                              ),
                              Text(
                                '${(_progress * 100).toInt()}%',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12.sp, fontWeight: LWFontWeight.bold, color: LWColors.gray1),
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                    SizedBox(height: 10.dp),
                    Text('下载中...', style: TextStyle(fontSize: 12.sp, color: LWColors.gray1)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
