import 'package:flutter/cupertino.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallDesImagesDto.dart';
import 'package:forutonafront/Page/ICodePage/IM001/Component/BallImageEdit/BallImageItem.dart';

import 'ID01ImageContainer.dart';

class ID01ThreePicture extends StatelessWidget {
  final List<BallImageItem> fBallDesImages;

  ID01ThreePicture({this.fBallDesImages});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: ID01ImageContainer(fBallDesImages, 0),
          ),
          Expanded(
            child: Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ID01ImageContainer(fBallDesImages, 1),
                  ),
                  Expanded(
                    child: ID01ImageContainer(fBallDesImages, 2),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
