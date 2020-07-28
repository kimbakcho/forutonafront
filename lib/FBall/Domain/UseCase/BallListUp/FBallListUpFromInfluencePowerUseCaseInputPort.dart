
import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';

import 'package:forutonafront/Common/PageableDto/FSorts.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/FBall/Data/Entity/FBall.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallListUp/FBallListUpUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromBallInfluencePowerReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:geolocator/geolocator.dart';

import 'FBallListUpUseCaseInputPort.dart';


class FBallListUpFromInfluencePowerUseCase
    implements FBallListUpUseCaseInputPort {
  final FBallRepository fBallRepository;

  FBallListUpFromInfluencePowerUseCase({@required this.fBallRepository})
      : assert(fBallRepository != null);

  @override
  Future<PageWrap<FBallResDto>> search (dynamic reqDto, FSorts sort, Pageable pageable,
      FBallListUpUseCaseOutputPort outputPort) async {
    PageWrap<FBallResDto> pageBalls = await fBallRepository.listUpFromInfluencePower(reqDto);
    outputPort.searchResult(pageBalls);
    return pageBalls;
  }



}