import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallReply.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/Mediator/FBallReplyMediator.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/Popup/FBallReplyDeletePopupModel.dart';

import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FBallReplyDeletePopupView extends StatelessWidget {
  final FBallReply _fBallReply;
  final FBallReplyMediator _fBallReplyMediator;

  FBallReplyDeletePopupView(this._fBallReply, this._fBallReplyMediator);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FBallReplyDeletePopupViewModel(
        context: context,
          fBallReply: _fBallReply, fBallReplyMediator: _fBallReplyMediator),
      child: Consumer<FBallReplyDeletePopupViewModel>(
        builder: (_, model, child) {
          return Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width - 52,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Icon(
                            ForutonaIcon.removepath,
                            size: 35,
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(bottom: 36),
                          child: Text("삭제 하시겠습니까?")),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: cancelBtn(context),
                          ),
                          Expanded(child: deleteBtn(model))
                        ],
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                ),
              ));
        },
      ),
    );
  }

  Container deleteBtn(FBallReplyDeletePopupViewModel model) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: Color(0xffE4E7E8), width: 1),
              left: BorderSide(color: Color(0xffE4E7E8), width: 1))),
      child: FlatButton(
        onPressed: () {
          model.replyDelete();
        },
        child: Text(
          "삭제",
          style: GoogleFonts.notoSans(
            fontSize: 15,
            color: const Color(0xff3497fd),
            fontWeight: FontWeight.w500,
            height: 1.3333333333333333,
          ),
        ),
      ),
    );
  }

  Container cancelBtn(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: Color(0xffE4E7E8), width: 1),
              left: BorderSide(color: Color(0xffE4E7E8), width: 1))),
      child: FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text("취소",style: GoogleFonts.notoSans(
          fontSize: 15,
          color: const Color(0xff454f63),
          fontWeight: FontWeight.w500,
          height: 1.3333333333333333,
        )),
      ),
    );
  }
}
