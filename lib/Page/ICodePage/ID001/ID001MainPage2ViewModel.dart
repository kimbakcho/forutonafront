import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Adapter/GeolocatorAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Components/FBallReply2/ReviewCountMediator.dart';
import 'package:forutonafront/Components/FBallReply2/ReviewDeleteMediator.dart';
import 'package:forutonafront/Components/FBallReply2/ReviewInertMediator.dart';
import 'package:forutonafront/Components/FBallReply2/ReviewUpdateMediator.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallDisPlayUseCase/IssueBallDisPlayUseCase.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/selectBall/SelectBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/AppBis/FBallReply/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/AppBis/FBallValuation/Dto/FBallLikeResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';

import 'ValuationMediator/ValuationMediator.dart';

class ID001MainPage2ViewModel extends ChangeNotifier
    implements
        ReviewInertMediatorComponent,
        ReviewDeleteMediatorComponent,
        ReviewUpdateMediatorComponent {
  final String ballUuid;
  final SelectBallUseCaseInputPort selectBallUseCaseInputPort;
  final FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase;
  bool _loadBallComplete = false;
  IssueBallDisPlayUseCase _issueBallDisPlayUseCase;
  FBallResDto _fBallResDto;
  final ReviewInertMediator reviewInertMediator;
  final ReviewCountMediator reviewCountMediator;
  final ReviewUpdateMediator reviewUpdateMediator;
  final ReviewDeleteMediator reviewDeleteMediator;
  final ValuationMediator valuationMediator;
  final GeolocatorAdapter geolocatorAdapter;
  bool isDisPose = false;
  Key basicReViewsContentBarsKey = UniqueKey();

  final ScrollController detailPageController;

  ID001MainPage2ViewModel(
      {this.ballUuid,
      this.selectBallUseCaseInputPort,
      this.fireBaseAuthAdapterForUseCase,
      this.reviewInertMediator,
      this.reviewCountMediator,
      this.valuationMediator,
      this.reviewDeleteMediator,
      this.reviewUpdateMediator,
      this.geolocatorAdapter
      }):detailPageController=ScrollController() {
    reviewInertMediator.registerComponent(this);
    reviewDeleteMediator.registerComponent(this);
    reviewUpdateMediator.registerComponent(this);
  }

  init() async {
    await _selectBall();
    valuationMediator.updateValuation(await _getBallLikeState());
  }

  String getBallTitle() {
    return _issueBallDisPlayUseCase.ballName();
  }

  _selectBall() async {
    _fBallResDto = await selectBallUseCaseInputPort.selectBall(ballUuid);
    _issueBallDisPlayUseCase = IssueBallDisPlayUseCase(
        fBallResDto: _fBallResDto, geoLocatorAdapter: geolocatorAdapter);
    _loadBallComplete = true;
    if (!isDisPose) {
      notifyListeners();
    }
  }

  bool isLoadBallFinish() {
    return _loadBallComplete;
  }

  getBallUuid() {
    return ballUuid;
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

  Future<FBallLikeResDto> _getBallLikeState() async {
    if (await fireBaseAuthAdapterForUseCase.isLogin()) {
      return await valuationMediator.getBallLikeState(ballUuid,
          uid: await fireBaseAuthAdapterForUseCase.userUid());
    } else {
      return await valuationMediator.getBallLikeState(ballUuid);
    }
  }

  @override
  void dispose() {
    this.isDisPose = true;
    reviewInertMediator.unregisterComponent(this);
    reviewDeleteMediator.unregisterComponent(this);
    reviewUpdateMediator.unregisterComponent(this);
    super.dispose();
  }

  @override
  onDeleted(FBallReplyResDto fBallReplyResDto) {
    basicReViewsContentBarsKey = UniqueKey();
    notifyListeners();
  }

  @override
  onInserted(FBallReplyResDto fBallReplyResDto) {
    basicReViewsContentBarsKey = UniqueKey();
    notifyListeners();
  }

  @override
  onUpdated(FBallReplyResDto fBallReplyResDto) {
    basicReViewsContentBarsKey = UniqueKey();
    notifyListeners();
  }
}
