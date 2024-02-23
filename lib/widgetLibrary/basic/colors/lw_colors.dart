import '../../lw_widget.dart';
import 'package:flutter/material.dart';

class LWColors {
  LWColors._();

  // MARK: ----------------------------------------------- 主色
  // 色阶取色规则
  // 以#E60044为基准，白色叠加以20%递减增加色阶：20%、40%、60%、80%

  /// 主题色，供会因为主题改变而改变的控件使用
  static Color get theme => LWWidget.themeColor;

  /// 0xFFE60044 品牌颜色，也就是新潮红
  static const Color brand = Color(0xFFE60044);

  /// 主渐变色结束);
  static const Color themeGradientEnd = Color(0xFFFF4747);

  // MARK: ----------------------------------------------- 中性色
  // 中性色色阶取色规则
  // 以#333333为基准，白色叠加以20%递减增加色阶，20%、40%、60%、80%

  /// 0xFF333333 重要文字、页面标题、模块标题、正文、tab选中状态等
  // ignore: use_full_hex_values_for_flutter_colors
  static Color gray1 = const Color(0xFF333333);

  /// 0xFF5B5B5B 常规文字、列表标题等
  static const Color gray2 = Color(0xFF5B5B5B);

  /// 0xFF848484 次级文字、次级标题、未选中菜单文字等
  static const Color gray3 = Color(0xFF848484);

  /// 0xFFB5B5B5 次次级文字、轻量提示性文字、文本域和搜索框预置文字、开关、小i图标等
  static const Color gray4 = Color(0xFFB5B5B5);

  /// 0xFFD2D2D2 辅助文字信息、列表输入框预置文字、失效文字、线框按钮、箭头、步骤条颜色等
  static const Color gray5 = Color(0xFFD2D2D2);

  /// 0xFFEEEEEE 分割线、边框、辅助按钮颜色等
  static const Color gray6 = Color(0xFFEEEEEE);

  /// 0xFFF4F4F4 页面背景
  static const Color gray7 = Color(0xFFF4F4F4);

  /// 0xFFF8F8F8 通用背景、表头、标签、搜索框背景等
  static const Color gray8 = Color(0xFFF8F8F8);

  /// 0xFFFAFAFA 通用背景、分割模块背景、文本域背景等
  static const Color gray9 = Color(0xFFFAFAFA);

// MARK: ----------------------------------------------- 释义色
// 释义颜色常用于成功、警告、失败等

  /// 0xFF7BCC52 成功
  static const Color success = Color(0xFF7BCC52);

  /// 0xFFF7B620 警告
  static const Color warning = Color(0xFFF7B620);

  /// 0xFFED3737 失败
  static const Color fail = Color(0xFFED3737);

// MARK: ----------------------------------------------- 文字标签
// 用于列表详情里面的状态说明

  /// 0xFF1880F1 草稿、流程中未开始流转的状态
  static const Color draft = Color(0xFF1880F1);

  /// 0xFFFD6F00 进行中 待..、..中、流程中还未完成的操作状态
  static const Color ongoing = Color(0xFFFD6F00);

  /// 0xFF6FCC0A 已通过 完成、通过、有效、归档等最终结果
  static const Color past = Color(0xFF6FCC0A);

  /// 0xFFF2270B 不通过 驳回、拒绝、未通过、异常等最终结果
  static const Color pass = Color(0xFFF2270B);

  /// 0xFF9D9D9D 失效状态 过期、关闭、失效、作废、取消、无效、
  static const Color invalid = Color(0xFF9D9D9D);

// MARK: ----------------------------------------------- 辅助色
  /// 0xFFFF7C12 辅助文字颜色、需要强调和突出的文字、icon等
  static const Color orange = Color(0xFFFF7C12);

  /// 0xFF397FF8 辅助文字颜色、文字链、文字按钮等
  static const Color blue = Color(0xFF397FF8);
}

// 色阶扩展
// 以#E60044为基准，白色叠加以20%递减增加色阶：20%、40%、60%、80%
extension LWColorsExt on Color {
  Color get opacity6 => withOpacity(0.06);

  Color get opacity20 => withOpacity(0.2);

  Color get opacity40 => withOpacity(0.4);

  Color get opacity60 => withOpacity(0.6);

  Color get opacity80 => withOpacity(0.8);
}
