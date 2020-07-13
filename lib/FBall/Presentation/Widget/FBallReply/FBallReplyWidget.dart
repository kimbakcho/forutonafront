import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/FBallReplyMediator.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/FBallReplyWidgetViewModel.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FBallReplyWidget extends StatelessWidget {
  final String ballUuid;

  FBallReplyWidget(this.ballUuid);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => FBallReplyWidgetViewModel(
            context: context,
            ballUuid: ballUuid,
            fBallReplyMediator: FBallReplyMediator(
              fBallReplyUseCaseInputPort: sl()
            ),
            authUserCaseInputPort: sl()),
        child: Consumer<FBallReplyWidgetViewModel>(builder: (_, model, child) {
          return Column(children: <Widget>[
            topInputBar(model, context),
            Column(
              children: model.replySimpleWidget,
            )
          ]);
        }));
  }

  Container topInputBar(FBallReplyWidgetViewModel model, BuildContext context) {
    return Container(
        height: 103,
        decoration: BoxDecoration(color: Color(0xffF5F5F5)),
        child: Stack(children: <Widget>[
          Positioned(
              top: 16,
              left: 16,
              child: Container(
                  child: Text(
                "댓글(${model.fBallReplyMediator.totalReplyCount})",
                style: GoogleFonts.notoSans(
                    fontSize: 14, fontWeight: FontWeight.bold),
              ))),
          Positioned(
              top: 0,
              right: 6,
              child: Container(
                  margin: EdgeInsets.only(bottom: 16, right: 16),
                  child: FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: model.popUpDetailReply,
                      child: Text("댓글 페이지로 이동",
                          style: GoogleFonts.notoSans(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: Color(0xff3497fd),
                          ))))),
          Positioned(
              top: 47,
              width: MediaQuery.of(context).size.width,
              child: Container(
                  height: 32.00,
                  margin: EdgeInsets.fromLTRB(16, 0, 63, 0),
                  child: FlatButton(
                      onPressed: model.popupInputDisplay,
                      padding: EdgeInsets.all(0),
                      child: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 16),
                          height: 32.00,
                          child: Text("의견을 남겨주세요.",
                              style: GoogleFonts.notoSans(
                                fontSize: 14,
                                color: Color(0xff78849e),
                              )))),
                  decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(12.00)))),
          Positioned(
              top: 47,
              right: 19,
              child: Container(
                  width: 30,
                  height: 30,
                  child: FlatButton(
                    padding: EdgeInsets.fromLTRB(0, 0, 6, 0),
                    onPressed: () {},
                    shape: CircleBorder(),
                    child: Icon(ForutonaIcon.replysendicon,
                        color: Color(0xffB1B1B1), size: 13),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xffE4E7E8),
                    shape: BoxShape.circle,
                  )))
        ]));
  }
}
