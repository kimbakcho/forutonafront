import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/FBallDesImagesDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallImageViewer/BallImageViwer.dart';
import 'package:forutonafront/ICodePage/ID001/ID001WidgetPart/ID001Pictures/ID001ImageContainer.dart';

class ID001TwoPicture extends StatelessWidget {
  final List<FBallDesImages> fBallDesImages;

  ID001TwoPicture({this.fBallDesImages});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: ID001ImageContainer(fBallDesImages,0),
          ),
          Expanded(
            child: ID001ImageContainer(fBallDesImages,1)
          )
        ]
      ),
    );
  }

}
