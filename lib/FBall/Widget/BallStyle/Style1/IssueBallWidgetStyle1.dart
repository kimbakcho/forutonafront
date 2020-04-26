import 'package:flutter/material.dart';
import 'package:forutonafront/Common/TimeUitl/TimeDisplayUtil.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style1/IssueBallWidgetSyle1ViewModel.dart';
import 'package:forutonafront/FBall/Widget/BallSupport/BallImageViwer.dart';

import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:provider/provider.dart';



// ignore: must_be_immutable
class IssueBallWidgetStyle1 extends StatefulWidget {
  FBallResDto ballResDto;

  IssueBallWidgetStyle1(this.ballResDto);

  @override
  _IssueBallWidgetStyle1State createState() {
    return _IssueBallWidgetStyle1State(this.ballResDto);
  }
}

class _IssueBallWidgetStyle1State extends State<IssueBallWidgetStyle1> {
  FBallResDto ballResDto;

  _IssueBallWidgetStyle1State(this.ballResDto);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => IssueBallWidgetSyle1ViewModel(this.ballResDto,this.context),
        child:
            Consumer<IssueBallWidgetSyle1ViewModel>(builder: (_, model, child) {
          return Container(
              margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: model.goIssueDetailPage,
                child:  Column(children: <Widget>[
                  ballHeader(model),
                  ballMainPickture(model),
                  ballProfileBar(model),
                  ballTextBar(model),
                  divider(),
                  Container(
                    height: 48.00,
                    padding: EdgeInsets.fromLTRB(14, 0, 14, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(ballResDto.ballLikes.toString(),
                            style: TextStyle(
                              fontFamily: "Gibson",
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Color(0xff78849e),
                            )),
                        Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 0, 7),
                            child: Icon(ForutonaIcon.thumbsup,
                                color: Color(0xff78849E), size: 17)),
                        SizedBox(width: 19),
                        Text(model.ballResDto.ballDisLikes.toString(),
                            style: TextStyle(
                              fontFamily: "Gibson",
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Color(0xff78849e),
                            )),
                        Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 0, 3),
                            child: Icon(ForutonaIcon.thumbsdown,
                                color: Color(0xff78849E), size: 17)),
                        SizedBox(width: 19),
                        Text(model.ballResDto.commentCount.toString(),
                            style: TextStyle(
                              fontFamily: "Gibson",
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Color(0xff78849e),
                            )),
                        Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 0, 3),
                            child: Icon(ForutonaIcon.comment,
                                color: Color(0xff78849E), size: 17)),
                        SizedBox(width: 19),
                        Text(
                            TimeDisplayUtil.getRemainingToStrFromNow(
                                model.ballResDto.activationTime),
                            style: TextStyle(
                              fontFamily: "Gibson",
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Color(0xff78849e),
                            )),
                        Padding(
                            padding: EdgeInsets.fromLTRB(5, 0, 0, 3),
                            child: Icon(ForutonaIcon.accesstime,
                                color: Color(0xff78849E), size: 17)),
                      ],
                    ),
                  )
                ]),
              ),
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0.00, 4.00),
                    color: Color(0xff455b63).withOpacity(0.08),
                    blurRadius: 16,
                  ),
                ],
                borderRadius: BorderRadius.circular(12.00),
              ));
        }));
  }

  Container divider() {
    return Container(
      height: 1.00,
      decoration: BoxDecoration(
        color: Color(0xfff4f4f6),
        borderRadius: BorderRadius.circular(1.00),
      ),
    );
  }

  Container ballTextBar(IssueBallWidgetSyle1ViewModel model) {
    return Container(
      width: MediaQuery.of(context).size.width - 64,
      padding: EdgeInsets.only(bottom: 23),
      child: Text(model.fBallDescriptionBasic.text,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: "Noto Sans CJK KR",
            fontSize: 14,
            color: Color(0xff78849e),
          )),
    );
  }

  Container ballProfileBar(IssueBallWidgetSyle1ViewModel model) {
    return Container(
      height: 55,
      padding: EdgeInsets.fromLTRB(14, 15, 14, 15),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              height: 25.00,
              width: 25.00,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(model.ballResDto.profilePicktureUrl)),
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.00, color: Color(0xffdc3e57))),
            ),
          ),
          Positioned(
            left: 34,
            top: 0,
            child: Text(model.ballResDto.nickName,
                style: TextStyle(
                  fontFamily: "Gibson",
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                  color: Color(0xff454f63),
                )),
          ),
          Positioned(
            left: 34,
            top: 16,
            child: Text(
                TimeDisplayUtil.getRemainingToStrFromNow(
                    model.ballResDto.activationTime),
                style: TextStyle(
                  fontFamily: "Gibson",
                  fontSize: 8,
                  color: Color(0xff454f63).withOpacity(0.56),
                )),
          )
        ],
      ),
    );
  }

  Widget ballMainPickture(IssueBallWidgetSyle1ViewModel model) {
    return model.isMainPicture()
        ? Stack(children: <Widget>[
            FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return BallImageViewer(
                        model.fBallDescriptionBasic.desimages,
                        model.ballResDto.ballUuid + "picturefromBigpicture");
                  }));
                },
                child: Hero(
                    tag: model.ballResDto.ballUuid + "picturefromBigpicture",
                    child: Container(
                        height: 172.00,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: NetworkImage(model.mainPictureSrc()),
                        ))))),
            model.getPicktureCount() > 1
                ? Positioned(
                    bottom: 10,
                    right: 10,
                    child: Hero(
                      tag: model.ballResDto.ballUuid + "picturefrombutton",
                      child: Container(
                          child: FlatButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return BallImageViewer(
                                    model.fBallDescriptionBasic.desimages,
                                    model.ballResDto.ballUuid +
                                        "picturefrombutton");
                              }));
                            },
                            padding: EdgeInsets.all(0),
                            child: Text("+${model.getPicktureCount() - 1}",
                                style: TextStyle(
                                  fontFamily: "Noto Sans CJK KR",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Color(0xffffffff),
                                )),
                          ),
                          height: 26.00,
                          width: 31.00,
                          decoration: BoxDecoration(
                            color: Color(0xff454f63).withOpacity(0.60),
                            border: Border.all(
                              width: 1.00,
                              color: Color(0xff454f63).withOpacity(0.60),
                            ),
                            borderRadius: BorderRadius.circular(12.00),
                          )),
                    ))
                : Container(
                    height: 0,
                  )
          ])
        : Container();
  }

  Container ballHeader(IssueBallWidgetSyle1ViewModel model) {
    return Container(
      height: 65,

      child: Stack(children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          child: Container(
              padding: EdgeInsets.only(left: 1, bottom: 1),
              child: Icon(ForutonaIcon.issue, size: 17, color: Colors.white),
              height: 30.00,
              width: 30.00,
              decoration: BoxDecoration(
                color: Color(0xffdc3e57),
                shape: BoxShape.circle,
              )),
        ),
        Positioned(
            top: 0,
            left: 48,
            width: 256,
            child: Container(
                width: 256,
                child: Text(model.ballResDto.ballName,
                    style: TextStyle(
                      fontFamily: "Noto Sans CJK KR",
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color(0xff454f63),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis))),
        Positioned(
          top: 19,
          left: 48,
          width: 200,
          child: Container(
            width: 200,
            child: Text(model.ballResDto.placeAddress,
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontSize: 12,
                  color: Color(0xff454f63).withOpacity(0.56),
                )),
          ),
        ),
        Positioned(
          top: 19,
          right: 0,
          height: 19,
          width: 68,
          child: Container(
            width: 68,
            alignment: Alignment.centerRight,
            child: Text(model.ballResDto.distanceDisplayText,
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontSize: 10,
                  color: Color(0xffff4f9a).withOpacity(0.56),
                )),
          ),
        )
      ]),
      padding: EdgeInsets.fromLTRB(13, 16, 12, 14),
    );
  }
}
