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


  FBallListUpFromInfluencePowerUseCase({@required this.fBallRepository})
      : assert(fBallRepository != null);

  @override
  Future<void> reqBallListUpFromInfluencePower(FBallListUpFromBallInfluencePowerReqDto ballListUpReqDto,
      FBallListUpFromInfluencePowerUseCaseOutputPort outputPort) async {

    var fBallListUpWrap = await fBallRepository.listUpFromInfluencePower(ballListUpReqDto);
    var result = fBallListUpWrap.balls
        .map((e) => new FBallResDto.fromJson(e.toJson()))
        .toList();

    outputPort.onListUpBallFromBallInfluencePower(result);

    return result;
  }


}
