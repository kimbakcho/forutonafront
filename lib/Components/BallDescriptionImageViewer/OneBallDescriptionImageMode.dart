
import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallDesImagesDto.dart';

import 'BallDesciprtionImageViwer.dart';


class OneBallDescriptionImageMode extends BallDescriptionImageViewer{
  OneBallDescriptionImageMode({required List<FBallDesImages> desImages,required BuildContext context})
      : super(desImages:desImages,context:context);

  @override
  Widget getImageViewerWidget() {
    return Container(
        height: 260.00,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: FlatButton(
          child: Container(),
          onPressed: () {
            jumpToBallImageViewer(0);
          },
        ),
        decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image:
              NetworkImage(desImages[0].src!),
            ),
            borderRadius: BorderRadius.circular(12.00)));
  }

}