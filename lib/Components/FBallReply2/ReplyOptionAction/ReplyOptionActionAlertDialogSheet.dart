import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBallReply/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/Components/FBallReply2/ReviewUpdateMediator.dart';
import 'package:provider/provider.dart';

import '../ReviewDeleteMediator.dart';
import 'ReplyDeleteActionBtn.dart';
import 'ReplyEditActionBtn.dart';

class ReplyOptionActionAlertDialogSheet extends StatelessWidget {
  final FBallReplyResDto fBallReplyResDto;
  final ReviewDeleteMediator reviewDeleteMediator;
  final ReviewUpdateMediator reviewUpdateMediator;

  const ReplyOptionActionAlertDialogSheet(
      {Key key,
      this.fBallReplyResDto,
      this.reviewDeleteMediator,
      this.reviewUpdateMediator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReplyOptionActionAlertDialogSheetViewModel(),
      child: Consumer<ReplyOptionActionAlertDialogSheetViewModel>(
        builder: (_, model, child) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Container(
                width: 221,
                height: 150,
                child: Column(
                  children: [
                    ReplyEditActionBtn(
                        fBallReplyResDto: fBallReplyResDto,
                        reviewUpdateMediator: reviewUpdateMediator),
                    ReplyDeleteActionBtn(
                        fBallReplyResDto: fBallReplyResDto,
                        reviewDeleteMediator: reviewDeleteMediator),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: Material(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white,
                          child: InkWell(
                            onTap: (){
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              
                              height: 50,
                              child: Center(child:  Text("닫기"),),
                            ),
                          ),
                        ))
                      ],
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ReplyOptionActionAlertDialogSheetViewModel extends ChangeNotifier {

}
