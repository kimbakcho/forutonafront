
import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallDesImagesDto.dart';

import 'BallDesciprtionImageViwer.dart';


class ThreeBallDescriptionImageMode extends BallDescriptionImageViewer{
  ThreeBallDescriptionImageMode({@required List<FBallDesImages> desImages,@required BuildContext context})
      : super(desImages:desImages,context:context);

  @override
  Widget getImageViewerWidget() {
    return Container(
        height: 260.00,
        margin: EdgeInsets.only(bottom: 24),
        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Container(
                    margin: EdgeInsets.only(right: 2),
                    height: 260.00,
                    child: FlatButton(
                      child: Container(),
                      onPressed: () {
                        jumpToBallImageViewer(0);
                      },
                    ),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              desImages[0].src),
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.00),
                          bottomLeft: Radius.circular(12.00),
                        )))),
            Column(children: [
              Expanded(
                  flex: 1,
                  child: Container(
                      margin: EdgeInsets.only(bottom: 1),
                      child: FlatButton(
                        child: Container(),
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          jumpToBallImageViewer(1);
                        },
                      ),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                desImages[1].src),
                          ),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12.00),
                          )))),
              Expanded(
                  flex: 1,
                  child: Container(
                      margin: EdgeInsets.only(top: 1),
                      child: FlatButton(
                        child: Container(),
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          jumpToBallImageViewer(2);
                        },
                      ),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                desImages[2].src),
                          ),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(12.00),
                          ))))
            ])
          ],
        ));
  }

}