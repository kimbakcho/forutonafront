import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCase.dart';

import 'package:forutonafront/FBall/Domain/Repository/IFBallRepository.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUp/FBallListUpUseCaseIp.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUp/FBallListUpUseCaseOp.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

class FBallListUpUseCase implements FBallListUpUseCaseIp {
  final FBallListUpUseCaseOp fBallListUpUseCaseOp;
  final IFBallRepository ifBallRepository;
  final GeoLocationUtilUseCase geoLocationUtil;

  FBallListUpUseCase(
      {@required this.fBallListUpUseCaseOp,
      @required this.ifBallRepository,
      @required this.geoLocationUtil});

  @override
  Future<List<FBallResDto>> positionSearchListUpBall(
      {@required FBallListUpReqDto searchReqDto}) async {
    var fBallListUpWrap =
        await ifBallRepository.listUpFromPosition(listUpReqDto: searchReqDto);
    var result = fBallListUpWrap.balls
        .map((e) => new FBallResDto.fromJson(e.toJson()))
        .toList();
    String updateAddress;
    updateAddress = await getAddress(searchReqDto);
    fBallListUpUseCaseOp.onPositionSearchListUpBall(
        fBallResDtos: result,
        address: updateAddress);
    return result;
  }

  Future<String> getAddress(FBallListUpReqDto searchReqDto) async {
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
  Future<List<FBallResDto>> lastKnowPositionSearchListUpBall(
      {@required FBallListUpReqDto searchReqDto,
      @required BuildContext context}) async {
    var result = positionSearchListUpBall(
        searchReqDto:
            await makeLastPositionSearchReqDto(searchReqDto, context));
    return result;
  }

  Future<FBallListUpReqDto> makeLastPositionSearchReqDto(
      FBallListUpReqDto searchReqDto, BuildContext context) async {
    FBallListUpReqDto fBallListUpReqDto =
        new FBallListUpReqDto.fromJson(searchReqDto.toJson());
    var position = await this.geoLocationUtil.getCurrentWithLastPosition();
    var setLatLang =
        fBallListUpReqDto.setLatLng(position.latitude, position.longitude);
    return setLatLang;
  }
}
