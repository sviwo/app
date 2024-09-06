
extension XCString on String {
  ///手机号验证
  bool isMobilePhone() {
    return RegExp(r"^1\d{10}$").hasMatch(this);
  }

  ///邮箱验证
  bool isEmail() {
    return RegExp(r"^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$")
        .hasMatch(this);
  }

  ///验证URL
  bool isUrl() {
    return RegExp(r"^((https|http|ftp|rtsp|mms)?:\/\/)[^\s]+").hasMatch(this);
  }

  ///验证身份证
  bool isIdCard() {
    return RegExp(r"\d{17}[\d|x]|\d{15}").hasMatch(this);
  }

  ///验证中文
  bool isChinese() {
    return RegExp(r"[\u4e00-\u9fa5]").hasMatch(this);
  }

  ///整数、浮点数通用校验
  bool numberCheck({
    // 整数位数
    int integerLength = 8,
    // 小数位数，小于等于0不能输入小数
    int decimalLength = 2,
    // 允许负数
    bool allowNegative = false,
  }) {
    assert(integerLength > 0, "整数位数必须大于0");
    String decimalExp =
        decimalLength > 0 ? '(\\.([0-9]){0,$decimalLength})?' : '';
    String negativeExp = allowNegative ? '(-)?' : '';
    String s =
        '^$negativeExp((0$decimalExp)|([1-9]([0-9]){0,${integerLength - 1}}$decimalExp))?\$';

    return RegExp(s).hasMatch(this);
  }

  ///邮箱输入合法性校验
  bool emailInputCheck() {
    return RegExp("^((\\w+@?)|(\\w+@\\w+(\\.)?(\\w+)?)?)?\$").hasMatch(this);
  }

  ///手机号输入合法性校验
  bool mobilePhoneInputCheck() {
    return RegExp('^(1([0-9]){0,10})\$').hasMatch(this);
  }
}
