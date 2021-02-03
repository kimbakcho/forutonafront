import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBallReply/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../ReviewDeleteMediator.dart';
import 'ReplyDeleteConfirmDialog.dart';

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
            Expanded(child:InkWell(
                onTap: () async {
                  model.showDeleteDialog();
                },
                child: Container(
                  alignment: AlignmentDirectional.center,
                  height: 50,
                  child: Text("삭제 하기",
                      style: GoogleFonts.notoSans(
                        fontSize: 14,
                        color: const Color(0xff3a3e3f),
                        fontWeight: FontWeight.w700,
                      )),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xffE4E7E8)))),
                )))

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
    Navigator.of(context).pop();
    await showGeneralDialog(
        context: context,
        barrierDismissible: true,
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
