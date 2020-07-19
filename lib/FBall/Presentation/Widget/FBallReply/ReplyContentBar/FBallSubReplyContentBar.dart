import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallReply.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/Popup/FBallReplyPopupUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/ReplyContentBar/FBallSubReplyContentBarViewModel.dart';

import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FBallSubReplyContentBar extends StatelessWidget {
  final FBallReply fBallReply;
  final FBallReplyPopupUseCaseInputPort _fBallReplyPopupUseCaseInputPort;

  FBallSubReplyContentBar(
      this.fBallReply, this._fBallReplyPopupUseCaseInputPort);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FBallSubReplyContentBarViewModel(
          fBallReply: fBallReply,
          fBallReplyPopupUseCaseInputPort: _fBallReplyPopupUseCaseInputPort,
          authUserCaseInputPort: sl(),
          context: context,
          signInUserInfoUseCaseInputPort: sl()),
      child: Consumer<FBallSubReplyContentBarViewModel>(
          builder: (_, model, child) {
        return Container(
          margin: EdgeInsets.only(top: 8),
          key: Key(fBallReply.replyUuid),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              avatarWidget(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[replyWriterNickName()],
                    ),
                    SizedBox(height: 2),
                    Row(children: <Widget>[Expanded(child: replyContent())]),
                    Row(children: <Widget>[
                      Container(child: replyUploadTime())
                    ]),
                  ],
                ),
              ),
              optionBtn(model)
            ],
          ),
        );
      }),
    );
  }

  Container optionBtn(FBallSubReplyContentBarViewModel model) {
    return Container(
        width: 30,
        height: 10,
        alignment: Alignment.topLeft,
        child: IconButton(
            padding: EdgeInsets.all(0),
            onPressed: () {
              model.optionPopup();
            },
            icon: Icon(
              ForutonaIcon.pointdash,
              size: 10,
            )));
  }

  Container replyWriterNickName() {
    return Container(
      margin: EdgeInsets.only(left: 8),
      child: Text(
        fBallReply.userNickName,
        style: GoogleFonts.notoSans(
          fontSize: 11,
          color: Color(0xff454f63),
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }

  Container replyContent() {
    return Container(
        margin: EdgeInsets.only(left: 8),
        child: Text(fBallReply.replyText,
            style: GoogleFonts.notoSans(
              fontSize: 10,
              color: Color(0xff454f63),
            )));
  }

  Container replyUploadTime() {
    return Container(
      margin: EdgeInsets.only(left: 8),
      child: Text(fBallReply.replyUploadDateTimeString,
          style: GoogleFonts.notoSans(
            fontSize: 9,
            color: const Color(0xffb1b1b1),
            height: 1.7777777777777777,
          )),
    );
  }

  Container avatarWidget() {
    return Container(
      width: 21,
      height: 21,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: NetworkImage(fBallReply.userProfilePictureUrl),
              fit: BoxFit.fitWidth)),
    );
  }
}
