import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseForeGroundCaseOutputPort.dart';
import 'package:forutonafront/Components/BallImageViewer/BallImageViwer.dart';
import 'package:forutonafront/Components/BallStyle/BasicStyle/IssueBallBasicStyle.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallDisPlayUseCase/IssueBallDisPlayUseCase.dart';
import 'package:forutonafront/FBall/Domain/Value/IssueBallDescription.dart';
import 'package:forutonafront/FBall/Dto/FBallDesImagesDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';


class IssueBallWidgetStyle1ViewModel extends ChangeNotifier
    implements GeoLocationUtilUseForeGroundCaseOutputPort {
  final BuildContext context;
  final FBallResDto fBallResDto;
  final IssueBallBasicStyle _issueBallBasicStyle;
  final GeoLocationUtilForeGroundUseCaseInputPort _geoLocationUtilUseCaseInputPort;
  IssueBallDisPlayUseCase _ballDisPlayUseCase;
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
          this.fBallResDto,
      @required
          IssueBallBasicStyle issueBallBasicStyle,
      @required
      GeoLocationUtilForeGroundUseCaseInputPort geoLocationUtilUseCaseInputPort})
      : _issueBallBasicStyle = issueBallBasicStyle,
        _geoLocationUtilUseCaseInputPort = geoLocationUtilUseCaseInputPort {
    _geoLocationUtilUseCaseInputPort.reqBallDistanceDisplayText(
        ballLatLng: Position(
            latitude: fBallResDto.latitude, longitude: fBallResDto.longitude),
        geoLocationUtilUseCaseOp: this);
    _ballDisPlayUseCase = IssueBallDisPlayUseCase(fBallResDto: fBallResDto);
  }

  void goIssueDetailPage()async {
    await _issueBallBasicStyle.goIssueDetailPage(fBallResDto);
    notifyListeners();
  }

  @override
  onBallDistanceDisplayText({String displayDistanceText}) {
    this.distanceDisplayText = displayDistanceText;
    notifyListeners();
  }


  String remainTime(){
    return _ballDisPlayUseCase.remainTime();
  }

  String descriptionText() {

    return _ballDisPlayUseCase.descriptionText();
  }

  gotoBallImageViewer() async {
    IssueBallDescription _issueBallDescription = IssueBallDescription.fromJson(json.decode(fBallResDto.description));
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return BallImageViewer(_issueBallDescription.desimages,
          fBallResDto.ballUuid + "picturefromBigpicture");
    }));
  }

  isMainPicture() {
    return _ballDisPlayUseCase.isMainPicture();
  }

  mainPictureSrc() {
    return _ballDisPlayUseCase.mainPictureSrc();
  }

  pictureCount() {
    return _ballDisPlayUseCase.pictureCount();
  }

  List<FBallDesImages> getDesImages() {
    return _ballDisPlayUseCase.getDesImages();
  }

  String getBallLikes() {
    return _ballDisPlayUseCase.ballLikes();
  }

  String getBallDisLike() {
    return _ballDisPlayUseCase.ballDisLikes();
  }

  String getCommentCount() {
    return _ballDisPlayUseCase.commentCount();
  }

  String getProfilePictureUrl() {
    return _ballDisPlayUseCase.profilePictureUrl();
  }

  String getBallName() {
    return _ballDisPlayUseCase.ballName();
  }

  String getBallPlaceAddress() {
    return _ballDisPlayUseCase.placeAddress();
  }




}
