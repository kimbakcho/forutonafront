import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallDesImagesDto.dart';
import 'package:forutonafront/Page/ICodePage/IM001/Component/BallImageEdit/BallImageItem.dart';

import 'ID01ImageContainer.dart';

class ID01OnePicture extends StatelessWidget {
  final BallImageItem? fBallDesImages;

  ID01OnePicture({this.fBallDesImages});

  @override
  Widget build(BuildContext context) {
    return Container(child: ID01ImageContainer([fBallDesImages!], 0));
  }
}
