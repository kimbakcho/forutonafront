import 'package:flutter/cupertino.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallDesImagesDto.dart';
import 'package:forutonafront/Page/ICodePage/IM001/Component/BallImageEdit/BallImageItem.dart';

import 'DBallImageContainer.dart';

class DBallForePicture extends StatelessWidget {
  final List<BallImageItem?>? fBallDesImages;

  DBallForePicture({this.fBallDesImages});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: DBallImageContainer(fBallDesImages!, 0),
                  ),
                  Expanded(
                    child: DBallImageContainer(fBallDesImages!, 2),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: DBallImageContainer(fBallDesImages!, 1),
                  ),
                  Expanded(
                    child: DBallImageContainer(fBallDesImages!, 3),
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
