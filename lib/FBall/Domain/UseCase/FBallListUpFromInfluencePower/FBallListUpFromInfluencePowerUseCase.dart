import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromBallInfluencePowerReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

import 'FBallListUpFromInfluencePowerUseCaseInputPort.dart';
import 'FBallListUpFromInfluencePowerUseCaseOutputPort.dart';

class FBallListUpFromInfluencePowerUseCase
    implements FBallListUpFromInfluencePowerUseCaseInputPort {
  final FBallRepository fBallRepository;

  int _pageCount = 0;
  int _ballPageLimitSize = 20;
  int _ballSearchLimit = 1000;

  FBallListUpFromInfluencePowerUseCase({@required this.fBallRepository})
      : assert(fBallRepository != null);

  @override
  Future<void> reqBallListUpFromInfluencePower(Position searchPosition,
      FBallListUpFromInfluencePowerUseCaseOutputPort outputPort) async {
    FBallListUpFromBallInfluencePowerReqDto ballListUpReqDto =
        new FBallListUpFromBallInfluencePowerReqDto(
            latitude: searchPosition.latitude,
            longitude: searchPosition.longitude,
            ballLimit: _ballSearchLimit,
            page: _pageCount,
            size: _ballPageLimitSize);
    var fBallListUpWrap = await fBallRepository.listUpFromInfluencePower(ballListUpReqDto);
    var result = fBallListUpWrap.balls
        .map((e) => new FBallResDto.fromJson(e.toJson()))
        .toList();

    if (isFirstPage) {
      outputPort.onBallClear();
    }
    outputPort.onListUpBallFromBallInfluencePower(result);

    return result;
  }

  bool hasMoreListUpBall(int nowBallCount) {
    return !(((_pageCount+1) * _ballPageLimitSize) > nowBallCount);
  }

  get isFirstPage {
    return this._pageCount == 0 ? true : false;
  }

  @override
  nextPage() {
    _pageCount++;
  }

  @override
  pageReset() {
    _pageCount = 0;
  }
}
