import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBallReply/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/AppBis/MaliciousReply/Domain/UseCase/MaliciousReplyUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/MaliciousReply/Domain/Value/ReplyMaliciousType.dart';
import 'package:forutonafront/AppBis/MaliciousReply/Dto/MaliciousReplyReqDto.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';

class ReplyReportActionAlertDialogSheet extends StatelessWidget {

  final FBallReplyResDto fBallReplyResDto;

  const ReplyReportActionAlertDialogSheet({Key key, this.fBallReplyResDto}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReplyReportActionAlertDialogSheetViewModel(fBallReplyResDto,sl()),
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
                              model.showReportItem(context);
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
  final MaliciousReplyUseCaseInputPort maliciousReplyUseCase;

  ReplyReportActionAlertDialogSheetViewModel(this.fBallReplyResDto, this.maliciousReplyUseCase);

  reportMaliciousReply(BuildContext context,ReplyMaliciousType replyMaliciousType) async {
    await maliciousReplyUseCase.reportMaliciousReply(replyMaliciousType,fBallReplyResDto.replyUuid);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  reportMaliciousReplyWithLoading(BuildContext context,ReplyMaliciousType replyMaliciousType){
    showGeneralDialog(context: context, pageBuilder: (context, animation, secondaryAnimation) {
      reportMaliciousReply(context,replyMaliciousType);
      return CommonLoadingComponent();
    });
  }

  void showReportItem(BuildContext context){

    showModalBottomSheet(
      backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(15.0),topLeft: Radius.circular(15.0))
        ),
        context: context, builder: (context) {
      return Container(
        height: 350,
        child: Column(
          children: [
            ListTile(
              title: Text("범죄 또는 이름 조장"),
              onTap: (){
                reportMaliciousReplyWithLoading(context,ReplyMaliciousType.crime);
              },
            ),
            ListTile(
              title: Text("욕설,차별,사칭 등 타인에 대한 위협 및 피해"),
              onTap: (){
                reportMaliciousReplyWithLoading(context,ReplyMaliciousType.abuse);
              },
            ),
            ListTile(
              title: Text("사생활 침해,개인정보 노출"),
              onTap: (){
                reportMaliciousReplyWithLoading(context,ReplyMaliciousType.privacy);
              },
            ),
            ListTile(
              title: Text("성적인 메세지"),
              onTap: (){
                reportMaliciousReplyWithLoading(context,ReplyMaliciousType.sexual);
              },
            ),
            ListTile(
              title: Text("광고성 메시지"),
              onTap: (){
                reportMaliciousReplyWithLoading(context,ReplyMaliciousType.advertising);
              },
            ),
            ListTile(
              title: Text("기타"),
              onTap: (){
                reportMaliciousReply(context,ReplyMaliciousType.etc);
              },
            )
         ],
        ),
      );
    });
  }


}
