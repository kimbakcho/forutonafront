import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/FBall/Domain/Entity/IssueBall.dart';

import 'package:forutonafront/FBall/Domain/UseCase/selectBall/SelectBallUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

class ID001MainPage2ViewModel extends ChangeNotifier implements SelectBallUseCaseOutputPort{
  final String _ballUuid;
  final SelectBallUseCaseInputPort _selectBallUseCaseInputPort;
  IssueBall _issueBall;
  bool _loadBallComplete = false;
  ID001MainPage2ViewModel(
      {String ballUuid, SelectBallUseCaseInputPort selectBallUseCaseInputPort})
      : _ballUuid = ballUuid, _selectBallUseCaseInputPort = selectBallUseCaseInputPort {
    _selectBallUseCaseInputPort.selectBall(_ballUuid,outputPort: this);
  }

  String getBallTitle() {
    return _issueBall.getDisplayBallName();
  }

  @override
  onSelectBall(FBallResDto fBallResDto) {
    _issueBall = IssueBall.fromFBallResDto(fBallResDto);
    _loadBallComplete = true;
    notifyListeners();
  }

  bool isLoadBallFinish(){
    return _loadBallComplete;
  }

  getBallUuid() {
    return _issueBall.ballUuid;
  }

  getBallHits() {
    return _issueBall.getDisplayBallHits();
  }

  getMakeTime() {
    return _issueBall.getDisplayMakeTime();
  }

  getBallPosition() {
    return Position(latitude: _issueBall.latitude,longitude: _issueBall.longitude);
  }

  getBallAddress() {
    return _issueBall.placeAddress;
  }

  getMakerNickName() {
    return _issueBall.getDisplayNickName();
  }

  getMakerProfileUrl() {
    return _issueBall.getDisplayProfilePictureUrl();
  }

  getMakerFollower() {
    return _issueBall.getDisplayFollower();
  }

  getMakerInfluencePower() {
    return _issueBall.getDisplayMakerInfluencePower();
  }

  getBallTextContent() {
    return _issueBall.getDisplayDescriptionText();
  }

  getBallMakeTime() {
    return _issueBall.getDisplayMakeTime();
  }
}
