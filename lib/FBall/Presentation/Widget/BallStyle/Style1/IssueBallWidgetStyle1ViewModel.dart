import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseForeGroundCaseOutputPort.dart';
import 'package:forutonafront/FBall/Domain/Entity/IssueBall.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallImageViewer/BallImageViwer.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallStyle/BasicStyle/IssueBallBasicStyle.dart';

class IssueBallWidgetStyle1ViewModel extends ChangeNotifier
    implements GeoLocationUtilUseForeGroundCaseOutputPort {
  final BuildContext context;
  final IssueBall issueBall;
  final IssueBallBasicStyle _issueBallBasicStyle;
  final GeoLocationUtilForeGroundUseCaseInputPort _geoLocationUtilUseCaseInputPort;

  bool _isLoading = false;

  String distanceDisplayText = "";

  get isLoading {
    return _isLoading;
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  IssueBallWidgetStyle1ViewModel(
      {@required
          this.context,
      @required
          this.issueBall,
      @required
          IssueBallBasicStyle issueBallBasicStyle,
      @required
      GeoLocationUtilForeGroundUseCaseInputPort geoLocationUtilUseCaseInputPort})
      : _issueBallBasicStyle = issueBallBasicStyle,
        _geoLocationUtilUseCaseInputPort = geoLocationUtilUseCaseInputPort {
    _geoLocationUtilUseCaseInputPort.reqBallDistanceDisplayText(
        ballLatLng: Position(
            latitude: issueBall.latitude, longitude: issueBall.longitude),
        geoLocationUtilUseCaseOp: this);
  }

  void goIssueDetailPage()async {
    await _issueBallBasicStyle.goIssueDetailPage(issueBall);
    notifyListeners();
  }

  @override
  onBallDistanceDisplayText({String displayDistanceText}) {
    this.distanceDisplayText = displayDistanceText;
    notifyListeners();
  }

  String getDistanceDisplayText() {
    if (issueBall.ballDeleteFlag) {
      return "";
    } else {
      return distanceDisplayText;
    }
  }

  gotoBallImageViewer() async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return BallImageViewer(issueBall.getDesImages(),
          issueBall.ballUuid + "picturefromBigpicture");
    }));
  }
}
