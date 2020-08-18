import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply2/ReplyOptionAction/ReplyEditActionBtn.dart';
import 'package:google_fonts/google_fonts.dart';

class ReplyOptionActionBottomSheet extends StatelessWidget {
  final FBallReplyResDto _fBallReplyResDto;

  const ReplyOptionActionBottomSheet(
      {Key key, FBallReplyResDto fBallReplyResDto})
      : _fBallReplyResDto = fBallReplyResDto,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      shrinkWrap: true,
      children: <Widget>[
        ReplyEditActionBtn(fBallReplyResDto: _fBallReplyResDto),
        Row(
          children: <Widget>[
            InkWell(
                onTap: () {},
                child: Container(
                  alignment: AlignmentDirectional.center,
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Text("삭제",
                      style: GoogleFonts.notoSans(
                        fontSize: 16,
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w700,
                        height: 1.25,
                      )),
                  decoration:
                      BoxDecoration(border: Border(bottom: BorderSide())),
                ))
          ],
        ),
      ],
    ));
  }
}
