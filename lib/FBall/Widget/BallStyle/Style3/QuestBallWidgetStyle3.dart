import 'package:flutter/material.dart';
import 'package:forutonafront/Common/TimeUitl/TimeDisplayUtil.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style3/BallStyle3Widget.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style3/QuestBallWidgetStyle3ViewModel.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:provider/provider.dart';

import 'BallStyle3WidgetController.dart';

// ignore: must_be_immutable
class QuestBallWidgetStyle3 extends StatelessWidget implements BallStyle3Widget{
  final BallStyle3WidgetController ballStyle3WidgetController;

  QuestBallWidgetStyle3(this.ballStyle3WidgetController);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        key: UniqueKey(),
        create: (_) => QuestBallWidgetStyle3ViewModel(ballStyle3WidgetController,context),
        child: Consumer<QuestBallWidgetStyle3ViewModel>(
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
                      child: questBallIcon(),
                    ),
                    Positioned(
                        top: 11, left: 54, child: ballNameText(model,context)),
                    Positioned(
                        top: 31, left: 54, child: makerInfoBar(model)),
                    Positioned(
                        right: 0, top: 0, child: ballMainImageBox(model)),
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

  Container makerInfoBar(QuestBallWidgetStyle3ViewModel model) {
    return Container(
      width: model.isMainPicture() ? 178 : 252,
      child: RichText(
        text: TextSpan(
            text: model.getFBallResDto().nickName,
            style: TextStyle(
              fontFamily: "Noto Sans CJK KR",
              fontWeight: FontWeight.w700,
              fontSize: 10,
              color: Color(0xff78849e),
            ),
            children: <TextSpan>[
              TextSpan(text: "    "),
              TextSpan(
                  text: "${model.getFBallResDto().userLevel.toStringAsFixed(0)}  lv",
                  style: TextStyle(
                    fontFamily: "Noto Sans CJK KR",
                    fontWeight: FontWeight.w700,
                    fontSize: 9,
                    color: Color(0xff454f63).withOpacity(0.56),
                  )),
            ]),
      ),
    );
  }

  Container ballBottomBar(QuestBallWidgetStyle3ViewModel model,BuildContext context) {
    return Container(
        height: 48.00,
        width: MediaQuery.of(context).size.width-48,
        padding: EdgeInsets.fromLTRB(14, 0, 14, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(model.getFBallResDto().ballLikes.toString(),
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
            Text(model.getFBallResDto().ballDisLikes.toString(),
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
            Text(model.getFBallResDto().commentCount.toString(),
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
                    model.getFBallResDto().activationTime),
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
        ));
  }

  Container divider(BuildContext context) {
    return Container(
      height: 0.50,
      width: MediaQuery.of(context).size.width-48,
      color: Color(0xffe4e4e4),
    );
  }

  Container ballMainImageBox(QuestBallWidgetStyle3ViewModel model) {
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

  Container ballNameText(QuestBallWidgetStyle3ViewModel model,BuildContext context) {
    return Container(
      width: model.isMainPicture() ? MediaQuery.of(context).size.width-182 : MediaQuery.of(context).size.width-108,
      height: 18,
      child: Text(model.getFBallResDto().ballName,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: "Noto Sans CJK KR",
            fontWeight: FontWeight.w700,
            fontSize: 13,
            color: Color(0xff454f63),
          )),
    );
  }

  Container questBallIcon() {
    return Container(
        padding: EdgeInsets.only(left: 1, bottom: 1),
        child: Icon(ForutonaIcon.quest, size: 13, color: Colors.white),
        height: 30.00,
        width: 30.00,
        decoration: BoxDecoration(
          color: Color(0xff4F72FF),
          shape: BoxShape.circle,
        ));
  }

  @override
  BallStyle3WidgetController getBallStyle3WidgetController() {
    return ballStyle3WidgetController;
  }

  @override
  String getBallUuid() {
    return ballStyle3WidgetController.fBallResDto.ballUuid;
  }


}
