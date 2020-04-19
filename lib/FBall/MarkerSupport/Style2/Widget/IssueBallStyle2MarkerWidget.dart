import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';

class IssueBallStyle2MarkerWidget {
  static selectBall() {
    return Container(
      width: 60.w,
      height: 60.h,
      child: Icon(ForutonaIcon.issue, color: Colors.white, size: 30.sp),
      decoration: BoxDecoration(
        color: Color(0xffDC3E57),
        shape: BoxShape.circle
      ),
    );
  }
}
