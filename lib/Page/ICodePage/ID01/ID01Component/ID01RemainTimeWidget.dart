import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:forutonafront/Common/TimeUitl/TimeDisplayUtil.dart';
import 'package:google_fonts/google_fonts.dart';

class ID01RemainTimeWidget extends StatefulWidget {
  final DateTime limitTime;

  const ID01RemainTimeWidget({Key key, this.limitTime}) : super(key: key);

  @override
  _ID01RemainTimeWidgetState createState() => _ID01RemainTimeWidgetState();
}

class _ID01RemainTimeWidgetState extends State<ID01RemainTimeWidget>
    with SingleTickerProviderStateMixin {
  Ticker _ticker;

  _ID01RemainTimeWidgetState();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 20,
            padding: EdgeInsets.only(left: 8, right: 8),
            margin: EdgeInsets.only(right: 16),
            child: Row(children: [
              Icon(Icons.access_time,size: 12,),
              Container(
                padding: EdgeInsets.only(bottom: 2,top:2),
                  margin: EdgeInsets.only(left: 6),
                  child: Text(remainTimeStr,
                      style: GoogleFonts.notoSans(
                        fontSize: 10,
                        color: const Color(0xff3a3e3f),
                        fontWeight: FontWeight.w500,
                      )))
            ]),
            decoration: BoxDecoration(
                color: Color(0xffF6F6F6),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0))),
          )
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
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  String get remainTimeStr {
    return TimeDisplayUtil.getCalcToStrFromNow(widget.limitTime);
  }
}
