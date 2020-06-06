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
  final GeoLocationUtilUseCase geoLocationUtil;

  FBallListUpFromInfluencePowerUseCase(
      {@required this.fBallListUpUseCaseOutputPort,
      @required this.fBallRepository,
      @required this.geoLocationUtil});

  @override
  Future<List<FBallResDto>> ballListUpFromInfluencePower(
      {@required FBallListUpFromBallInfluencePowerReqDto searchReqDto}) async {
    var fBallListUpWrap =
        await fBallRepository.listUpFromInfluencePower(listUpReqDto: searchReqDto);
    var result = fBallListUpWrap.balls
        .map((e) => new FBallResDto.fromJson(e.toJson()))
        .toList();
    String updateAddress;
    updateAddress = await getAddress(searchReqDto);
    if(fBallListUpUseCaseOutputPort != null){
      fBallListUpUseCaseOutputPort.onListUpBallFromBallInfluencePower(
          fBallResDtos: result,
          address: updateAddress);
    }
    return result;
  }

  Future<String> getAddress(FBallListUpFromBallInfluencePowerReqDto searchReqDto) async {
    if(searchReqDto.findAddress){
      var address = await GeoLocationUtilUseCase().getPositionAddress(Position(
          latitude: searchReqDto.latitude,
          longitude: searchReqDto.longitude));
      return address;
    } else {
      return null;
    }
  }

  @override
  Future<List<FBallResDto>> ballListUpFromLastKnowPosition(
      {@required FBallListUpFromBallInfluencePowerReqDto searchReqDto,
      @required BuildContext context}) async {
    var result = ballListUpFromInfluencePower(
        searchReqDto:
            await makeLastPositionSearchReqDto(searchReqDto, context));
    return result;
  }

  Future<FBallListUpFromBallInfluencePowerReqDto> makeLastPositionSearchReqDto(
      FBallListUpFromBallInfluencePowerReqDto searchReqDto, BuildContext context) async {
    FBallListUpFromBallInfluencePowerReqDto fBallListUpReqDto =
        new FBallListUpFromBallInfluencePowerReqDto.fromJson(searchReqDto.toJson());
    var position = await this.geoLocationUtil.getCurrentWithLastPosition();
    var setLatLang =
        fBallListUpReqDto.setLatLng(position.latitude, position.longitude);
    return setLatLang;
  }
}
