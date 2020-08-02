import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/FBall/Domain/Entity/IssueBall.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallImageViewer/BallImageViwer.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallStyle/BasicStyle/IssueBallBasicStyle.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallStyle/Style1/BallStyle1Widget.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallStyle/Style1/IssueBallWidgetStyle1ViewModel.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class IssueBallWidgetStyle1 extends StatelessWidget
    implements BallStyle1Widget {
  IssueBall _issueBall;

  IssueBallWidgetStyle1({@required FBallResDto fBallResDto}) {
    _issueBall = IssueBall.fromFBallResDto(fBallResDto);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        key: UniqueKey(),
        create: (_) => IssueBallWidgetStyle1ViewModel(
            context: context,
            issueBall: _issueBall,
            issueBallBasicStyle: IssueBallBasicStyleImpl(
              fireBaseAuthAdapterForUseCase: sl(),
                context: context),
            geoLocationUtilUseCaseInputPort: sl()),
        child: Consumer<IssueBallWidgetStyle1ViewModel>(
            builder: (_, model, child) {
          return Stack(
            children: <Widget>[
              model.issueBall.ballDeleteFlag
                  ? Container(key: UniqueKey(), height: 0)
                  : Container(
                      key: UniqueKey(),
                      margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          model.goIssueDetailPage();
                        },
                        child: Column(children: <Widget>[
                          ballHeader(model, context),
                          divider(),
                          !model.issueBall.ballDeleteFlag
                              ? ballMainPicture(model, context)
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
                                Text(model.issueBall.getDisplayLikeCount(),
                                    style: GoogleFonts.notoSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Color(0xff78849e),
                                    )),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(5, 0, 0, 1),
                                    child: Icon(ForutonaIcon.thumbsup,
                                        color: Color(0xff78849E), size: 17)),
                                SizedBox(width: 19),
                                Text(model.issueBall.getDisplayDisLikeCount(),
                                    style: GoogleFonts.notoSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Color(0xff78849e),
                                    )),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                    child: Icon(ForutonaIcon.thumbsdown,
                                        color: Color(0xff78849E), size: 17)),
                                SizedBox(width: 19),
                                Text(model.issueBall.getDisplayCommentCount(),
                                    style: GoogleFonts.notoSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Color(0xff78849e),
                                    )),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                    child: Icon(ForutonaIcon.comment,
                                        color: Color(0xff78849E), size: 17)),
                                SizedBox(width: 19),
                                Text(model.issueBall.getDisplayRemainingTime(),
                                    style: GoogleFonts.notoSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Color(0xff78849e),
                                    )),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
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
              model.isLoading ? CommonLoadingComponent() : Container()
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
      IssueBallWidgetStyle1ViewModel model, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 64,
      padding: EdgeInsets.only(bottom: 23),
      child: Text(model.issueBall.getDisplayDescriptionText(),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.notoSans(
            fontSize: 14,
            color: Color(0xff454F63),
          )),
    );
  }

  Container ballProfileBar(IssueBallWidgetStyle1ViewModel model) {
    return Container(
      height: 60,
      padding: EdgeInsets.fromLTRB(14, 15, 14, 15),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 4,
            left: 0,
            child: Container(
              height: 25.00,
              width: 25.00,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(model.issueBall.profilePictureUrl)),
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.00, color: Color(0xffdc3e57))),
            ),
          ),
          Positioned(
            left: 34,
            top: 0,
            child: Text(model.issueBall.getDisplayNickName(),
                style: TextStyle(
                  fontFamily: "Gibson",
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Color(0xff454f63),
                )),
          ),
          Positioned(
            left: 34,
            top: 16,
            child: Text(model.issueBall.getDisplayMakeTime(),
                style: GoogleFonts.notoSans(
                  fontSize: 10,
                  color: Color(0xff454f63),
                )),
          )
        ],
      ),
    );
  }

  Widget ballMainPicture(
      IssueBallWidgetStyle1ViewModel model, BuildContext context) {
    return model.issueBall.isMainPicture()
        ? Stack(children: <Widget>[
            FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: () {
                  model.gotoBallImageViewer();
                },
                child: Hero(
                    tag: model.issueBall.ballUuid + "picturefromBigpicture",
                    child: CachedNetworkImage(
                      imageUrl: model.issueBall.mainPictureSrc(),
                      imageBuilder: (context, imageProvider) => Container(
                          height: 200.00,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            image: imageProvider,
                          ))),
                      placeholder: (context, url) => Container(
                        height: 200,
                        child: Container(
                          color: Color(0xfff2f0f1),
                          child: Center(
                            child: Icon(
                              ForutonaIcon.imageloding,
                              color: Color(0xffE4E7E8),
                              size: 100,
                            ),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ))),
            model.issueBall.pictureCount() > 1
                ? Positioned(
                    bottom: 10,
                    right: 10,
                    child: Hero(
                      tag: model.issueBall.ballUuid + "picturefrombutton",
                      child: Container(
                          child: FlatButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return BallImageViewer(
                                    model.issueBall.getDesImages(),
                                    model.issueBall.ballUuid +
                                        "picturefrombutton");
                              }));
                            },
                            padding: EdgeInsets.all(0),
                            child:
                                Text("+${model.issueBall.pictureCount() - 1}",
                                    style: GoogleFonts.notoSans(
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

  Container ballHeader(
      IssueBallWidgetStyle1ViewModel model, BuildContext context) {
    return Container(
      height: 68,
      child: Stack(children: <Widget>[
        Positioned(
          top: 2,
          left: 0,
          child: Container(
              padding: EdgeInsets.only(left: 2, top: 1),
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
            left: 44,
            width: MediaQuery.of(context).size.width - 100,
            child: Container(
                child: Text(model.issueBall.getDisplayBallName(),
                    style: GoogleFonts.notoSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color(0xff454f63),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis))),
        Positioned(
          top: 19,
          left: 44,
          width: MediaQuery.of(context).size.width - 100,
          child: Container(
            child: Text(model.issueBall.placeAddress,
                style: GoogleFonts.notoSans(
                  fontSize: 12,
                  color: Color(0xff78849E),
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
                style: GoogleFonts.notoSans(
                  fontSize: 10,
                  color: Color(0xffFF4F9A),
                )),
          ),
        )
      ]),
      padding: EdgeInsets.fromLTRB(13, 16, 12, 14),
    );
  }
}
