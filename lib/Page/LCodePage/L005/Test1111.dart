import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Test1111 extends StatefulWidget {
  @override
  _Test1111State createState() => _Test1111State();
}

class _Test1111State extends State<Test1111> with SingleTickerProviderStateMixin{


  Ticker _ticker;



  @override
  Widget build(BuildContext context) {
    return Container(child: Text('${DateTime.now().second}'),);
  }

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((Duration elapsed) {
      setState(() {
        print("tt");
      });

    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }
}
