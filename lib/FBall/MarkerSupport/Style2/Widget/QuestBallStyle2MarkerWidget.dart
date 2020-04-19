import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';

class QuestBallStyle2MarkerWidget {
  static selectBall(){
    return Container(
      width: 30.w,
      height: 30.h,
      child: Icon(ForutonaIcon.quest, color: Colors.white, size: 30.sp),
      decoration: BoxDecoration(
          color: Colors.lightBlue,
          shape: BoxShape.circle
      ),
    );
  }
}