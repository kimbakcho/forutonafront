import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/AppBis/CommonValue/Value/ReplyMaliciousType.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/DeleteBall/DeleteBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/HitBall/HitBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/NoInterestBallUseCase/NoInterestBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Value/FBallType.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/MaliciousBall/Domain/UseCase/MaliciousBallUseCaseInputPort.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/Components/BallOption/BallDeletePopup/BallDeletePopup.dart';
import 'package:forutonafront/Components/BallOption/MyBallPopup/MyBallPopup.dart';
import 'package:forutonafront/Components/BallOption/OtherUserBallPopup/OtherUserBallPopup.dart';

import 'package:forutonafront/Components/DetailPageViewer/DetailPageViewer.dart';
import 'package:forutonafront/Page/ICodePage/ID01/ID01MainPage.dart';
import 'package:forutonafront/Components/DetailPage/DBallMode.dart';
import 'package:forutonafront/Page/LCodePage/L001/L001BottomSheet/BottomSheet/L001BottomSheet.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:uuid/uuid.dart';

abstract class ListUpBallWidgetItem extends ChangeNotifier {
  final BuildContext? context;
  final BallListMediator? ballListMediator;
  final int? index;
  final HitBallUseCaseInputPort? hitBallUseCaseInputPort;
  final SignInUserInfoUseCaseInputPort? signInUserInfoUseCaseInputPort;
  final DeleteBallUseCaseInputPort? _deleteBallUseCaseInputPort;
  final MaliciousBallUseCaseInputPort? _maliciousBallUseCaseInputPort;
  final NoInterestBallUseCaseInputPort? _noInterestBallUseCaseInputPort;
  String? ballWidgetKey;

  ListUpBallWidgetItem(
      this.context,
      this.ballListMediator,
      this.index,
      this.hitBallUseCaseInputPort,
      this.signInUserInfoUseCaseInputPort,
      this._deleteBallUseCaseInputPort,
      this._maliciousBallUseCaseInputPort,
      this._noInterestBallUseCaseInputPort) {
    ballWidgetKey = Uuid().v4();
  }

  Widget detailPage();

  Future<void> onModifyBall(BuildContext context);

  moveToDetailPage() async {
    var item = ballListMediator!.itemList[index!];
    if (item != null) {
      var hits = await hitBallUseCaseInputPort!.hit(item.ballUuid!);
      item.ballHits = hits;
      await Navigator.of(context!).push(MaterialPageRoute(builder: (_) {
        return detailPage();
      }));
      onReFreshBall();
    }
  }

  onReFreshBall();

  showOptionPopUp() async {
    if (!(signInUserInfoUseCaseInputPort!.isLogin!)) {
      showMaterialModalBottomSheet(
          context: context!,
          expand: false,
          backgroundColor: Colors.transparent,
          enableDrag: true,
          builder: (context) {
            return L001BottomSheet();
          });
    } else {
      var reqSignInUserInfoFromMemory =
          signInUserInfoUseCaseInputPort!.reqSignInUserInfoFromMemory();
      var item = ballListMediator!.itemList[index!];
      if (item != null) {
        if (item.uid!.uid == reqSignInUserInfoFromMemory!.uid) {
          var result = await showDialog(
              context: context!,
              builder: (context) => MyBallPopup(
                    isShowCloseBtn: false,
                    isShowShareBtn: true,
                    onShare: onShare,
                    onDelete: onDeleteBall,
                    onModify: (context) async {
                      await onModifyBall(context);
                      onReFreshBall();
                    },
                  ));
          if (result is FBallResDto) {
            Navigator.of(context!).push(MaterialPageRoute(builder: (_) {
              return ID01MainPage(
                  id01Mode: DBallMode.publish,
                  fBallResDto: result,
                  ballUuid: result.ballUuid!);
            }));
          }
        } else {
          await showDialog(
              context: context!,
              builder: (context) => OtherUserBallPopup(
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
    }
  }

  onShare(BuildContext context) {
    Fluttertoast.showToast(
        msg: "준비중 입니다.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Color(0xff454F63),
        textColor: Colors.white,
        fontSize: 12.0);
  }

  onFavourite(BuildContext context) {
    Fluttertoast.showToast(
        msg: "준비중 입니다.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Color(0xff454F63),
        textColor: Colors.white,
        fontSize: 12.0);
  }

  onNotInterest(BuildContext context) async {
    var item = ballListMediator!.itemList[index!];
    if(item != null){
      await _noInterestBallUseCaseInputPort!
          .save(item.ballUuid!);
      await ballListMediator!
          .hideBall(item.ballUuid!);
    }
  }

  onDeleteBall(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) => BallDeletePopup(
              actionDelete: onActionDelete,
            ));
  }

  onReportMalicious(BuildContext context, MaliciousType maliciousType) async {
    var item = ballListMediator!.itemList[index!];
    if(item != null) {
      await this._maliciousBallUseCaseInputPort!.reportMaliciousReply(
          maliciousType, item.ballUuid!);
    }

  }

  onActionDelete() async {
    var item = ballListMediator!.itemList[index!];
    if(item != null ){
      await _deleteBallUseCaseInputPort!
          .deleteBall(item.ballUuid!);
      Navigator.of(context!).pop();
      onReFreshBall();
    }
  }
}
