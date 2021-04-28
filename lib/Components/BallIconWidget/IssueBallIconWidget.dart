import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';

class IssueBallIconWidget extends StatelessWidget {
  final Size size;
  final double iconSize;
  IssueBallIconWidget({required this.size,required this.iconSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(ForutonaIcon.issue1,color: Colors.white,size: iconSize),
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xffDC3E57)
      ),
    );
  }
}
