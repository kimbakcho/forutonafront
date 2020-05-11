import 'package:flutter/material.dart';
import 'package:forutonafront/Common/TimeUitl/TimeDisplayUtil.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style3/IssueBallWidgetStyle3ViewModel.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class IssueBallWidgetStyle3 extends StatelessWidget {
  FBallResDto ballResDto;

  IssueBallWidgetStyle3(this.ballResDto);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => IssueBallWidgetStyle3ViewModel(ballResDto,context),
        child: Consumer<IssueBallWidgetStyle3ViewModel>(
            builder: (_, model, child) {
          return Container(
              height: 90.00,
              width: MediaQuery.of(context).size.width-48,
              child: FlatButton(
                padding: EdgeInsets.all(0),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 11,
                      left: 11,
                      child: issueBallIcon(),
                    ),
                    Positioned(
                        top: 11, left: 54, child: ballNameText(model,context)),
                    Positioned(
                        top: 31, left: 54, child: makerInfoBar(model,context)),
                    Positioned(
                        right: 0, top: 0, child: ballMainimageBox(model)),
                    Positioned(top: 54, left: 0, child: divider(context)),
                    Positioned(top: 50, right: 0, child: ballBottomBar(model,context))
                  ],
                ),
                onPressed: model.goIssueDetailPage,
              ),
              decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0.00, 3.00),
                      color: Color(0xff000000).withOpacity(0.16),
                      blurRadius: 6,
                    )
                  ],
                  borderRadius: BorderRadius.circular(12.00)));
        }));
  }

  Container makerInfoBar(IssueBallWidgetStyle3ViewModel model,BuildContext context) {
    return Container(
      width: model.isMainPicture() ? MediaQuery.of(context).size.width-182 : MediaQuery.of(context).size.width-108,
      child: RichText(
        text: TextSpan(
            text: model.ballResDto.nickName,
            style: TextStyle(
              fontFamily: "Noto Sans CJK KR",
              fontWeight: FontWeight.w700,
              fontSize: 10,
              color: Color(0xff78849e),
            ),
            children: <TextSpan>[
              TextSpan(text: "    "),
              TextSpan(
                  text: "${model.ballResDto.userLevel.toStringAsFixed(0)}  lv",style: TextStyle(
                fontFamily: "Noto Sans CJK KR",fontWeight: FontWeight.w700,
                fontSize: 9,
                color:Color(0xff454f63).withOpacity(0.56),
              )),
            ]),
      ),
    );
  }

  Container ballBottomBar(IssueBallWidgetStyle3ViewModel model,BuildContext context) {
    return Container(
      height: 48.00,
        width: MediaQuery.of(context).size.width-32,
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
    );
  }

  Container divider(BuildContext context) {
    return Container(
      height: 0.50,
        width: MediaQuery.of(context).size.width-48,
      color: Color(0xffe4e4e4),
    );
  }

  Container ballMainimageBox(IssueBallWidgetStyle3ViewModel model) {
    return model.isMainPicture()
        ? Container(
            height: 54.00,
            width: 80.00,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      model.fBallDescriptionBasic.desimages[0].src)),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12.00),
              ),
            ),
          )
        : Container();
  }

  Container ballNameText(IssueBallWidgetStyle3ViewModel model,BuildContext context) {
    return Container(
      width: model.isMainPicture() ? MediaQuery.of(context).size.width-182 : MediaQuery.of(context).size.width-108,
      height: 18,
      child: Text(model.ballResDto.ballName,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: "Noto Sans CJK KR",
            fontWeight: FontWeight.w700,
            fontSize: 13,
            color: Color(0xff454f63),
          )),
    );
  }

  Container issueBallIcon() {
    return Container(
        padding: EdgeInsets.only(left: 1, bottom: 1),
        child: Icon(ForutonaIcon.issue, size: 17, color: Colors.white),
        height: 30.00,
        width: 30.00,
        decoration: BoxDecoration(
          color: Color(0xffdc3e57),
          shape: BoxShape.circle,
        ));
  }
}
