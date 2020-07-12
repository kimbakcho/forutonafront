import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallReply.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/FBallDetailSubReplyInputView.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseInputPort.dart';
import 'package:forutonafront/JCodePage/J001/J001View.dart';
import 'package:forutonafront/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';

class FBallReplyContentBar extends StatelessWidget {
  final FBallReply fBallReply;
  final BuildContext context;
  final List<FBallReplyContentBar> fBallReplyContentBars = [];
  final AuthUserCaseInputPort _authUserCaseInputPort;

  FBallReplyContentBar({this.context,
    this.fBallReply,
    AuthUserCaseInputPort authUserCaseInputPort})
      : _authUserCaseInputPort = authUserCaseInputPort;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: UniqueKey(),
      body: Container(
        child: FlatButton(child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            isRootReply() ?
            avatarWidget(32) : avatarWidget(24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(children: <Widget>[
                    Container(
                        child: Text(fBallReply.userNickName,
                            style: GoogleFonts.notoSans(
                              fontWeight: FontWeight.w700,
                              fontSize: 11,
                              color: Color(0xff454f63),
                            )))
                  ]),
                  SizedBox(height: 2),
                  Row(children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width - 92,
                        child: Text(fBallReply.replyText,
                            style: GoogleFonts.notoSans(
                              fontSize: 10,
                              color: Color(0xff454f63),
                            )))
                  ]),
                ],
              ),
            )
          ],
        ), onPressed: tapReply),
      ),
    );
  }

  Container avatarWidget(double size) {
    return Container(
      width: size,
      height: size,
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
        jumpToJ001();
      } else {
        FBallReplyResDto resDto = await showInputDialog();
        if (hasInsertData(resDto)) {
          fBallReply.fBallReplys.add(resDto);
          fBallReplyContentBars.add(FBallReplyContentBar(
              context: context,
              authUserCaseInputPort: sl(),
              fBallReply: resDto));
        }
      }
    }
  }

  bool hasInsertData(FBallReplyResDto resDto) => resDto != null;

  bool isRootReply() => fBallReplyResDto.replySort != 0;

  Future<FBallReplyResDto> showInputDialog() async {
    return await showGeneralDialog(
        context: context,
        barrierDismissible: true,
        transitionDuration: Duration(milliseconds: 300),
        barrierColor: Colors.black.withOpacity(0.3),
        barrierLabel: MaterialLocalizations
            .of(context)
            .modalBarrierDismissLabel,
        pageBuilder: (_context, Animation animation,
            Animation secondaryAnimation) {
          return FBallDetailSubReplyInputView(
              fBallReplyResDto);
        });
  }

  void jumpToJ001() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => J001View(), settings: RouteSettings(name: "/J001")));
  }
}
