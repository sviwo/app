import 'dart:convert';
import 'dart:typed_data';
import 'package:crypton/crypton.dart';
import 'package:pointycastle/asn1/asn1_parser.dart';
import 'package:pointycastle/asn1/primitives/asn1_sequence.dart';

import 'package:basic_utils/basic_utils.dart';

ecdsa() {
  final eckeypair = ECKeypair.fromRandom();
  var message =
      utf8.encode(DateTime.now().millisecondsSinceEpoch.toRadixString(16));
  final privateKeyString = eckeypair.privateKey.toString();
  final publicKeyString = eckeypair.publicKey.toString();
  final signature =
      eckeypair.privateKey.createSHA256Signature(message as Uint8List);
  final verified =
      eckeypair.privateKey.publicKey.verifySHA256Signature(message, signature);
  print('Your Private Key\n $privateKeyString\n---');
  print('Your Public Key\n $publicKeyString\n---');
  var ttt = base64Decode(publicKeyString);
  print(ttt);
  if (verified) {
    print('The Signature is verified!');
  } else {
    print('The Signature could not be verified!');
  }
}

main() {
  // ecdsa();
  // var ttt = base64Decode('MTIzMTQ1NjExMzIyMDUxMzEyMzE=');
  // print(ttt);
  final pem =
      'MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAElJ+LbZBekYTu/Md4T/j3DJsmJFf/3wLLmfUR7sLXCzS1PsDpHIC0QXRdVVdzS9BmP5GdtpesR4Oeh7g0TBBoLA==';
  // var lines = LineSplitter.split(x509Key)
  //     .map((line) => line.trim())
  //     .where((line) => line.isNotEmpty)
  //     .toList();
  // var base64 = lines.sublist(1, lines.length - 1).join('');
  // var bytes = Uint8List.fromList(base64Decode(base64));
  // print(lines);
  // print('-------------------------');
  // print(base64);
//   print('-------------------------');
//   print(bytes);
// }

//   var pem = '''-----BEGIN CERTIFICATE-----
// MIIGuDCCBaCgAwIBAgIQJWoxbMUUPa7apOL527blFzANBgkqhkiG9w0BAQsFADCB
// sDELMAkGA1UEBhMCVVMxHTAbBgNVBAoTFFN5bWFudGVjIENvcnBvcmF0aW9uMR8w
// HQYDVQQLExZGT1IgVEVTVCBQVVJQT1NFUyBPTkxZMR8wHQYDVQQLExZTeW1hbnRl
// YyBUcnVzdCBOZXR3b3JrMUAwPgYDVQQDEzdTeW1hbnRlYyBDbGFzcyAzIEV4dGVu
// ZGVkIFZhbGlkYXRpb24gU0hBMjU2IFNTTCBURVNUIENBMB4XDTE2MTExODAwMDAw
// MFoXDTE2MTEyNTIzNTk1OVowge8xEzARBgsrBgEEAYI3PAIBAxMCREUxFzAVBgsr
// BgEEAYI3PAIBAhMGQmF5ZXJuMRswGQYLKwYBBAGCNzwCAQETClJlZ2Vuc2J1cmcx
// HTAbBgNVBA8TFFByaXZhdGUgT3JnYW5pemF0aW9uMRAwDgYDVQQFEwczNDY2NTY1
// MQswCQYDVQQGEwJERTENMAsGA1UECAwESGllcjETMBEGA1UEBwwKVGVzdGhhdXNl
// bjESMBAGA1UECgwJVGVzdGZpcm1hMRQwEgYDVQQLDAtFbnR3aWNrbHVuZzEWMBQG
// A1UEAwwNZXBoZW5vZHJvbS5kZTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
// ggEBALHYKBMxalQNBwqQVS/NE/Y5eTBORjxqY7jC/vZ881G4uMM+AFvt5iFKabjN
// wLT9itYFuJ/k5o7kVn93f0eirxrP0e3wPkzwELJIR6AdZo1EsTzGPW0p41PGOjGv
// /GPZwFWEfb7C0Wz4v3b3LtBrWYNJ12RswQAtKdNey/1nxZT2UwGdwESBK0Rvh3qt
// 33Wqkf1t8X627XTD91dkB/brq6oO3m2ZDyhbqDfMiWqUWl2CVnO0A+eFZ5uFFVdm
// NPFuhNqgCmZ6TfFkQJQEKuBadHDTj47qjU27lTJjksCHVDs9PzJzkH49zStjk9D4
// UkPw7y37xJ/gUK27VhkIC6QBTuECAwEAAaOCAoswggKHMCsGA1UdEQQkMCKCDWVw
// aGVub2Ryb20uZGWCEXd3dy5lcGhlbm9kcm9tLmRlMAkGA1UdEwQCMAAwDgYDVR0P
// AQH/BAQDAgWgMG8GA1UdIARoMGYwWwYLYIZIAYb4RQEHFwYwTDAjBggrBgEFBQcC
// ARYXaHR0cHM6Ly9kLnN5bWNiLmNvbS9jcHMwJQYIKwYBBQUHAgIwGQwXaHR0cHM6
// Ly9kLnN5bWNiLmNvbS9ycGEwBwYFZ4EMAQEwKwYDVR0fBCQwIjAgoB6gHIYaaHR0
// cDovL3NoLnN5bWNiLmNvbS9zaC5jcmwwHQYDVR0lBBYwFAYIKwYBBQUHAwEGCCsG
// AQUFBwMCMB8GA1UdIwQYMBaAFERiHdf3UpjAQwNcU+bmv+ZDJ+tjMFcGCCsGAQUF
// BwEBBEswSTAfBggrBgEFBQcwAYYTaHR0cDovL3NoLnN5bWNkLmNvbTAmBggrBgEF
// BQcwAoYaaHR0cDovL3NoLnN5bWNiLmNvbS9zaC5jcnQwggEEBgorBgEEAdZ5AgQC
// BIH1BIHyAPAAdgAR0wud4RKWE7VpXG+auxQlNw9ew3QWYeKO2GKv4jEwuQAAAVh3
// IQXYAAAEAwBHMEUCIAWDOM8fYWHm95CEg8eDf85KvCVzPbTKm2ZcS/7Dx5w7AiEA
// k/4u83CLUFizih+iJevMVXPHI99yeb6NT0lQnIZ8MFMAdgCRLn+OXTXy73s/VluY
// uYC5VyaVUxTiFkYL1+xTql7swQAAAVh3IQXYAAAEAwBHMEUCIHQR9Geg7t98Gk2t
// BSPlHIHDFG+XP5UUKa2eUahE973oAiEA6i8/T8IlppNUXcrMbcjjLLPsaSqd158U
// BC44Pr90Nw4wDQYJKoZIhvcNAQELBQADggEBACJqJMVEKtBfmB0mvhFtd5GV7818
// G/THYsf1AtMuCt80Rtzm+EXAyBupIhRERa+/J40pAE/ZyhmS5lSOjTzViR1RsIUg
// bo190CLpEvKHA7ckBssJRySMFQ6RSPavsOkpHvduCqVS2PSb9W1APFzDJPeC9gaM
// /EKIy7iLp2fiBZrYkTCaxYEy0SZGaFkXeHC20/d5PXhnylEXEIPR2aogIlbgzaNg
// RVTxIJddHhpHfW5c2lX+ERf3Ni0fcJqcCZBPyGHUDSYqNrDwRLQ6dyVxz1Jl0oAc
// +IHuDDDKJ0ewjoXgV+KRXqa7URuonqA5stUl/susZzd4BlT2k/XnuS8+iQc=
// -----END CERTIFICATE-----''';

  var lines = LineSplitter.split(pem)
      .map((line) => line.trim())
      .where((line) => line.isNotEmpty)
      .toList();
  print(lines);

  var base64 = lines.sublist(0, lines.length).join('');
  print('---' + base64);
  var bytes = Uint8List.fromList(base64Decode(base64));
  print('-------------------------');
  print(bytes);
  var publicKey = CryptoUtils.ecPublicKeyFromDerBytes(bytes);

  

  // var publicKey = CryptoUtils.ecPublicKeyFromPem(pem);
  print('-------------------------');
  print(publicKey.hashCode);
}
