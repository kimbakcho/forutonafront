import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';

import 'package:forutonafront/Common/PageableDto/FSorts.dart';

import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';

import 'package:forutonafront/FBall/Domain/UseCase/BallListUp/FBallListUpUseCaseOutputPort.dart';

import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

import 'FBallListUpUseCaseInputPort.dart';

class BallListUpUserMakerBall implements FBallListUpUseCaseInputPort {

  final FBallRepository _fBallRepository;

  BallListUpUserMakerBall({@required FBallRepository fBallRepository})
      : _fBallRepository = fBallRepository;

  @override
  Future<PageWrap<FBallResDto>> search(reqDto, Pageable pageable, FBallListUpUseCaseOutputPort outputPort) async {
    PageWrap<FBallResDto> pageWrap =
        await _fBallRepository.getUserToMakerBalls(reqDto: reqDto);
    if(outputPort != null){
      outputPort.searchResult(pageWrap)  ;
    }
    return pageWrap;
  }

}