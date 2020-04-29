import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:provider/provider.dart';

import 'ID001InputReplyViewModel.dart';

class ID001InputReplyView extends StatelessWidget {
  final FBallReplyInsertReqDto fBallReplyInsertReqDto;
  ID001InputReplyView(this.fBallReplyInsertReqDto);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>ID001InputReplyViewModel(fBallReplyInsertReqDto,context),
      child: Consumer<ID001InputReplyViewModel>(
        builder: (_,model,child){
          return Scaffold(
              backgroundColor: Color(0x00000000),
              body: Stack(children: <Widget>[
                Positioned(
                    left: 0,
                    bottom: 0,
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.fromLTRB(16, 13, 0, 13),
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(right: 16),
                                    child: TextField(
                                        controller: model.replyTextController,
                                        style: TextStyle(fontSize: 20),
                                        autofocus: true,
                                        minLines: 1,
                                        maxLines: 4,
                                        decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                16, 4, 16, 4),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                                borderSide: BorderSide(
                                                    color: Color(0xff3497FD),
                                                    width: 1)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(12)),
                                                borderSide: BorderSide(
                                                    color: Color(0xff3497FD),
                                                    width: 1)))))),
                            Container(
                                width: 30,
                                height: 30,
                                margin: EdgeInsets.only(right: 16),
                                decoration: BoxDecoration(
                                  color: Color(0xff3497FD),
                                  shape: BoxShape.circle,
                                ),
                                child: FlatButton(
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.fromLTRB(0, 0, 6, 0),
                                  onPressed: () async {
                                    if(fBallReplyInsertReqDto.idx != null){
                                      model.updateReply();
                                    }else {
                                      model.insertReply();
                                    }

                                  },
                                  child: Icon(
                                    ForutonaIcon.replysendicon,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ))
                          ],
                        )))
              ]));
        },
      ),
    );
  }
}
