import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply2/ReplyOptionAction/ReplyDeleteActionBtn.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply2/ReplyOptionAction/ReplyEditActionBtn.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply2/ReviewDeleteMediator.dart';

class ReplyOptionActionBottomSheet extends StatelessWidget {
  final FBallReplyResDto _fBallReplyResDto;
  final ReviewDeleteMediator _reviewDeleteMediator;

  const ReplyOptionActionBottomSheet(
      {Key key,
      FBallReplyResDto fBallReplyResDto,
      ReviewDeleteMediator reviewDeleteMediator})
      : _fBallReplyResDto = fBallReplyResDto,
        _reviewDeleteMediator = reviewDeleteMediator,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      shrinkWrap: true,
      children: <Widget>[
        ReplyEditActionBtn(fBallReplyResDto: _fBallReplyResDto),
        ReplyDeleteActionBtn(fBallReplyResDto: _fBallReplyResDto,reviewDeleteMediator: _reviewDeleteMediator),
      ],
    ));
  }
}
