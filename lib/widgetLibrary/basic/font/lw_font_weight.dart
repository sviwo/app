import 'dart:io';
import 'dart:ui';

class LWFontWeight {
  LWFontWeight._internal();

  static FontWeight normal = FontWeight.normal;
  static FontWeight bold = Platform.isIOS ? FontWeight.w600 : FontWeight.bold;
}
