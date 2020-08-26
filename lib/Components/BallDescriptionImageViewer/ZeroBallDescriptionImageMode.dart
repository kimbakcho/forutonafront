
import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/FBallDesImagesDto.dart';

import 'BallDesciprtionImageViwer.dart';


class ZeroBallDescriptionImageMode extends BallDescriptionImageViewer{


  ZeroBallDescriptionImageMode({@required List<FBallDesImages> desImages,@required BuildContext context})
      : super(desImages:desImages,context:context);

  @override
  Widget getImageViewerWidget() {
    return Container();
  }


}