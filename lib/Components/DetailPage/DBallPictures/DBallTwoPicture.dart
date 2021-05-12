import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallDesImagesDto.dart';

import 'package:forutonafront/Page/ICodePage/IM001/Component/BallImageEdit/BallImageItem.dart';

import 'DBallImageContainer.dart';

class DBallTwoPicture extends StatelessWidget {
  final List<BallImageItem?>? fBallDesImages;

  DBallTwoPicture({this.fBallDesImages});

  @override
  Widget build(BuildContext context) {
    return fBallDesImages != null
        ? Container(
            child: Row(children: [
              Expanded(
                child: DBallImageContainer(fBallDesImages, 0),
              ),
              Expanded(child: DBallImageContainer(fBallDesImages, 1))
            ]),
          )
        : Container();
  }
}
