import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

class DataExchangeUtils {
  /// bytes 转 HexString
  static int fourBytesToInt(List<int> bytes) {
    if (bytes.length < 4) {
      return 0;
    } else {
      return ((bytes[0] << 24) & 0xffffffff) |
          ((bytes[0] << 16) & 0xffffff) |
          ((bytes[0] << 8) & 0xffff) |
          ((bytes[0] << 0) & 0xff);
    }
  }

  /// bytes 转 HexString
  static String bytesToHex(List<int> bytes) {
    return bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
  }

  /// 16进制字符串转 bytes
  static List<int> hexStringToListInt(String hexString) {
    final RegExp pattern = RegExp(r'[0-9a-fA-F]{2}', caseSensitive: false);
    return hexString
        .split('')
        .where(pattern.hasMatch)
        .map((hex) => int.parse(hex, radix: 16))
        .toList();
  }

  /// byte数组转float
  static double bytesToFloat(List<int> bytes) {
    // 确保字节数组长度为4，因为一个float占4个字节
    assert(bytes.length == 4);

    // 使用ByteBuffer和ByteData进行字节操作
    ByteBuffer buffer = Uint8List.fromList(bytes).buffer;
    ByteData byteData = ByteData.view(buffer);

    // 根据系统字节序选择合适的读取方式
    if (Endian.host == Endian.big) {
      return byteData.getFloat32(0, Endian.little);
    } else {
      return byteData.getFloat32(0, Endian.host);
    }
  }

  /// 两个字节转int
  static int twoByteToInt(int a, int b) {
    return ((a << 8) & 0xffff) | (b & 0xff);
  }

  /// 4个字节转int
  static int fourByteToInt(int a, int b, int c, int d) {
    return ((a << 24) & 0xffffffff) |
        ((b << 16) & 0xffffff) |
        ((c << 8) & 0xffff) |
        (d & 0xff);
  }

  /// 4个字节转int
  static int fourByteListToInt(List<int> list) {
    assert(list.length == 4);
    return ((list[0] << 24) & 0xffffffff) |
        ((list[1] << 16) & 0xffffff) |
        ((list[2] << 8) & 0xffff) |
        (list[3] & 0xff);
  }

  /// byte转字符串
  static String byteToString(List<int> list) {
    if (list.isEmpty) {
      return "";
    }
    return utf8.decode(list);
  }

  /// string 转byte
  static List<int> stringToByte(String string) {
    return utf8.encode(string);
  }
}
