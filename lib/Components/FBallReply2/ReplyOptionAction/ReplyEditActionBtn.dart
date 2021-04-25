import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBallReply/Dto/FBallReply/FBallReplyResDto.dart';

import 'package:google_fonts/google_fonts.dart';

import '../ReviewUpdateMediator.dart';
import 'BasicReViewUpdate.dart';

class ReplyEditActionBtn extends StatelessWidget {
  final FBallReplyResDto _fBallReplyResDto;
  final ReviewUpdateMediator _reviewUpdateMediator;
  final Function updateFinish;

  const ReplyEditActionBtn({
    FBallReplyResDto fBallReplyResDto,
    ReviewUpdateMediator reviewUpdateMediator,
    Key key, this.updateFinish,
  })  : _fBallReplyResDto = fBallReplyResDto,
        _reviewUpdateMediator = reviewUpdateMediator,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(child: InkWell(
          onTap: () async {
            Navigator.of(context).pop();
            await showModalBottomSheet(
              context: context,
              builder: (_) =>
                  BasicReViewUpdate(fBallReplyResDto: _fBallReplyResDto,reviewUpdateMediator: _reviewUpdateMediator,),
            );


          },
          child: Container(
            alignment: AlignmentDirectional.center,
            height: 50,
            child: Text(
              "수정 하기",
            ),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xffE4E7E8)))),
          )))

    ]);
  }
}
