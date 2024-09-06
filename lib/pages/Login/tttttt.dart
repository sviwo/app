import 'dart:async';
import 'dart:isolate';

String _data = '0';

void main() async {
  ReceivePort port = ReceivePort();

  var iso = await Isolate.spawn(aaa, port.sendPort);
  port.listen((message) {
    print('消息来咯 $message');
    print(a);
    port.close();
    iso.kill();
  });
}

int a = 10;
aaa(SendPort send) {
  a = 100;
  send.send(a);
}

getData() async {
  return Future(() {
    print('开始 data = $_data');
    for (var i = 0; i < 200000; i++) {
      _data = '网络数据';
    }
    print('结束 data = $_data');
  }).then((value) => null);
}
