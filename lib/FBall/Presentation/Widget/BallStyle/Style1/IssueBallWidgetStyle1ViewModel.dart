
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Data/Entity/IssueBall.dart';

import 'package:forutonafront/FBall/Domain/UseCase/IssueBall/IssueBallUseCaseOutputPort.dart';

import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallStyle/BasicStyle/IssueBallBasicStyleMixin.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class IssueBallWidgetStyle1ViewModel  extends ChangeNotifier
    with IssueBallBasicStyleMixin
    implements GeoLocationUtilUseCaseOutputPort, IssueBallUseCaseOutputPort  {
  bool _isLoading = false;

  IssueBall issueBall;

  String distanceDisplayText = "";

  get isLoading {
    return _isLoading;
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }


  IssueBallWidgetStyle1ViewModel(
      {@required BuildContext context, @required  this.issueBall}) {
    this.context = context;
    geoLocationUtilUseCaseInputPort.reqBallDistanceDisplayText(
        ballLatLng: LatLng(issueBall.latitude,issueBall.longitude),
        geoLocationUtilUseCaseOp: this);
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

  String getDistanceDisplayText() {
    if (issueBall.ballDeleteFlag) {
      return "";
    } else {
      return distanceDisplayText;
    }
  }

}
