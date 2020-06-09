import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCase.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCaseInputPort.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Data/Entity/IssueBall.dart';
import 'package:forutonafront/FBall/Domain/UseCase/IssueBall/IssueBallUseCase.dart';
import 'package:forutonafront/FBall/Domain/UseCase/IssueBall/IssueBallUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/IssueBall/IssueBallUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallJoinReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/FireBaseAuthUseCase.dart';
import 'package:forutonafront/ICodePage/ID001/ID001MainPage.dart';

class IssueBallWidgetSyle1ViewModel extends ChangeNotifier
    implements GeoLocationUtilUseCaseOutputPort, IssueBallUseCaseOutputPort {
  final BuildContext context;
  IssueBall issueBall;

  bool _isLoading = false;

  String distanceDisplayText = "";

  get isLoading {
    return _isLoading;
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  IssueBallUseCaseInputPort _issueBallUseCase = new IssueBallUseCase();
  GeoLocationUtilUseCaseInputPort geoLocationUtilUseCaseIp =
      GeoLocationUtilUseCase();

  AuthUserCaseInputPort _authUserCaseInputPort = FireBaseAuthUseCase();

  IssueBallWidgetSyle1ViewModel(
      {@required this.context, @required this.issueBall}) {
    geoLocationUtilUseCaseIp.reqBallDistanceDisplayText(
        lat: issueBall.latitude,
        lng: issueBall.longitude,
        geoLocationUtilUseCaseOp: this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void goIssueDetailPage() async {
    if (await _authUserCaseInputPort.checkLogin()) {
      _issueBallUseCase.ballHit(
          reqDto: FBallReqDto(issueBall.ballType, issueBall.ballUuid),
          outputPort: this);
      _issueBallUseCase.joinBall(
          reqDto: FBallJoinReqDto(
              issueBall.ballType, issueBall.ballUuid, await _authUserCaseInputPort.userUid()));
    }
    await Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => ID001MainPage(issueBall: issueBall)));
    _issueBallUseCase.selectBall(ballUuid: issueBall.ballUuid,outputPort: this);
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
  void onBallHit() {
    issueBall.ballHit();
    notifyListeners();
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

  @override
  void onInsertBall(FBallResDto resDto) {
    throw ("here don't have action");
  }

  @override
  void onUpdateBall() {
    throw ("here don't have action");
  }
}
