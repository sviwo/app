/// 数据错误
class DataErrorException implements Exception {
  final String? message;
  final String code;

  DataErrorException({this.code = '-1', this.message});
}
