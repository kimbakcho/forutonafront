import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/TimeUitl/TimeDisplayUtil.dart';
import 'package:forutonafront/Common/ValueDisplayUtil/NomalValueDisplay.dart';
import 'package:forutonafront/FBall/Dto/UserBallResDto.dart';

import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:provider/provider.dart';

import 'IssueBallWidgetStyle2ViewModel.dart';

// ignore: must_be_immutable
class IssueBallWidgetStyle2 extends StatelessWidget {
  UserBallResDto resDto;

  IssueBallWidgetStyle2(this.resDto);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => IssueBallWidgetStyle2ViewModel(this.resDto),
        child: Consumer<IssueBallWidgetStyle2ViewModel>(
            builder: (_, model, child) {
          return Container(
              margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
              height: 133,

              child: Stack(
                children: <Widget>[
                  FlatButton(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                      onPressed: () {},
                      child: Stack(children: <Widget>[
                        Positioned(
                          top: 0,
                          left: 0,
                          child: ballIcon(),
                        ),
                        Positioned(
                            top: 0, left: 46, child: titleAndAddress(model,context)),
                        Positioned(
                          bottom: 31,
                          child: divider(context),
                        ),
                        Positioned(
                            right: 0, bottom: 0, child: valueBottomBar(model)),
                        Positioned(
                          bottom: 47,
                          right: 0,
                          child: Container(
                            child: Text(model.resDto.distanceDisplayText,
                                style: TextStyle(
                                  fontFamily: "Noto Sans CJK KR",
                                  fontSize: 10,
                                  color: Color(0xffff4f9a).withOpacity(0.56),
                                )),
                          ),
                        ),
                      ])),
                  Positioned(right: 4, top: 10, child: pointDashButton())
                ],
              ),
              decoration: BoxDecoration(
                  color: model.isAlive ? Color(0xffffffff) :  Color(0xffF6F6F6),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0.00, 3.00),
                      color:  Color(0xff000000).withOpacity(0.16),
                      blurRadius: 6,
                    )
                  ],
                  borderRadius: BorderRadius.circular(12.00)));
        }));
  }

  Container pointDashButton() {
    return Container(
        height: 30,
        width: 30,
        child: FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: () {},
          shape: CircleBorder(),
          child: Icon(
            ForutonaIcon.pointdash,
            size: 16,
          ),
        ));
  }

  Container valueBottomBar(IssueBallWidgetStyle2ViewModel model) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            child: Text(
                NomalValueDisplay.changeIntDisplaystr(model.resDto.ballLikes),
                style: TextStyle(
                  fontFamily: "Gibson",
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Color(0xff78849e),
                )),
            margin: EdgeInsets.only(right: 6),
          ),
          Container(
            child: Icon(
              ForutonaIcon.thumbsup,
              size: 15,
              color: Color(0xff78849e),
            ),
            margin: EdgeInsets.only(right: 19),
          ),
          Container(
            child: Text(
                NomalValueDisplay.changeIntDisplaystr(
                    model.resDto.ballDisLikes),
                style: TextStyle(
                  fontFamily: "Gibson",
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Color(0xff78849e),
                )),
            margin: EdgeInsets.only(right: 6),
          ),
          Container(
            child: Icon(
              ForutonaIcon.thumbsdown,
              size: 15,
              color: Color(0xff78849e),
            ),
            margin: EdgeInsets.only(right: 19),
          ),
          Container(
            child: Text(
                NomalValueDisplay.changeIntDisplaystr(
                    model.resDto.commentCount),
                style: TextStyle(
                  fontFamily: "Gibson",
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Color(0xff78849e),
                )),
            margin: EdgeInsets.only(right: 6),
          ),
          Container(
            child: Icon(
              ForutonaIcon.comment,
              size: 15,
              color: Color(0xff78849e),
            ),
            margin: EdgeInsets.only(right: 19),
          ),
          Container(
            child: Text(
                TimeDisplayUtil.getRemainingToStrFromNow(
                    model.resDto.activationTime),
                style: TextStyle(
                  fontFamily: "Gibson",
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Color(0xff78849e),
                )),
            margin: EdgeInsets.only(right: 6),
          ),
          Container(
            child: Icon(
              ForutonaIcon.accesstime,
              size: 15,
              color: Color(0xff78849e),
            ),
          )
        ],
      ),
    );
  }

  Container divider(BuildContext context) {
    return Container(
      height: 1,
      width: MediaQuery.of(context).size.width-64,
      color: Color(0xffe4e7e8),
    );
  }

  Container ballIcon() {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        color: Color(0xffDC3E57),
        shape: BoxShape.circle,
      ),
      padding: EdgeInsets.only(left: 1, bottom: 1),
      child: Icon(ForutonaIcon.issue, color: Colors.white, size: 17),
    );
  }

  Container titleAndAddress(IssueBallWidgetStyle2ViewModel model,BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width-120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(model.resDto.ballName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: model.isAlive ? Color(0xff454f63):Color(0xff454F63).withOpacity(0.7),
                )),
            Text(model.resDto.ballPlaceAddress,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontSize: 11,
                  color: Color(0xff454f63).withOpacity(0.56),
                ))
          ],
        ));
  }
}
