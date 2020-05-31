import 'package:flutter/material.dart';
import 'package:forutonafront/Common/GoogleMapSupport/MapCircleAnimation.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';

class MapCircleAnimationWithContainer extends StatelessWidget {
  final double circleSize;
  final Widget centerContainer;

  MapCircleAnimationWithContainer(this.circleSize, this.centerContainer);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[

          Center(
            child: MapCircleAnimation(circleSize)
          ),
          Center(
              child:centerContainer
          ),
        ],
      ),
    );
  }

  factory MapCircleAnimationWithContainer.fromIssueBall(){
    return MapCircleAnimationWithContainer(100,Container(
      height: 25.00,
      width: 25.00,
      padding: EdgeInsets.only(left: 2),
      child:Icon(ForutonaIcon.issue,color: Colors.white,size: 15),
      decoration: BoxDecoration(
        color: Color(0xffdc3e57),
        border: Border.all(width: 1.00, color: Color(0xffdc3e57),),
        boxShadow: [
          BoxShadow(
            offset: Offset(0.00,3.00),
            color: Color(0xff000000).withOpacity(0.16),
            blurRadius: 6,
          ),
        ],
        shape: BoxShape.circle,
      ),
    ));
  }
}
