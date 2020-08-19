import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply2/ReplyOptionAction/ReplyDeleteConfirmDialog.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply2/ReviewDeleteMediator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ReplyDeleteActionBtn extends StatelessWidget {
  final FBallReplyResDto fBallReplyResDto;
  final ReviewDeleteMediator _reviewDeleteMediator;

  const ReplyDeleteActionBtn(
      {Key key,
      this.fBallReplyResDto,
      ReviewDeleteMediator reviewDeleteMediator})
      : _reviewDeleteMediator = reviewDeleteMediator,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReplyDeleteActionBtnViewModel(
          context: context,
          fBallReplyResDto: fBallReplyResDto,
          reviewDeleteMediator: _reviewDeleteMediator),
      child: Consumer<ReplyDeleteActionBtnViewModel>(builder: (_, model, __) {
        return Row(
          children: <Widget>[
            InkWell(
                onTap: () async {
                  model.showDeleteDialog();
                },
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
        );
      }),
    );
  }
}

class ReplyDeleteActionBtnViewModel extends ChangeNotifier {
  final BuildContext context;
  final FBallReplyResDto fBallReplyResDto;
  final ReviewDeleteMediator _reviewDeleteMediator;

  ReplyDeleteActionBtnViewModel(
      {this.context,
      this.fBallReplyResDto,
      ReviewDeleteMediator reviewDeleteMediator})
      : _reviewDeleteMediator = reviewDeleteMediator;

  showDeleteDialog() async {
    await showGeneralDialog(
        context: context,
        barrierDismissible: true,
        transitionDuration: Duration(milliseconds: 300),
        barrierColor: Colors.black.withOpacity(0.3),
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pageBuilder:
            (_context, Animation animation, Animation secondaryAnimation) {
          return ReplyDeleteConfirmDialog(
            reviewDeleteMediator: _reviewDeleteMediator,
            fBallReplyResDto: fBallReplyResDto,
          );
        });
  }
}
