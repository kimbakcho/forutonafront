import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Dto/FBallDesImagesDto.dart';
import 'package:forutonafront/ICodePage/ID001/ID001WidgetPart/ID001Pictures/ID001ImageContainer.dart';

class ID001ThreePicture extends StatelessWidget {
  final List<FBallDesImages> fBallDesImages;

  ID001ThreePicture({this.fBallDesImages});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: ID001ImageContainer(fBallDesImages, 0),
          ),
          Expanded(
            child: Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ID001ImageContainer(fBallDesImages, 1),
                  ),
                  Expanded(
                    child: ID001ImageContainer(fBallDesImages, 2),
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
