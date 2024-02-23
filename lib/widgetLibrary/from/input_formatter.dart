
import 'package:flutter/services.dart';
import '../../widgetLibrary/extension/string.dart';

enum InputFormatterType { number, email, phone }

class InputFormatter extends TextInputFormatter {
  InputFormatter.number({
    /// 整数位数
    this.integerLength = 8,
    /// 小数位数
    this.decimalLength = 2,
    /// 允许负数
    this.allowNegative = false
  })  : type = InputFormatterType.number,
        super();

  InputFormatter.email()
      : type = InputFormatterType.email,
        super();

  InputFormatter.phone()
      : type = InputFormatterType.phone,
        super();

  late final int integerLength;
  late final int decimalLength;
  /// 允许负数
  late final bool allowNegative;

  late final InputFormatterType type;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    print(newValue.text);
    // print(RegExp("^((\\w+@?)|(\\w+@\\w+(\\.)?(\\w+)?)?)?\$")
    //     .hasMatch(newValue.text));
    // return newValue;

    if (type == InputFormatterType.number) {
      return newValue.text.numberCheck(
              integerLength: integerLength, decimalLength: decimalLength, allowNegative: allowNegative)
          ? newValue
          : oldValue;
    } else if (type == InputFormatterType.email) {
      return newValue.text.emailInputCheck() ? newValue : oldValue;
    } else if (type == InputFormatterType.phone) {
      return newValue.text.mobilePhoneInputCheck() ? newValue : oldValue;
    }

    return newValue;
  }
}
