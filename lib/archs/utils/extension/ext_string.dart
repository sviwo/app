extension StringExtension on String? {
  ///判断为null或''
  bool isNullOrEmpty() => this?.isNotEmpty != true;

  ///如果为null，返回''
  String orEmpty() => this ?? '';

  ///如果为null或''，执行函数
  dynamic ifEmpty(dynamic Function(String? e) defaultValue) {
    return this?.isEmpty == true ? defaultValue.call(this) : this;
  }

  ///如果为null或''，返回指定值
  String placeholder({String defaultValue = '-'}) => this?.isNotEmpty != true ? defaultValue : this!;
}
