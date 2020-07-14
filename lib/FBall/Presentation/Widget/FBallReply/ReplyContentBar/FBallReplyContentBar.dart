import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallReply.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/Mediator/FBallReplyMediator.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/Popup/FBallReplyPopupUseCaseInputPort.dart';

import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'FBallReplyContentBarViewModel.dart';

class FBallReplyContentBar extends StatelessWidget {
  final FBallReply fBallReply;
  final BuildContext context;

  final FBallReplyMediator _fBallReplyMediator;
  final FBallReplyPopupUseCaseInputPort _fBallReplyPopupUseCaseInputPort;

  FBallReplyContentBar(
      {this.context,
      this.fBallReply,
      @required FBallReplyPopupUseCaseInputPort fBallReplyPopupUseCaseInputPort,
      @required FBallReplyMediator fBallReplyMediator})
      : _fBallReplyMediator = fBallReplyMediator,
        _fBallReplyPopupUseCaseInputPort = fBallReplyPopupUseCaseInputPort;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => FBallReplyContentBarViewModel(
            fBallReply: fBallReply,
            context: context,
            signInUserInfoUseCaseInputPort: sl(),
            fBallReplyMediator: _fBallReplyMediator,
            fBallReplyPopupUseCaseInputPort: _fBallReplyPopupUseCaseInputPort,
            authUserCaseInputPort: sl()),
        child: Consumer<FBallReplyContentBarViewModel>(builder: (_, model, child) {
          return Column(key: Key(fBallReply.replyUuid), children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                        padding: EdgeInsets.only(top: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            avatarWidget(),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(children: <Widget>[
                                    replyWriterNickName()
                                  ]),
                                  SizedBox(height: 2),
                                  Row(children: <Widget>[
                                    Expanded(child: replyContent())
                                  ]),
                                  Row(children: <Widget>[
                                    Container(child: replyUploadTime())
                                  ]),
                                ],
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          model.insertSubReply();
                        }),
                  ),
                  optionBtn(model)
                ]),
            hasSubReply() ? subReplyColumn(model) : Container()
          ]);
        }));
  }

  Container optionBtn(FBallReplyContentBarViewModel model) {
    return Container(
        width: 30,
        alignment: Alignment.topCenter,
        child: IconButton(
            padding: EdgeInsets.all(0),
            onPressed: () {
              model.popupOptionBtn();
            },
            icon: Icon(
              ForutonaIcon.pointdash,
              size: 15,
            )));
  }

  Container subReplyColumn(FBallReplyContentBarViewModel model) {
    return Container(
      margin: EdgeInsets.only(left: 56, bottom: 16),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[subReplySwitch(model)],
          ),
          Column(
            children: model.subReplyContentBar,
          ),
        ],
      ),
    );
  }

  bool hasSubReply() => fBallReply.subReplyCount > 0;

  Container subReplySwitch(FBallReplyContentBarViewModel model) {
    return Container(
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: () {
          model.toggleSubReplyOpenFlag();
        },
        child: RichText(
          text: TextSpan(
              text: model.isOpenSubReply ? "▲" : "▼",
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.w700,
                fontSize: 10,
                color: Color(0xff3497fd),
              ),
              children: [
                TextSpan(
                    text: "답글 보기(${fBallReply.subReplyCount})",
                    style: GoogleFonts.notoSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                      color: Color(0xff3497fd),
                    )),
              ]),
        ),
      ),
    );
  }

  Container replyUploadTime() {
    return Container(
      margin: EdgeInsets.only(bottom: 9),
      child: Text(fBallReply.replyUploadDateTimeString,
          style: GoogleFonts.notoSans(
            fontSize: 9,
            color: const Color(0xffb1b1b1),
            height: 1.7777777777777777,
          )),
    );
  }

  Container replyContent() {
    return Container(
        child: Text(fBallReply.replyText,
            style: GoogleFonts.notoSans(
              fontSize: 10,
              color: Color(0xff454f63),
            )));
  }

  Container replyWriterNickName() {
    return Container(
        child: Text(fBallReply.userNickName,
            style: GoogleFonts.notoSans(
              fontWeight: FontWeight.w700,
              fontSize: 11,
              color: Color(0xff454f63),
            )));
  }

  Container avatarWidget() {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
      width: 32,
      height: 32,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: NetworkImage(fBallReply.userProfilePictureUrl),
              fit: BoxFit.fitWidth)),
    );
  }
}
