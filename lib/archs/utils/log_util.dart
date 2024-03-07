import 'dart:convert';
import 'dart:io';

class LogUtil {
  LogUtil._internal();

  static const _separator = "——";
  static const _split = "$_separator$_separator$_separator";
  static var _title = "flutter-log";
  static var _isDebug = true;
  static int _limitLength = 500;
  static String _startLine = "$_split$_title$_split";
  static String _endLine = "$_split$_separator$_separator$_separator$_split";

  static void init({required String title, required bool isDebug, int limitLength = 500}) {
    _title = title;
    _isDebug = isDebug;
    _limitLength = limitLength;
    var endLineStr = StringBuffer();
    var cnCharReg = RegExp("[\u4e00-\u9fa5]");
    for (int i = 0; i < _startLine.length; i++) {
      if (cnCharReg.stringMatch(_startLine[i]) != null) {
        endLineStr.write(_separator);
      }
      endLineStr.write(_separator);
    }
    _endLine = endLineStr.toString();
    var halfLine = _endLine.substring(0, (_endLine.length - _title.length - 2) ~/ 2);
    _startLine = "$halfLine $_title $halfLine";
  }

  //仅Debug模式可见
  static void d(dynamic obj) {
    if (_isDebug) {
      _log(obj.toString());
    }
  }

  static void dJson(dynamic obj) {
    if (_isDebug) {
      _log(jsonEncode(obj));
    }
  }

  static void v(dynamic obj) {
    if (_isDebug) {
      _log(obj.toString());
    }
  }

  static void _log(String msg) {
    // iOS不打印分隔符
    if (Platform.isIOS == false) {
      print(_startLine);
    }
    if (msg.length < _limitLength) {
      print(msg);
    } else {
      _segmentationLog(msg);
    }
    if (Platform.isIOS == false) {
      print(_endLine);
    }
  }

  static void _segmentationLog(String msg) {
    var outStr = StringBuffer();
    for (var index = 0; index < msg.length; index++) {
      outStr.write(msg[index]);
      if (index % _limitLength == 0 && index != 0) {
        print(outStr.toString());
        outStr.clear();
        var lastIndex = index + 1;
        if (msg.length - lastIndex < _limitLength) {
          var remainderStr = msg.substring(lastIndex, msg.length);
          print(remainderStr);
          break;
        }
      }
    }
  }
}
