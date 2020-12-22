import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBallReply/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:provider/provider.dart';

import '../ReviewDeleteMediator.dart';

class ReplyDeleteConfirmDialog extends StatelessWidget {
  final FBallReplyResDto fBallReplyResDto;
  final ReviewDeleteMediator _reviewDeleteMediator;

  const ReplyDeleteConfirmDialog(
      {Key key,
      this.fBallReplyResDto,
      ReviewDeleteMediator reviewDeleteMediator})
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
                height: 200,
                width: 300,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text("삭제 하시겠습니까?"),
                          )
                        ]),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                              child: Container(
                                  child: FlatButton(
                                      onPressed: () {
                                        model.deleteReply();
                                      },
                                      child: Text(
                                        "삭제",
                                      )))),
                          Expanded(
                              child: Container(
                                  child: FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("취소"))))
                        ])
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
  final FBallReplyResDto fBallReplyResDto;
  final BuildContext context;

  final ReviewDeleteMediator _reviewDeleteMediator;

  ReplyDeleteConfirmDialogViewModel(
      {this.fBallReplyResDto,
      this.context,
      ReviewDeleteMediator reviewDeleteMediator})
      : _reviewDeleteMediator = reviewDeleteMediator;

  deleteReply() async {
    await _reviewDeleteMediator.deleteReview(fBallReplyResDto);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }
}
