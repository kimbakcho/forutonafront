import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply2/ReplyOptionAction/BasicReViewUpdate.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply2/ReviewUpdateMediator.dart';
import 'package:google_fonts/google_fonts.dart';

class ReplyEditActionBtn extends StatelessWidget {
  final FBallReplyResDto _fBallReplyResDto;
  final ReviewUpdateMediator _reviewUpdateMediator;

  const ReplyEditActionBtn({
    FBallReplyResDto fBallReplyResDto,
    ReviewUpdateMediator reviewUpdateMediator,
    Key key,
  })  : _fBallReplyResDto = fBallReplyResDto,
        _reviewUpdateMediator = reviewUpdateMediator,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (_) =>
                  BasicReViewUpdate(fBallReplyResDto: _fBallReplyResDto,reviewUpdateMediator: _reviewUpdateMediator,),
            );
          },
          child: Container(
            alignment: AlignmentDirectional.center,
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: Text(
              "수정",
              style: GoogleFonts.notoSans(
                fontSize: 16,
                color: const Color(0xff000000),
                fontWeight: FontWeight.w700,
                height: 1.25,
              ),
            ),
            decoration: BoxDecoration(border: Border(bottom: BorderSide())),
          ))
    ]);
  }
}
