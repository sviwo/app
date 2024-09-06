class HttpProxy {
  HttpProxy._internal();

  /// 是否启用代理
  static bool enable = false;

  /// 代理服务IP
  static String host = '127.0.0.1';

  /// 代理服务端口
  static String port = '8888';
}
