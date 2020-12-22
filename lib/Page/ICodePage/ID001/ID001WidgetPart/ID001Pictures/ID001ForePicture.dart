import 'package:flutter/cupertino.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallDesImagesDto.dart';
import 'package:forutonafront/Page/ICodePage/ID001/ID001WidgetPart/ID001Pictures/ID001ImageContainer.dart';

class ID001ForePicture extends StatelessWidget {
  final List<FBallDesImages> fBallDesImages;

  ID001ForePicture({this.fBallDesImages});

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
                    child: ID001ImageContainer(fBallDesImages, 0),
                  ),
                  Expanded(
                    child: ID001ImageContainer(fBallDesImages, 2),
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
                    child: ID001ImageContainer(fBallDesImages, 1),
                  ),
                  Expanded(
                    child: ID001ImageContainer(fBallDesImages, 3),
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
