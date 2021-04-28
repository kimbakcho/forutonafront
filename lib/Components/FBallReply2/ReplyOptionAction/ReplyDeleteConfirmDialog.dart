import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBallReply/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../ReviewDeleteMediator.dart';

class ReplyDeleteConfirmDialog extends StatelessWidget {
  final FBallReplyResDto? fBallReplyResDto;
  final ReviewDeleteMediator? _reviewDeleteMediator;

  const ReplyDeleteConfirmDialog(
      {Key? key,
      this.fBallReplyResDto,
      ReviewDeleteMediator? reviewDeleteMediator})
      : _reviewDeleteMediator = reviewDeleteMediator,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ReplyDeleteConfirmDialogViewModel(
            fBallReplyResDto: fBallReplyResDto,
            reviewDeleteMediator: _reviewDeleteMediator,
            context: context),
        child: Consumer<ReplyDeleteConfirmDialogViewModel>(
            builder: (_, model, __) {
          return Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                  child: Container(
                height: 174,
                width: 328,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 16),
                            child: Text("댓글 삭제",style: GoogleFonts.notoSans(
                              fontSize: 16,
                              color: const Color(0xff000000),
                              fontWeight: FontWeight.w700,
                            ),),
                          )
                        ]),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 16),
                          child: Text("정말로 삭제하시겠습니까?",style: GoogleFonts.notoSans(
                            fontSize: 14,
                            color: const Color(0xff3a3e3f),
                            fontWeight: FontWeight.w300,
                          ),),
                        )

                      ],
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    Divider(
                      color: Color(0xffE4E7E8),
                      height: 1,
                    ),
                    Row(
                      children: [
                        Expanded(child: Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12)),
                          child: InkWell(
                            onTap: (){
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              height: 51,
                              decoration: BoxDecoration(
                                border: Border(right: BorderSide(color: Color(0xffE4E7E8),width: 1))
                              ),
                              child: Center(
                                child: Text("취소",style: GoogleFonts.notoSans(
                                  fontSize: 15,
                                  color: const Color(0xff3a3e3f),
                                  fontWeight: FontWeight.w500,
                                  height: 1.3333333333333333,
                                ),),
                              ),
                            ),
                          ),
                        )),
                        Expanded(child: Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(12)),
                          child: InkWell(
                            onTap: (){
                              model.deleteReply();
                            },
                            child: Container(
                              height: 51,
                              child: Center(
                                child: Text("삭제",style: GoogleFonts.notoSans(
                                  fontSize: 15,
                                  color: const Color(0xffff4f9a),
                                  fontWeight: FontWeight.w500,
                                  height: 1.3333333333333333,
                                ),),
                              ),
                            ),
                          ),
                        ))
                      ],
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
              )));
        }));
  }
}

class ReplyDeleteConfirmDialogViewModel extends ChangeNotifier {
  final FBallReplyResDto? fBallReplyResDto;
  final BuildContext? context;

  final ReviewDeleteMediator? _reviewDeleteMediator;

  ReplyDeleteConfirmDialogViewModel(
      {this.fBallReplyResDto,
      this.context,
      ReviewDeleteMediator? reviewDeleteMediator})
      : _reviewDeleteMediator = reviewDeleteMediator;

  deleteReply() async {
    Navigator.of(context!).pop();

    showGeneralDialog(context: context!,
        pageBuilder: (context, animation, secondaryAnimation) {
          _deleteReplyInLoading(context);
          return CommonLoadingComponent();
        });
  }

  void _deleteReplyInLoading(BuildContext context) async {
    await _reviewDeleteMediator!.deleteReview(fBallReplyResDto);
    fBallReplyResDto!.deleteFlag = true;
    Navigator.of(context).pop();
  }
}
