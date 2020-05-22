import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResWrapDto.dart';
import 'package:forutonafront/FBall/Repository/FBallReplyRepository.dart';
import 'package:forutonafront/FBall/Widget/FBallReply/FBallDetailReplyView.dart';
import 'package:forutonafront/FBall/Widget/FBallReply/FBallInputReplyView.dart';
import 'package:forutonafront/FBall/Widget/FBallReply/FBallReplyContentBar.dart';
import 'package:forutonafront/JCodePage/J001/J001View.dart';

class FBallReplyWidgetViewModel extends ChangeNotifier {
  FBallReplyResWrapDto fBallReplyResWrapDto;
  List<FBallReplyContentBar> replyContentBar = [];

  final String ballUuid;
  BuildContext _context;

  FBallReplyWidgetViewModel(this.ballUuid, this._context) {
    loadTop3Reply();
  }

  void loadTop3Reply() async {
    FBallReplyReqDto reqDto = new FBallReplyReqDto();
    reqDto.ballUuid = ballUuid;
    reqDto.detail = false;
    reqDto.size = 3;
    reqDto.page = 0;
    FBallReplyRepository fBallReplyRepository = FBallReplyRepository();
    this.fBallReplyResWrapDto =
        await fBallReplyRepository.getFBallReply(reqDto);
    if (reqDto.page == 0) {
      replyContentBar.clear();
    }
    replyContentBar.addAll(this
        .fBallReplyResWrapDto
        .contents
        .map((e) => FBallReplyContentBar(e))
        .toList());
    notifyListeners();
  }

  getReplyTotalCount() {
    if (this.fBallReplyResWrapDto != null) {
      return this.fBallReplyResWrapDto.replyTotalCount;
    } else {
      return 0;
    }
  }

  Future<void> popupInputDisplay() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    if (firebaseUser != null) {
      await showGeneralDialog(
          context: _context,
          barrierDismissible: true,
          transitionDuration: Duration(milliseconds: 300),
          barrierColor: Colors.black.withOpacity(0.3),
          barrierLabel:
              MaterialLocalizations.of(_context).modalBarrierDismissLabel,
          pageBuilder:
              (_context, Animation animation, Animation secondaryAnimation) {
            FBallReplyInsertReqDto reqDto = new FBallReplyInsertReqDto();
            reqDto.ballUuid = ballUuid;
            return FBallInputReplyView(reqDto);
          });
      loadTop3Reply();
    } else {
      Navigator.push(
          _context,
          MaterialPageRoute(
              settings: RouteSettings(name: "/J001"),
              builder: (context) {
                return J001View();
              }));
    }
  }

  void popUpDetailReply() async {
      await showGeneralDialog(
          context: _context,
          barrierDismissible: true,
          transitionDuration: Duration(milliseconds: 300),
          barrierColor: Colors.black.withOpacity(0.3),
          barrierLabel:
              MaterialLocalizations.of(_context).modalBarrierDismissLabel,
          pageBuilder:
              (_context, Animation animation, Animation secondaryAnimation) {
            return FBallDetailReplyView(ballUuid);
          });
      loadTop3Reply();
  }
}
