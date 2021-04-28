import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ID01RemainTimeProgress extends StatefulWidget {
  final DateTime? createTime;
  final DateTime? limitTime;

  const ID01RemainTimeProgress({Key? key, this.limitTime, this.createTime})
      : super(key: key);

  @override
  _ID01RemainTimeProgressState createState() => _ID01RemainTimeProgressState();
}

class _ID01RemainTimeProgressState extends State<ID01RemainTimeProgress>
    with SingleTickerProviderStateMixin {
  Ticker? _ticker;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
              child: LinearProgressIndicator(
            minHeight: 2,
            backgroundColor: Color(0xffF5F5F5),
            value: remainTime,
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xff00FF2B)),
          ))
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((Duration elapsed) {
      setState(() {});
    });
    _ticker!.start();
  }

  @override
  void dispose() {
    _ticker!.dispose();
    super.dispose();
  }

  double get remainTime {
    var totalTime = widget.limitTime!.difference(widget.createTime!);
    var remainTime = widget.limitTime!.difference(DateTime.now());
    if (remainTime.isNegative) {
      return 0;
    } else {
      return remainTime.inSeconds / totalTime.inSeconds;
    }
  }
}
