import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallReply.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/FBallReplyContentViewModel.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/FBallReplyMediator.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseInputPort.dart';
import 'package:forutonafront/JCodePage/J001/J001View.dart';
import 'package:forutonafront/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FBallReplyContentBar extends StatelessWidget {
  final FBallReply fBallReply;
  final BuildContext context;
  final AuthUserCaseInputPort _authUserCaseInputPort;
  final FBallReplyMediator _fBallReplyMediator;

  FBallReplyContentBar(
      {this.context,
      this.fBallReply,
      AuthUserCaseInputPort authUserCaseInputPort,
      FBallReplyMediator fBallReplyMediator})
      : _authUserCaseInputPort = authUserCaseInputPort,
        _fBallReplyMediator = fBallReplyMediator;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => FBallReplyContentViewModel(
            fBallReply: fBallReply,
            fBallReplyMediator: _fBallReplyMediator,
            authUserCaseInputPort: sl()),
        child: Consumer<FBallReplyContentViewModel>(builder: (_, model, child) {
          return Column(key: Key(fBallReply.replyUuid), children: <Widget>[
            FlatButton(
                padding: EdgeInsets.all(0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    avatarWidget(),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(children: <Widget>[replyWriterNickName()]),
                          SizedBox(height: 2),
                          Row(children: <Widget>[
                            Expanded(child: replyContent())
                          ]),
                          Row(children: <Widget>[
                            Container(child: replyUploadTime())
                          ]),
                        ],
                      ),
                    )
                  ],
                ),
                onPressed: tapReply),
            Row(
              children: <Widget>[subReplySwitch(model)],
            ),
            Column(
              children: model.subReplyContentBar,
            )
          ]);
        }));
  }

  Container subReplySwitch(FBallReplyContentViewModel model) {
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

  Text replyUploadTime() {
    return Text(fBallReply.replyUploadDateTimeString,
        style: GoogleFonts.notoSans(
          fontSize: 9,
          color: const Color(0xffb1b1b1),
          height: 1.7777777777777777,
        ));
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

  void tapReply() async {
    if (isRootReply()) {
      if (await _authUserCaseInputPort.isLogin()) {
        FBallReplyResDto resDto = await showInputDialog();
        if (hasInsertData(resDto)) {
//          fBallReply.fBallReplys.add(resDto);
//          fBallReplyContentBars.add(FBallReplyContentBar(
//              context: context,
//              authUserCaseInputPort: sl(),
//              fBallReplyMediator: _fBallReplyMediator,
//              fBallReply: ,));
        }
      } else {
        jumpToJ001();
      }
    }
  }

  bool hasInsertData(FBallReplyResDto resDto) => resDto != null;

  bool isRootReply() => fBallReply.replySort == 0;

  Future<FBallReplyResDto> showInputDialog() async {
//    return await showGeneralDialog(
//        context: context,
//        barrierDismissible: true,
//        transitionDuration: Duration(milliseconds: 300),
//        barrierColor: Colors.black.withOpacity(0.3),
//        barrierLabel:
//            MaterialLocalizations.of(context).modalBarrierDismissLabel,
//        pageBuilder:
//            (_context, Animation animation, Animation secondaryAnimation) {
//          return FBallDetailSubReplyInputView(fBallReplyResDto);
//        });
  }

  void jumpToJ001() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => J001View(), settings: RouteSettings(name: "/J001")));
  }
}
