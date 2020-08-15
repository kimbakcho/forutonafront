import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallDisPlayUseCase/IssueBallDisPlayUseCase.dart';
import 'package:forutonafront/FBall/Domain/UseCase/selectBall/SelectBallUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply2/ReviewCountMediator.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply2/ReviewInertMediator.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';

import 'ValuationMediator/ValuationMediator.dart';

class ID001MainPage2ViewModel extends ChangeNotifier
    implements SelectBallUseCaseOutputPort {
  final String _ballUuid;
  final SelectBallUseCaseInputPort _selectBallUseCaseInputPort;
  final FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;
  bool _loadBallComplete = false;
  IssueBallDisPlayUseCase _issueBallDisPlayUseCase;
  FBallResDto _fBallResDto;
  final ReviewInertMediator reviewInertMediator;
  final ReviewCountMediator reviewCountMediator;

  final ValuationMediator valuationMediator =
      ValuationMediatorImpl(ballLikeUseCaseInputPort: sl());

  ID001MainPage2ViewModel(
      {String ballUuid,
      SelectBallUseCaseInputPort selectBallUseCaseInputPort,
      FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase})
      : _ballUuid = ballUuid,
        _selectBallUseCaseInputPort = selectBallUseCaseInputPort,
        _fireBaseAuthAdapterForUseCase = fireBaseAuthAdapterForUseCase,
        reviewInertMediator =
            ReviewInertMediatorImpl(fBallReplyUseCaseInputPort: sl()),
        reviewCountMediator =
            ReviewCountMediatorImpl(fBallReplyUseCaseInputPort: sl()) {
    _selectBallUseCaseInputPort.selectBall(_ballUuid, outputPort: this);
    getBallLikeState();
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

  bool isLoadBallFinish() {
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
    return Position(
        latitude: _fBallResDto.latitude, longitude: _fBallResDto.longitude);
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

  getBallDesImages() {
    return _issueBallDisPlayUseCase.getDesImages();
  }

  getBallYoutubeId() {
    return _issueBallDisPlayUseCase.getYoutubeId();
  }

  DateTime getBallActivationTime() {
    return _fBallResDto.activationTime;
  }

  void getBallLikeState() async {
    if (await _fireBaseAuthAdapterForUseCase.isLogin()) {
      valuationMediator.getBallLikeState(_ballUuid,
          uid: await _fireBaseAuthAdapterForUseCase.userUid());
    } else {
      valuationMediator.getBallLikeState(_ballUuid);
    }
  }
}
