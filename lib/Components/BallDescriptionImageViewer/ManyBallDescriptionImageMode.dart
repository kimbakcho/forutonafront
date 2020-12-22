import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallDesImagesDto.dart';

import 'BallDesciprtionImageViwer.dart';


class ManyBallDescriptionImageMode extends BallDescriptionImageViewer {
  ManyBallDescriptionImageMode({@required List<
      FBallDesImages> desImages, @required BuildContext context})
      : super(desImages: desImages, context: context);

  @override
  Widget getImageViewerWidget() {
    return Container(
        height: 260.00,
        margin: EdgeInsets.only(bottom: 24),
        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                  height: 260.00,
                  margin: EdgeInsets.only(right: 2),
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
                    ),
                  )),
            ),
            Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child:Container(
                      margin: EdgeInsets.only(bottom: 1),
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
                          ))),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                      margin: EdgeInsets.only(top: 1, bottom: 1),
                      child: FlatButton(
                        child: Container(),
                        onPressed: () {
                          jumpToBallImageViewer(2);
                        },
                      ),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                desImages[2].src),
                          ))),
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                        margin: EdgeInsets.only(top: 1),
                        child: Container(
                          child: FlatButton(
                              onPressed: () {
                                jumpToBallImageViewer(3);
                              },
                              child: Text(
                                  "더 보기 +${desImages.length - 4}",
                                  style: TextStyle(
                                    fontFamily: "Noto Sans CJK KR",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 10,
                                    color: Color(0xfff2f0f1),
                                  ))),
                          decoration: BoxDecoration(
                            color: Color(0xff454f63).withOpacity(0.90),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(12.00)),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Color(0xff454f63).withOpacity(0.90),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    desImages[3].src)),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(12.00),
                            ))))
              ],
            )
          ],
        ));
  }

}