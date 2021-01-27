import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallDesImagesDto.dart';
import 'package:forutonafront/Page/ICodePage/ID001/ID001WidgetPart/ID001Pictures/ID001ImageContainer.dart';
import 'package:forutonafront/Page/ICodePage/IM001/Component/BallImageEdit/BallImageItem.dart';

class ID001OnePicture extends StatelessWidget {
  final BallImageItem fBallDesImages;

  ID001OnePicture({this.fBallDesImages});

  @override
  Widget build(BuildContext context) {
    return Container(child: ID001ImageContainer([fBallDesImages], 0));
  }
}
