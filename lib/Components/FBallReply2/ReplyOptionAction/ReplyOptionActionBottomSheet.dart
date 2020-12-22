import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBallReply/Dto/FBallReply/FBallReplyResDto.dart';
import '../ReviewDeleteMediator.dart';
import '../ReviewUpdateMediator.dart';
import 'ReplyDeleteActionBtn.dart';
import 'ReplyEditActionBtn.dart';

class ReplyOptionActionBottomSheet extends StatelessWidget {
  final FBallReplyResDto _fBallReplyResDto;
  final ReviewDeleteMediator _reviewDeleteMediator;
  final ReviewUpdateMediator _reviewUpdateMediator;

  const ReplyOptionActionBottomSheet(
      {Key key,
      FBallReplyResDto fBallReplyResDto,
        ReviewUpdateMediator reviewUpdateMediator,
      ReviewDeleteMediator reviewDeleteMediator})
      : _fBallReplyResDto = fBallReplyResDto,
        _reviewDeleteMediator = reviewDeleteMediator,
        _reviewUpdateMediator = reviewUpdateMediator,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      shrinkWrap: true,
      children: <Widget>[
        ReplyEditActionBtn(fBallReplyResDto: _fBallReplyResDto,reviewUpdateMediator: _reviewUpdateMediator),
        ReplyDeleteActionBtn(fBallReplyResDto: _fBallReplyResDto,reviewDeleteMediator: _reviewDeleteMediator),
      ],
    ));
  }
}
