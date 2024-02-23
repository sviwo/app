import 'package:flutter/material.dart';

class StateCounterWidget extends StatefulWidget {
  const StateCounterWidget({Key? key, this.initValue = 0});

  final int initValue;

  @override
  _StateCounterWidgetState createState() => _StateCounterWidgetState();
}

class _StateCounterWidgetState extends State<StateCounterWidget> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    //初始化状态
    _counter = widget.initValue;
    print("initState");
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text('$_counter'),
          //点击后计数器自增
          onPressed: () => setState(
            () => ++_counter,
          ),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(StateCounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    print("didUpdateWidget ");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactivate");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("reassemble");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }
}
