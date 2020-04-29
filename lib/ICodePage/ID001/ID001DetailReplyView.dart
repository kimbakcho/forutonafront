import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forutonafront/Common/TimeUitl/TimeDisplayUtil.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:provider/provider.dart';

import 'ID001DetailReplyViewModel.dart';

class ID001DetailReplyView extends StatelessWidget {
  final String ballUuid;

  ID001DetailReplyView(this.ballUuid);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ID001DetailReplyViewModel(ballUuid,context),
        child: Consumer<ID001DetailReplyViewModel>(builder: (_, model, child) {
          return Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(children: <Widget>[
                Positioned(
                  bottom: 0,
                  left: 0,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 139,
                  child: Container(
                    child: Column(children: <Widget>[
                      Container(
                          color: Color(0xffF2F0F1),
                          width: MediaQuery.of(context).size.width,
                          height: 38,
                          padding: EdgeInsets.fromLTRB(16, 12, 16, 10),
                          child: Text(
                              model.fBallReplyResWrapDto.replyTotalCount != null
                                  ? "댓글( ${model.fBallReplyResWrapDto.replyTotalCount} )"
                                  : "로딩중",
                              style: TextStyle(
                                fontFamily: "Noto Sans CJK KR",
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
                            itemCount: model.detailReply.length,
                            itemBuilder: (context, index) {
                              return Container(
                                child: Column(children: <Widget>[
                                  mainReplyBar(model, index, context),
                                  subReplyToggleBar(model, index),
                                  model.detailReply[index].replyOpenFlag
                                      ? subReplyBar(model, index)
                                      : Container()
                                ]),
                                padding: EdgeInsets.only(bottom: 16, top: 16),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1,
                                            color: Color(0xffF2F0F1)))),
                              );
                            }),
                      ))
                    ]),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                )
              ]));
        }));
  }

  ListView subReplyBar(ID001DetailReplyViewModel model, int index) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: model.detailReply[index].subReply.length,
        shrinkWrap: true,
        itemBuilder: (context, subIndex) {
          return Container(
            margin: EdgeInsets.fromLTRB(55, 0, 16, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: 21,
                    height: 21,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(model.detailReply[index]
                                .subReply[subIndex].userProfilePictureUrl)))),
                Expanded(
                    child: Container(
                        child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: Container(
                          child: Text(
                              model.detailReply[index].subReply[subIndex]
                                  .userNickName,
                              style: TextStyle(
                                fontFamily: "Noto Sans CJK KR",
                                fontWeight: FontWeight.w700,
                                fontSize: 11,
                                color: Color(0xff454f63),
                              )),
                          margin: EdgeInsets.only(left: 8),
                        )),
                        Container(
                          width: 12,
                          height: 12,
                          child: FlatButton(
                            onPressed: () async {
                              if(model.detailReply[index].subReply[subIndex].deleteFlag){
                                return ;
                              }
                              var firebaseUser = await FirebaseAuth.instance.currentUser();
                              if(model.detailReply[index].subReply[subIndex].uid == firebaseUser.uid){
                                model.modifyPopup(model.detailReply[index].subReply[subIndex]);
                              }else {
                                model.reportPopup(model.detailReply[index].subReply[subIndex]);
                              }

                            },
                            padding: EdgeInsets.all(0),
                            child: Icon(
                              ForutonaIcon.pointdash,
                              size: 10,
                              color: Color(0xff454F63),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 8, right: 16),
                        child: Text(
                            model.detailReply[index].subReply[subIndex]
                                .replyText,
                            style: TextStyle(
                              fontFamily: "Noto Sans CJK KR",
                              fontSize: 10,
                              color: Color(0xff454f63),
                            ))),
                    Container(
                        margin: EdgeInsets.only(left: 8),
                        child: Text(
                            TimeDisplayUtil.getRemainingToStrFromNow(model
                                .detailReply[index]
                                .subReply[subIndex]
                                .replyUploadDateTime),
                            style: TextStyle(
                              fontFamily: "Noto Sans CJK KR",
                              fontSize: 9,
                              color: Color(0xffb1b1b1),
                            )))
                  ],
                )))
              ],
            ),
          );
        });
  }

  Container subReplyToggleBar(ID001DetailReplyViewModel model, int index) {
    return model.detailReply[index].subReply.length != 0
        ? Container(
            margin: EdgeInsets.only(left: 49),
            height: 20,
            alignment: Alignment.centerLeft,
            child: FlatButton(
                onPressed: () {
                  model.replySubOpenFlagToggle(model.detailReply[index]);
                },
                padding: EdgeInsets.all(0),
                child: RichText(
                  text: TextSpan(
                      text: model.detailReply[index].replyOpenFlag ? "▲" : "▼",
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                        color: Color(0xff3497fd),
                      ),
                      children: [
                        TextSpan(
                            text:
                                "답글 숨기기(${model.detailReply[index].subReply.length})",
                            style: TextStyle(
                              fontFamily: "Noto Sans CJK KR",
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                              color: Color(0xff3497fd),
                            )),
                      ]),
                )))
        : Container();
  }

  FlatButton mainReplyBar(
      ID001DetailReplyViewModel model, int index, BuildContext context) {
    return FlatButton(
        padding: EdgeInsets.all(0),
        onPressed: () {
          model.insertSubReply(model.detailReply[index]);
        },
        child: Container(
          child: Row(
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              model.detailReply[index].userProfilePictureUrl))),
                  width: 32,
                  height: 32),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                            child: Container(
                          child: Text(model.detailReply[index].userNickName,
                              style: TextStyle(
                                fontFamily: "Noto Sans CJK KR",
                                fontWeight: FontWeight.w700,
                                fontSize: 11,
                                color: Color(0xff454f63),
                              )),
                        )),
                        Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle
                            ),
                            child: FlatButton(
                              padding: EdgeInsets.all(0),
                              shape: CircleBorder(),
                              onPressed: () async {
                                if(model.detailReply[index].deleteFlag){
                                  return ;
                                }
                                var firebaseUser = await FirebaseAuth.instance.currentUser();
                                if(model.detailReply[index].uid == firebaseUser.uid){
                                  model.modifyPopup(model.detailReply[index]);
                                }else {
                                  model.reportPopup(model.detailReply[index]);

                                }
                              },
                              child: Icon(
                                ForutonaIcon.pointdash,
                                size: 15,
                                color: Color(0xff454F63),
                              ),
                            ))
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 16),
                      child: Text(model.detailReply[index].replyText,
                          style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontSize: 10,
                            color: Color(0xff454f63),
                          )),
                    ),
                    Container(
                      child: Text(
                          TimeDisplayUtil.getRemainingToStrFromNow(
                              model.detailReply[index].replyUploadDateTime),
                          style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontSize: 9,
                            color: Color(0xffb1b1b1),
                          )),
                    )
                  ],
                ),
                width: MediaQuery.of(context).size.width - 75,
                margin: EdgeInsets.only(left: 11),
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        ));
  }
}
