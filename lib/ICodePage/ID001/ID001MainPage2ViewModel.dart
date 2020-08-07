import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallDisPlayUseCase/IssueBallDisPlayUseCase.dart';

import 'package:forutonafront/FBall/Domain/UseCase/selectBall/SelectBallUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/Value/IssueBallDescription.dart';
import 'package:forutonafront/FBall/Dto/FBallLikeResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';

import 'ValuationMediator/ValuationMediator.dart';

class ID001MainPage2ViewModel extends ChangeNotifier implements SelectBallUseCaseOutputPort,ValuationMediatorComponent{
  final String _ballUuid;
  final SelectBallUseCaseInputPort _selectBallUseCaseInputPort;
  bool _loadBallComplete = false;
  IssueBallDisPlayUseCase _issueBallDisPlayUseCase;
  FBallResDto _fBallResDto;

  final ValuationMediator valuationMediator =
    ValuationMediatorImpl(ballLikeUseCaseInputPort: sl());

  ID001MainPage2ViewModel(
      {String ballUuid, SelectBallUseCaseInputPort selectBallUseCaseInputPort})
      : _ballUuid = ballUuid, _selectBallUseCaseInputPort = selectBallUseCaseInputPort {
    _selectBallUseCaseInputPort.selectBall(_ballUuid,outputPort: this);
    valuationMediator.registerComponent(this);
  }

  String getBallTitle() {
    return _issueBallDisPlayUseCase.ballName();
  }

  @override
  onSelectBall(FBallResDto fBallResDto) {
    _fBallResDto = fBallResDto;
    _issueBallDisPlayUseCase = IssueBallDisPlayUseCase(fBallResDto);
    _loadBallComplete = true;
    notifyListeners();
  }

  bool isLoadBallFinish(){
    return _loadBallComplete;
  }

  getBallUuid() {
    return _ballUuid;
  }

  getBallHits() {
    return _issueBallDisPlayUseCase.ballHits();
  }

  getMakeTime() {
    return _issueBallDisPlayUseCase.displayMakeTime();
  }

  getBallPosition() {
    return Position(latitude: _fBallResDto.latitude,longitude: _fBallResDto.longitude);
  }

  getBallAddress() {
    return _issueBallDisPlayUseCase.placeAddress();
  }

  getMakerNickName() {
    return _issueBallDisPlayUseCase.makerNickName();
  }

  getMakerProfileUrl() {
    return _issueBallDisPlayUseCase.profilePictureUrl();
  }

  getMakerFollower() {
    return _issueBallDisPlayUseCase.makerFollower();
  }

  getMakerInfluencePower() {
    return _issueBallDisPlayUseCase.makerInfluencePower();
  }

  getBallTextContent() {
    return _issueBallDisPlayUseCase.descriptionText();
  }

  getBallMakeTime() {
    return _issueBallDisPlayUseCase.displayMakeTime();
  }

  @override
  updateValuation(FBallLikeResDto fBallLikeResDto) {
    print("ID001MainPage2ViewModel");
    print(fBallLikeResDto);
  }
}
