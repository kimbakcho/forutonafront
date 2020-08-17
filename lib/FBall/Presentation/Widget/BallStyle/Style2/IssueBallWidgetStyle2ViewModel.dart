import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseForeGroundCaseOutputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallDisPlayUseCase/BallDisPlayUseCase.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallDisPlayUseCase/IssueBallDisPlayUseCase.dart';
import 'package:forutonafront/FBall/Domain/UseCase/selectBall/SelectBallUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/Value/IssueBallDescription.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallModify/BallModifyService.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallModify/Impl/IssueBallModifyService.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallModify/Widget/CommonBallModifyWidgetResultType.dart';
import 'package:forutonafront/ICodePage/ID001/ID001MainPage2.dart';
import 'package:forutonafront/ICodePage/IM001/IM001MainPage.dart';
import 'package:forutonafront/ICodePage/IM001/IM001MainPageEnterMode.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class IssueBallWidgetStyle2ViewModel extends ChangeNotifier
    implements
        SelectBallUseCaseOutputPort,
        GeoLocationUtilUseForeGroundCaseOutputPort {
  BuildContext context;

  FBallResDto issueBall;

  String distanceDisplayText = "";

  SelectBallUseCaseInputPort _selectBallUseCaseInputPort;

  GeoLocationUtilForeGroundUseCaseInputPort _geoLocationUtilUseCaseInputPort;

  IssueBallDisPlayUseCase _BallDisPlayUseCase;

  IssueBallWidgetStyle2ViewModel(
      {@required
          this.context,
      @required
          FBallResDto userBallResDto,
        @required
        SelectBallUseCaseInputPort selectBallUseCaseInputPort,
      @required
          GeoLocationUtilForeGroundUseCaseInputPort
              geoLocationUtilUseCaseInputPort})
      :
        _selectBallUseCaseInputPort = selectBallUseCaseInputPort,
        _geoLocationUtilUseCaseInputPort = geoLocationUtilUseCaseInputPort {
    _geoLocationUtilUseCaseInputPort.reqBallDistanceDisplayText(
        ballLatLng: Position(
            latitude: issueBall.latitude, longitude: issueBall.longitude),
        geoLocationUtilUseCaseOp: this);
    _BallDisPlayUseCase = IssueBallDisPlayUseCase(userBallResDto);
  }

  void goIssueDetailPage() async {
    if (issueBall.ballDeleteFlag) {
      Fluttertoast.showToast(
          msg: "삭제된 Ball 입니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
    } else {
      await Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ID001MainPage2( ballUuid: issueBall.ballUuid)));
      _selectBallUseCaseInputPort.selectBall(issueBall.ballUuid, outputPort: this);
    }
  }

  void showBallSetting() async {
    BallModifyService ballModifyService =
        IssueBallModifyService(fireBaseAuthAdapterForUseCase: sl());
//    if (await issueBall.isCanModify()) {
//      CommonBallModifyWidgetResultType result =
//          await ballModifyService.showModifySelectDialog(context: context);
//      if (result == CommonBallModifyWidgetResultType.Update) {
//        await Navigator.of(context).push(MaterialPageRoute(builder: (_) {
//          return IM001MainPage(
//              LatLng(issueBall.latitude, issueBall.longitude),
//              issueBall.placeAddress,
//              issueBall.ballUuid,
//              IM001MainPageEnterMode.Update);
//        }));
//        _selectBallUseCaseInputPort.selectBall(issueBall.ballUuid, outputPort: this);
//      } else {
//        await issueBall.delete();
//        notifyListeners();
//      }
//    }
  }


  @override
  void onSelectBall(FBallResDto fBallResDto) {
//    issueBall = IssueBall.fromFBallResDto(fBallResDto);
    notifyListeners();
  }

  String getDistanceDisplayText() {
    if (issueBall.ballDeleteFlag) {
      return "";
    } else {
      return distanceDisplayText;
    }
  }

  @override
  onBallDistanceDisplayText({String displayDistanceText}) {
    this.distanceDisplayText = displayDistanceText;
    notifyListeners();
  }

  isAliveBall() {
    return _BallDisPlayUseCase.isAlive();
  }

  String getBallLikeCount() {
    return _BallDisPlayUseCase.ballLikes();
  }

  String getDisplayDisLikeCount() {
    return _BallDisPlayUseCase.ballDisLikes();
  }

  String getDisplayCommentCount() {
    return _BallDisPlayUseCase.commentCount();
  }

  String getDisplayRemainingTime() {
    return _BallDisPlayUseCase.remainTime();
  }

  String getDisplayBallName() {
    return _BallDisPlayUseCase.ballName();
  }

  String getDisplayPlaceAddress() {
    return _BallDisPlayUseCase.placeAddress();
  }

}
