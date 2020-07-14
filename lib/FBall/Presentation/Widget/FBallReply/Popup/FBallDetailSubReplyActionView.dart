import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/Common/TimeUitl/TimeDisplayUtil.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallReply.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/Popup/FBallDetailSubReplyInputActionViewModel.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply/Popup/FBallReplyRootActionCommand.dart';

import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FBallDetailSubReplyActionView extends StatelessWidget {
  final FBallReply _rootFBallReply;
  final FBallReplyRootActionCommand _fBallReplyRootActionCommand;

  FBallDetailSubReplyActionView(this._rootFBallReply ,this._fBallReplyRootActionCommand);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => FBallDetailSubReplyActionViewModel(
            context: context,
            fBallReplyRootActionCommand: _fBallReplyRootActionCommand),
        child: Consumer<FBallDetailSubReplyActionViewModel>(
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
                                            fit: BoxFit.fitWidth,
                                            image: NetworkImage(_rootFBallReply
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
                                            child: Text(_rootFBallReply.userNickName,
                                                style: GoogleFonts.notoSans(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 11,
                                                  color: Color(0xff454f63),
                                                )),
                                            margin: EdgeInsets.fromLTRB(
                                                16, 0, 16, 0),
                                          )),
                                        ]),
                                        Container(
                                            margin: EdgeInsets.fromLTRB(
                                                16, 0, 32, 3),
                                            child: Text(_rootFBallReply.replyText,
                                                style: GoogleFonts.notoSans(
                                                  fontSize: 10,
                                                  color: Color(0xff454f63),
                                                ))),
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            margin: EdgeInsets.fromLTRB(
                                                16, 0, 32, 16),
                                            child: Text(
                                                TimeDisplayUtil
                                                    .getCalcToStrFromNow(_rootFBallReply
                                                        .replyUploadDateTime),
                                                style: GoogleFonts.notoSans(
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
                                        maxLength: 300,
                                        onSubmitted: (String value) {
                                          model.execute();
                                        },
                                        keyboardType: TextInputType.text,
                                        controller: model.subReplyController,
                                        autofocus: true,
                                        decoration: InputDecoration(
                                            counter: Container(),
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
                                  model.execute();
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
