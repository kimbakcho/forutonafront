import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/Common/TimeUitl/TimeDisplayUtil.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallSubReplyResDto.dart';
import 'package:forutonafront/FBall/Widget/FBallReply/FBallDetailSubReplyInputViewModel.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:provider/provider.dart';

class FBallDetailSubReplyInputView extends StatelessWidget {
  final FBallSubReplyResDto mainReply;

  FBallDetailSubReplyInputView(this.mainReply);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => FBallDetailSubReplyInputViewModel(mainReply, context),
        child: Consumer<FBallDetailSubReplyInputViewModel>(
            builder: (_, model, child) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: <Widget>[
                Positioned(
                    bottom: 0,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: <Widget>[
                        Container(
                            color: Colors.white,
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: 16, top: 16),
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: NetworkImage(mainReply
                                                .userProfilePictureUrl))),
                                  ),
                                  Expanded(
                                      child: Container(
                                    margin: EdgeInsets.only(top: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(children: <Widget>[
                                          Expanded(
                                              child: Container(
                                            child: Text(mainReply.userNickName,
                                                style: TextStyle(
                                                  fontFamily:
                                                      "Noto Sans CJK KR",
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 11,
                                                  color: Color(0xff454f63),
                                                )),
                                            margin: EdgeInsets.fromLTRB(
                                                16, 0, 16, 0),
                                          )),
                                          Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle),
                                            margin: EdgeInsets.only(right: 16),
                                            child: FlatButton(
                                              shape: CircleBorder(),
                                              padding: EdgeInsets.all(0),
                                              onPressed: () {},
                                              child: Icon(
                                                ForutonaIcon.pointdash,
                                                color: Color(0xff454F63),
                                                size: 16,
                                              ),
                                            ),
                                            width: 20,
                                            height: 20,
                                          )
                                        ]),
                                        Container(
                                            margin: EdgeInsets.fromLTRB(
                                                16, 0, 32, 3),
                                            child: Text(mainReply.replyText,
                                                style: TextStyle(
                                                  fontFamily:
                                                      "Noto Sans CJK KR",
                                                  fontSize: 10,
                                                  color: Color(0xff454f63),
                                                ))),
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            margin: EdgeInsets.fromLTRB(
                                                16, 0, 32, 16),
                                            child: Text(
                                                TimeDisplayUtil
                                                    .getRemainingToStrFromNow(
                                                        mainReply
                                                            .replyUploadDateTime),
                                                style: TextStyle(
                                                  fontFamily:
                                                      "Noto Sans CJK KR",
                                                  fontSize: 9,
                                                  color: Color(0xffb1b1b1),
                                                ))),
                                      ],
                                    ),
                                  ))
                                ])),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(children: <Widget>[
                            Expanded(
                                child: Container(
                                    margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
                                    child: TextField(
                                        keyboardAppearance: Brightness.dark,
                                        minLines: 1,
                                        maxLines: 4,
                                        controller: model.subReplyController,
                                        autofocus: true,
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                16, 5, 16, 5),
                                            isDense: true,
                                            fillColor: Colors.white,
                                            filled: true,
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xff3497FD)),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12))),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xff3497FD)),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12))))))),
                            Container(
                              width: 30,
                              height: 30,
                              margin: EdgeInsets.only(right: 16),
                              child: FlatButton(
                                onPressed: () {
                                  model.sendSubReply(mainReply);
                                },
                                shape: CircleBorder(),
                                padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                child: Icon(
                                  ForutonaIcon.replysendicon,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff3497FD).withOpacity(0.8)),
                            )
                          ]),
                          decoration: BoxDecoration(color: Color(0xffF2F0F1)),
                        )
                      ],
                    )),
                model.getIsLoading() ? CommonLoadingComponent() : Container()
              ],

            ),
          );
        }));
  }
}
