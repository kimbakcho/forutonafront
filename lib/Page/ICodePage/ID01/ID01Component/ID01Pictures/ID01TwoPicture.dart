import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallDesImagesDto.dart';

import 'package:forutonafront/Page/ICodePage/IM001/Component/BallImageEdit/BallImageItem.dart';

import 'ID01ImageContainer.dart';

class ID01TwoPicture extends StatelessWidget {
  final List<BallImageItem?>? fBallDesImages;

  ID01TwoPicture({this.fBallDesImages});

  @override
  Widget build(BuildContext context) {
    return fBallDesImages != null
        ? Container(
            child: Row(children: [
              Expanded(
                child: ID01ImageContainer(fBallDesImages, 0),
              ),
              Expanded(child: ID01ImageContainer(fBallDesImages, 1))
            ]),
          )
        : Container();
  }
}
