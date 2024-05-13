import 'dart:typed_data';

class DataExchangeUtils {
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
}
