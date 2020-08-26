
import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/FBallDesImagesDto.dart';

import 'BallDesciprtionImageViwer.dart';


class TwoBallDescriptionImageMode extends BallDescriptionImageViewer{
  TwoBallDescriptionImageMode({@required List<FBallDesImages> desImages,@required BuildContext context})
      : super(desImages:desImages,context:context);

  @override
  Widget getImageViewerWidget() {
    return Container(
      height: 260.00,
      margin: EdgeInsets.only(bottom: 24),
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Row(children: <Widget>[
        Expanded(
            flex: 1,
            child: Container(
                margin: EdgeInsets.only(right: 1),
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
        Expanded(
            flex: 1,
            child: Container(
                margin: EdgeInsets.only(left: 1),
                height: 260.00,
                child: FlatButton(
                  child: Container(),
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
                      bottomRight: Radius.circular(12.00),
                    ))))
      ]),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.00),
      ),
    );
  }

}