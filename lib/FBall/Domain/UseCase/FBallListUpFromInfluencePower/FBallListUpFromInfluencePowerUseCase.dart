import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCase.dart';

import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';

import 'package:forutonafront/FBall/Dto/FBallListUpFromBallInfluencePowerReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

import 'FBallListUpFromInfluencePowerUseCaseInputPort.dart';
import 'FBallListUpFromInfluencePowerUseCaseOutputPort.dart';

class FBallListUpFromInfluencePowerUseCase implements FBallListUpFromInfluencePowerUseCaseInputPort {
  final FBallListUpFromInfluencePowerUseCaseOutputPort fBallListUpUseCaseOutputPort;
  final FBallRepository fBallRepository;

  int _pageCount = 0;
  int _ballPageLimitSize = 20;
  int _ballSearchLimit = 1000;


  FBallListUpFromInfluencePowerUseCase(
      {@required this.fBallListUpUseCaseOutputPort,
      @required this.fBallRepository});

  @override
  Future<void> reqBallListUpFromInfluencePower(
      {@required Position searchReqDto}) async {
    FBallListUpFromBallInfluencePowerReqDto ballListUpReqDto =
    new FBallListUpFromBallInfluencePowerReqDto(
        latitude: searchReqDto.latitude,
        longitude: searchReqDto.longitude,
        ballLimit: _ballSearchLimit,
        page: _pageCount,
        size: _ballPageLimitSize);
    var fBallListUpWrap =
        await fBallRepository.listUpFromInfluencePower(listUpReqDto: ballListUpReqDto);
    var result = fBallListUpWrap.balls
        .map((e) => new FBallResDto.fromJson(e.toJson()))
        .toList();
    if(fBallListUpUseCaseOutputPort != null){
      if(isFirstPage){
        fBallListUpUseCaseOutputPort.onBallClear();
      }
      fBallListUpUseCaseOutputPort.onListUpBallFromBallInfluencePower(
          fBallResDtos: result);
    }
    return result;
  }

  bool hasMoreListUpBall({int nowBallCount}){
    return !(_pageCount * _ballPageLimitSize > nowBallCount);
  }

  get isFirstPage {
    if (this._pageCount == 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  nextPage() {
    _pageCount++;
  }

  @override
  pageReset() {
    _pageCount= 0;
  }

}
