import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style1/BallStyle1Widget.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style1/BallStyle1WidgetController.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style1/IssueBallWidgetSyle1ViewModel.dart';
import 'package:forutonafront/FBall/Widget/BallSupport/BallImageViwer.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:provider/provider.dart';

class IssueBallWidgetStyle1 extends StatelessWidget
    implements BallStyle1Widget {
  final BallStyle1WidgetController ballStyle1WidgetController;

  IssueBallWidgetStyle1(this.ballStyle1WidgetController);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        key: UniqueKey(),
        create: (_) =>
            IssueBallWidgetSyle1ViewModel(ballStyle1WidgetController, context),
        child:
            Consumer<IssueBallWidgetSyle1ViewModel>(builder: (_, model, child) {
          return Stack(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: FlatButton(
                    padding: EdgeInsets.all(0),
                    onPressed: model.goIssueDetailPage,
                    child: Column(children: <Widget>[
                      ballHeader(model),
                      !model.getBallResDto().ballDeleteFlag
                          ? ballMainPickture(model, context)
                          : Container(),
                      ballProfileBar(model),
                      ballTextBar(model, context),
                      divider(),
                      Container(
                        height: 48.00,
                        padding: EdgeInsets.fromLTRB(14, 0, 14, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(model.getLikeCount(),
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
                            Text(model.getDisLikeCount(),
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
                            Text(model.getCommentCount(),
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
                            Text(model.getRemainingTime(),
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
                  )),
              model.getIsLoading() ? CommonLoadingComponent() : Container()
            ],
          );
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

  Container ballTextBar(
      IssueBallWidgetSyle1ViewModel model, BuildContext context) {
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
                      image: NetworkImage(model.getProfilePicktureUrl())),
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.00, color: Color(0xffdc3e57))),
            ),
          ),
          Positioned(
            left: 34,
            top: 0,
            child: Text(model.getNickName(),
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
            child: Text(model.getRemainingTime(),
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

  Widget ballMainPickture(
      IssueBallWidgetSyle1ViewModel model, BuildContext context) {
    return model.isMainPicture()
        ? Stack(children: <Widget>[
            FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return BallImageViewer(
                        model.fBallDescriptionBasic.desimages,
                        model.getBallResDto().ballUuid +
                            "picturefromBigpicture");
                  }));
                },
                child: Hero(
                    tag: model.getBallResDto().ballUuid +
                        "picturefromBigpicture",
                    child: CachedNetworkImage(
                      imageUrl: model.mainPictureSrc(),
                      imageBuilder: (context, imageProvider) => Container(
                          height: 172.00,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: imageProvider,
                          ))),
                      placeholder: (context, url) => Container(
                        height: 172,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ))),
            model.getPicktureCount() > 1
                ? Positioned(
                    bottom: 10,
                    right: 10,
                    child: Hero(
                      tag: model.getBallResDto().ballUuid + "picturefrombutton",
                      child: Container(
                          child: FlatButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return BallImageViewer(
                                    model.fBallDescriptionBasic.desimages,
                                    model.getBallResDto().ballUuid +
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
                child: Text(model.getBallName(),
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
            child: Text(model.getPlaceAddress(),
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
            child: Text(model.getDistanceDisplayText(),
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

  @override
  BallStyle1WidgetController getBallStyle1WidgetController() {
    return ballStyle1WidgetController;
  }

  @override
  String getBallUuid() {
    return ballStyle1WidgetController.fBallResDto.ballUuid;
  }
}
