import 'package:flutter/material.dart';

class CircleIconBtn extends StatelessWidget {

  final Function onTap;

  final Icon icon;

  final double width;

  final double height;

  final Color color;

  final Border border;

  const CircleIconBtn(
      {Key key,
      this.onTap,
      this.icon,
      this.width = 32,
      this.height = 32,
      this.color = const Color(0xffF6F6F6), this.border = const Border()})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        shape: CircleBorder(),
        color: color,
        child: InkWell(
            customBorder: CircleBorder(),
            onTap: () {
              onTap();
            },
            child: Container(
                width: width,
                height: height,
                child: icon,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: border
                ))));
  }
}
