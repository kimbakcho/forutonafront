import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBallReply/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:provider/provider.dart';

class ReplyReportActionAlertDialogSheet extends StatelessWidget {

  final FBallReplyResDto fBallReplyResDto;

  const ReplyReportActionAlertDialogSheet({Key key, this.fBallReplyResDto}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReplyReportActionAlertDialogSheetViewModel(fBallReplyResDto),
      child: Consumer<ReplyReportActionAlertDialogSheetViewModel>(
        builder: (_, model, child) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Container(
                width: 221,
                height: 101,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: Material(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white,
                          child: InkWell(
                            onTap: (){

                            },
                            child: Container(
                              height: 50,
                              child: Center(child:  Text("신고하기"),),
                            ),
                          ),
                        ))
                      ],
                    ),
                    Divider(
                      color: Color(0xffE4E7E8),
                      height: 1,
                    ),
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

class ReplyReportActionAlertDialogSheetViewModel extends ChangeNotifier {

  final FBallReplyResDto fBallReplyResDto;

  ReplyReportActionAlertDialogSheetViewModel(this.fBallReplyResDto);



}
