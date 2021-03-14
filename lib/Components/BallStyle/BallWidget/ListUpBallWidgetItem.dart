import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/AppBis/CommonValue/Value/ReplyMaliciousType.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/DeleteBall/DeleteBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/HitBall/HitBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/NoInterestBallUseCase/NoInterestBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Value/FBallType.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/MaliciousBall/Domain/UseCase/MaliciousBallUseCaseInputPort.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/Components/BallOption/BallDeletePopup/BallDeletePopup.dart';
import 'package:forutonafront/Components/BallOption/MyBallPopup/MyBallPopup.dart';
import 'package:forutonafront/Components/BallOption/OtherUserBallPopup/OtherUserBallPopup.dart';

import 'package:forutonafront/Components/DetailPageViewer/DetailPageViewer.dart';
import 'package:forutonafront/Page/ICodePage/ID01/ID01MainPage.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:uuid/uuid.dart';

abstract class ListUpBallWidgetItem extends ChangeNotifier {
  final BuildContext context;
  final BallListMediator ballListMediator;
  final int index;
  final HitBallUseCaseInputPort hitBallUseCaseInputPort;
  final SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort;
  final DeleteBallUseCaseInputPort _deleteBallUseCaseInputPort;
  final MaliciousBallUseCaseInputPort _maliciousBallUseCaseInputPort;
  final NoInterestBallUseCaseInputPort _noInterestBallUseCaseInputPort;
  String ballWidgetKey;


  ListUpBallWidgetItem(this.context, this.ballListMediator, this.index,
      this.hitBallUseCaseInputPort,this.signInUserInfoUseCaseInputPort,this._deleteBallUseCaseInputPort,this._maliciousBallUseCaseInputPort, this._noInterestBallUseCaseInputPort) {
    ballWidgetKey = Uuid().v4();
  }

  Widget detailPage();

  Future<void> onModifyBall(BuildContext context);

  moveToDetailPage() async {
    var hits = await hitBallUseCaseInputPort.hit(ballListMediator.itemList[index].ballUuid);
    ballListMediator.itemList[index].ballHits = hits;
    await Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return detailPage();
    }));
    onReFreshBall();
  }

  onReFreshBall();

  showOptionPopUp() async {
    var reqSignInUserInfoFromMemory = signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory();
    if (ballListMediator.itemList[index].uid.uid ==
        reqSignInUserInfoFromMemory.uid) {
      showDialog(
          context: context,
          child: MyBallPopup(
            isShowCloseBtn: false,
            isShowShareBtn: true,
            onShare: onShare,
            onDelete: onDeleteBall,
            onModify: (context) async {
              await onModifyBall(context);
              onReFreshBall();
            },
          ));
    } else {
      await showDialog(
          context: context,
          child: OtherUserBallPopup(
            onReportMalicious: onReportMalicious,
            isShowFavourite: true,
            isShowNotInterestBtn: true,
            isShowShareBtn: true,
            isShowCloseBtn: false,
            isShowReportMalicious: true,
            onShare: onShare,
            onFavourite: onFavourite,
            onNotInterest: onNotInterest,
          ));
    }
  }

  onShare(BuildContext context){
    Fluttertoast.showToast(
        msg: "준비중 입니다.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Color(0xff454F63),
        textColor: Colors.white,
        fontSize: 12.0);
  }

  onFavourite(BuildContext context){
    Fluttertoast.showToast(
        msg: "준비중 입니다.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Color(0xff454F63),
        textColor: Colors.white,
        fontSize: 12.0);
  }

  onNotInterest(BuildContext context) async {
    await _noInterestBallUseCaseInputPort.save(ballListMediator.itemList[index].ballUuid);
    await ballListMediator.hideBall(ballListMediator.itemList[index].ballUuid);
  }

  onDeleteBall(BuildContext context) async {
    await showDialog(
        context: context,
        child: BallDeletePopup(
          actionDelete: onActionDelete,
        ));
  }

  onReportMalicious(BuildContext context,MaliciousType maliciousType) async {
    await this._maliciousBallUseCaseInputPort.reportMaliciousReply(
        maliciousType, ballListMediator.itemList[index].ballUuid);
  }

  onActionDelete() async {
    await _deleteBallUseCaseInputPort
        .deleteBall(ballListMediator.itemList[index].ballUuid);
    Navigator.of(context).pop();
    onReFreshBall();

  }

}
