import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/FBallDesImagesDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallDescriptionImageViewer/OneBallDescriptionImageMode.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallSupport/BallImageViwer.dart';

import 'ForeBallDescriptionImageMode.dart';
import 'ManyBallDescriptionImageMode.dart';
import 'ThreeBallDescriptionImageMode.dart';
import 'TwoBallDescriptionImageMode.dart';
import 'ZeroBallDescriptionImageMode.dart';

abstract class BallDescriptionImageViewer {

  final BuildContext context;
  final List<FBallDesImages> desImages;
  BallDescriptionImageViewer({@required this.desImages,@required this.context});

  Widget getImageViewerWidget();

  jumpToBallImageViewer(int indexNumber) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return BallImageViewer(
        desImages,
        null,
        initIndex: indexNumber,
      );
    }));
  }

  factory BallDescriptionImageViewer.descriptionImages(
      {@required List<FBallDesImages> desImages,@required BuildContext context}){
    BallDescriptionImageViewer ballDescriptionImageViewer;
    switch (desImages.length) {
      case 0 :
        ballDescriptionImageViewer = ZeroBallDescriptionImageMode(context: context,desImages: desImages);
        break;
      case 1:
        ballDescriptionImageViewer = OneBallDescriptionImageMode(context: context,desImages: desImages);
        break;
      case 2:
        ballDescriptionImageViewer = TwoBallDescriptionImageMode(context: context,desImages: desImages);
        break;
      case 3:
        ballDescriptionImageViewer = ThreeBallDescriptionImageMode(context: context,desImages: desImages);
        break;
      case 4:
        ballDescriptionImageViewer = ForeBallDescriptionImageMode(context: context,desImages: desImages);
        break;
      default :
        ballDescriptionImageViewer = ManyBallDescriptionImageMode(context: context,desImages: desImages);
        break;
    }
    return ballDescriptionImageViewer;

  }
}