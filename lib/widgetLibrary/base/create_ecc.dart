import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:pointycastle/export.dart';

// 假设你有一个未压缩的公钥字节数组（65字节长度）
List<int> uncompressedPublicKeyBytes =
    List.generate(65, (i) => i); // 这里替换为实际的公钥字节数组

// 解析公钥
ECPublicKey loadUncompressedPublicKey() {
  final curve = ECCurve_secp256k1();
  final bytes = Uint8List.fromList(uncompressedPublicKeyBytes);

  if (bytes[0] != 0x04) {
    throw ArgumentError('The provided key is not in the uncompressed format.');
  }

  final x = BigInt.parse(
      bytes.sublist(1, 33).map((e) => e.toRadixString(16)).join(),
      radix: 16);
  final y = BigInt.parse(
      bytes.sublist(33, 65).map((e) => e.toRadixString(16)).join(),
      radix: 16);

  return ECPublicKey(curve.curve.createPoint(x, y), curve);
}

void main() {
  final publicKey = loadUncompressedPublicKey();
  // 现在你可以使用publicKey进行进一步操作
}
