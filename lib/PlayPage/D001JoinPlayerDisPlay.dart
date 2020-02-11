import 'package:flutter/material.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';

class JoinPlayerDisPlayController {
  Function open;
  Function close;
  bool mapopacity = false;
}

class D001JoinPlayerDisPlay extends StatefulWidget {
  final JoinPlayerDisPlayController controller;
  D001JoinPlayerDisPlay({this.controller, Key key}) : super(key: key);

  @override
  _D001JoinPlayerDisPlayState createState() {
    return _D001JoinPlayerDisPlayState(controller: controller);
  }
}

class _D001JoinPlayerDisPlayState extends State<D001JoinPlayerDisPlay>
    with SingleTickerProviderStateMixin {
  JoinPlayerDisPlayController controller;
  _D001JoinPlayerDisPlayState({this.controller}) {
    controller.open = () {
      anicontroller.forward();
    };
    controller.close = () {
      anicontroller.reverse();
    };
  }
  Animation<double> aniwidth;
  AnimationController anicontroller;
  @override
  void initState() {
    super.initState();
    anicontroller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    Animation curve =
        CurvedAnimation(parent: anicontroller, curve: Curves.easeOut);
    aniwidth = Tween<double>(begin: 0, end: 86).animate(curve);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: <Widget>[
        Container(
          child: FlatButton(
            child: Icon(ForutonaIcon.icninboxdark),
            onPressed: () {},
          ),
          height: 52.00,
          width: 52.00,
          decoration: BoxDecoration(
            color: controller.mapopacity
                ? Color(0xffffffff).withOpacity(0.3)
                : Color(0xffffffff),
            boxShadow: [
              BoxShadow(
                offset: Offset(0.00, 12.00),
                color: Color(0xff455b63).withOpacity(0.10),
                blurRadius: 16,
              ),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.00),
              bottomLeft: Radius.circular(12.00),
            ),
          ),
        ),
        Container(
          height: 52.00,
          width: aniwidth.value,
          alignment: Alignment.center,
          child: Text("참여한 볼",
              softWrap: false,
              style: TextStyle(
                fontFamily: "Noto Sans CJK KR",
                fontSize: 13,
                color: Color(0xff39f999),
              )),
          decoration: BoxDecoration(
            color: controller.mapopacity
                ? Color(0xff454f63).withOpacity(0.15)
                : Color(0xff454f63),
            border: Border.all(
              width: 1.00,
              color: controller.mapopacity
                  ? Color(0xff39f999).withOpacity(0.15)
                  : Color(0xff39f999),
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0.00, 3.00),
                color: Color(0xff000000).withOpacity(0.16),
                blurRadius: 6,
              ),
            ],
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(12.00),
              bottomRight: Radius.circular(12.00),
            ),
          ),
        )
      ],
    ));
  }
}
