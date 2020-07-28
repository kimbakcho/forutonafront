import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCaseInputPort.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseForeGroundCaseOutputPort.dart';
import 'package:forutonafront/FBall/Data/Entity/IssueBall.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBall/IssueBall/IssueBallUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBall/IssueBall/IssueBallUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallModify/BallModifyService.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallModify/Impl/IssueBallModifyService.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallModify/Widget/CommonBallModifyWidgetResultType.dart';
import 'package:forutonafront/ICodePage/ID001/ID001MainPage.dart';
import 'package:forutonafront/ICodePage/IM001/IM001MainPage.dart';
import 'package:forutonafront/ICodePage/IM001/IM001MainPageEnterMode.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class IssueBallWidgetStyle2ViewModel extends ChangeNotifier
    implements IssueBallUseCaseOutputPort, GeoLocationUtilUseForeGroundCaseOutputPort {
  BuildContext context;

  IssueBall issueBall;

  String distanceDisplayText = "";

  IssueBallUseCaseInputPort _issueBallUseCaseInputPort;

  GeoLocationUtilForeGroundUseCaseInputPort _geoLocationUtilUseCaseInputPort;

  IssueBallWidgetStyle2ViewModel(
      {@required
          this.context,
      @required
          FBallResDto userBallResDto,
      @required
          IssueBallUseCaseInputPort issueBallUseCaseInputPort,
      @required
      GeoLocationUtilForeGroundUseCaseInputPort geoLocationUtilUseCaseInputPort})
      : _issueBallUseCaseInputPort = issueBallUseCaseInputPort,
        _geoLocationUtilUseCaseInputPort = geoLocationUtilUseCaseInputPort {
    issueBall = IssueBall.fromFBallResDto(userBallResDto);
    _geoLocationUtilUseCaseInputPort.reqBallDistanceDisplayText(
        ballLatLng: Position(
            latitude: issueBall.latitude, longitude: issueBall.longitude),
        geoLocationUtilUseCaseOp: this);
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
          builder: (_) => ID001MainPage(issueBall: issueBall)));
      _issueBallUseCaseInputPort.selectBall(
          ballUuid: issueBall.ballUuid, outputPort: this);
    }
  }

  void showBallSetting() async {
    BallModifyService ballModifyService =
        IssueBallModifyService(authUserCaseInputPort: sl());
    if (await issueBall.isCanModify()) {
      CommonBallModifyWidgetResultType result =
          await ballModifyService.showModifySelectDialog(context: context);
      if (result == CommonBallModifyWidgetResultType.Update) {
        await Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return IM001MainPage(
              LatLng(issueBall.latitude, issueBall.longitude),
              issueBall.placeAddress,
              issueBall.ballUuid,
              IM001MainPageEnterMode.Update);
        }));
        _issueBallUseCaseInputPort.selectBall(
            ballUuid: issueBall.ballUuid, outputPort: this);
      } else {
        _issueBallUseCaseInputPort.deleteBall(
            ballUuid: issueBall.ballUuid, outputPort: this);
      }
    }
  }

  @override
  void onBallHit() {
    return null;
  }

  @override
  void onSelectBall(FBallResDto fBallResDto) {
    issueBall = IssueBall.fromFBallResDto(fBallResDto);
    notifyListeners();
  }

  @override
  void onDeleteBall() {
    issueBall.ballDeleteFlag = true;
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

  @override
  void onInsertBall(FBallResDto resDto) {
    throw ("here don't have action");
  }

  @override
  void onUpdateBall() {
    throw ("here don't have action");
  }
}
