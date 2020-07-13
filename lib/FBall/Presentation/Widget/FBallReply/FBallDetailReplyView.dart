import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forutonafront/Common/TimeUitl/TimeDisplayUtil.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallReply/FBallReplyUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/FBallReplyMediator.dart';


import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'FBallDetailReplyViewModel.dart';

class FBallDetailReplyView extends StatelessWidget {
  final String ballUuid;
  final FBallReplyMediator _fBallReplyMediator;
  FBallDetailReplyView(this.ballUuid,this._fBallReplyMediator);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => FBallDetailReplyViewModel(
          fBallReplyMediator: _fBallReplyMediator,
          ballUuid: ballUuid,
          context: context
        ),
        child: Consumer<FBallDetailReplyViewModel>(builder: (_, model, child) {
          return Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                margin: EdgeInsets.only(top: 140),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(bottom: 10),
                      color: Color(0xffF2F0F1),
                      width: MediaQuery.of(context).size.width,
                      height: 38,
                      padding: EdgeInsets.fromLTRB(16, 12, 16, 10),
                      child: Text(
                        "댓글( ${_fBallReplyMediator.totalReplyCount} )",
                          style: GoogleFonts.notoSans(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: Color(0xff454f63),
                          ))),
                  Expanded(
                      child: Container(
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        controller: model.replyScrollerController,
                        shrinkWrap: true,
                        padding: EdgeInsets.all(0),
                        itemCount: _fBallReplyMediator.replyList.length,
                        itemBuilder: (context, index) {
                          return model.replyContentBars[index];
                        }
                  ))),
                  Container(
                    padding: EdgeInsets.fromLTRB(16,10,16,10),
                    width: MediaQuery.of(context).size.width,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Color(0xffF5F5F5),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child:Container(
                            alignment: Alignment.centerLeft,
                            child: FlatButton(
                              onPressed: model.popupInsertReply,
                              child: Row(
                                children: <Widget>[
                                  Text("의견을 남겨주세요.",style: GoogleFonts.notoSans(
                                    fontSize: 12,
                                    color:Color(0xff78849e),
                                  ))
                                ],
                              )
                            ),
                            margin: EdgeInsets.only(right: 16),
                            height: 32.00,
                            decoration: BoxDecoration(
                              color: Color(0xfff9f9f9),borderRadius: BorderRadius.circular(12.00),
                            ),
                          )
                        ),
                        Container(
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
                            ))


                      ],
                    ),
                  )

                ]),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ));
        }));
  }






}
