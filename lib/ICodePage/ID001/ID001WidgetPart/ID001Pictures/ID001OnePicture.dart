import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/FBallDesImagesDto.dart';
import 'package:forutonafront/ICodePage/ID001/ID001WidgetPart/ID001Pictures/ID001ImageContainer.dart';

class ID001OnePicture extends StatelessWidget {
  final FBallDesImages fBallDesImages;

  ID001OnePicture({this.fBallDesImages});

  @override
  Widget build(BuildContext context) {
    return Container(child: ID001ImageContainer([fBallDesImages], 0));
  }
}
