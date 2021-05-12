import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallDesImagesDto.dart';
import 'package:forutonafront/Page/ICodePage/IM001/Component/BallImageEdit/BallImageItem.dart';

import 'DBallImageContainer.dart';

class DBallOnePicture extends StatelessWidget {
  final BallImageItem? fBallDesImages;

  DBallOnePicture({this.fBallDesImages});

  @override
  Widget build(BuildContext context) {
    return Container(child: DBallImageContainer([fBallDesImages!], 0));
  }
}
