import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResWrapDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallSubReplyResDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/FBallDetailReplyView.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/FBallReplyContentBar.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/FBallReplyWidgetViewController.dart';
import 'package:forutonafront/FBall/Repository/FBallReplyRepository.dart';
import 'package:forutonafront/JCodePage/J001/J001View.dart';

import 'FBallReplyUtil.dart';

class FBallReplyWidgetViewModel extends ChangeNotifier {

  FBallReplyWidgetViewController fBallReplyWidgetViewController =FBallReplyWidgetViewController(FBallReplyResWrapDto(),[]);

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
    fBallReplyWidgetViewController.fBallReplyResWrapDto = await fBallReplyRepository.getFBallReply(reqDto);
    List<FBallSubReplyResDto> replyItems =  FBallReplyUtil()
        .replyResWrapToSubReplyResDtoList(fBallReplyWidgetViewController.fBallReplyResWrapDto);
    if (reqDto.page == 0) {
      fBallReplyWidgetViewController.replyContentBars.clear();
    }
    fBallReplyWidgetViewController.replyContentBars.addAll(replyItems
        .map((e) => FBallReplyContentBar(e,false,true,false,MediaQuery.of(_context).size.width))
        .toList());
    notifyListeners();
  }

  getReplyTotalCount() {
    if (fBallReplyWidgetViewController.fBallReplyResWrapDto != null) {
      return fBallReplyWidgetViewController.fBallReplyResWrapDto.replyTotalCount;
    } else {
      return 0;
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
            return FBallDetailReplyView(ballUuid,fBallReplyWidgetViewController);
          });
      List<FBallReplyContentBar> replyList  = [];
      if(fBallReplyWidgetViewController.replyContentBars.length > 3){
        replyList =  fBallReplyWidgetViewController.replyContentBars.sublist(0,3);
      }else {
        replyList =  fBallReplyWidgetViewController.replyContentBars.sublist(0,
            fBallReplyWidgetViewController.replyContentBars.length);
      }

      fBallReplyWidgetViewController
          .replyContentBars.clear();

      fBallReplyWidgetViewController
          .replyContentBars
          .addAll(replyList.map((e) => FBallReplyContentBar(e.fBallReplyResDto,false,true,false,MediaQuery.of(_context).size.width)));
  }

  void popupInputDisplay() async {
    FBallReplyResDto fBallReplyResDto = await FBallReplyUtil().popupInputDisplay(_context,ballUuid);
    if(fBallReplyResDto != null){
      fBallReplyWidgetViewController.replyContentBars.insert(0,
          FBallReplyContentBar(fBallReplyResDto,false,true,true,MediaQuery.of(_context).size.width)
      );
      if(fBallReplyWidgetViewController.replyContentBars.length>3){
        fBallReplyWidgetViewController.replyContentBars.removeAt(3);
      }
      fBallReplyWidgetViewController.fBallReplyResWrapDto.replyTotalCount++;
    }
  }
}
