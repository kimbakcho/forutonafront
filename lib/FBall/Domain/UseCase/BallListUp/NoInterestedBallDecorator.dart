import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';

import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';

import 'package:forutonafront/Common/PageableDto/Pageable.dart';

import 'package:forutonafront/FBall/Domain/UseCase/NoInterestBallUseCase/NoInterestBallUseCaseInputPort.dart';

import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

import 'FBallListUpUseCaseInputPort.dart';

class NoInterestedBallDecorator implements FBallListUpUseCaseInputPort {

  final FBallListUpUseCaseInputPort fBallListUpUseCaseInputPort;
  final NoInterestBallUseCaseInputPort noInterestBallUseCaseInputPort;

  NoInterestedBallDecorator(
      {@required this.fBallListUpUseCaseInputPort, @required this.noInterestBallUseCaseInputPort});

  @override
  get searchPosition {
    return fBallListUpUseCaseInputPort.searchPosition;
  }

  @override
  Future<PageWrap<FBallResDto>> search(Pageable pageable,
      {FBallListUpUseCaseOutputPort outputPort}) async {

    var noInterRestBallList = await noInterestBallUseCaseInputPort.findByAll();
    var result = await fBallListUpUseCaseInputPort.search(pageable);
    noInterRestBallList.forEach((element) {
      result.content.removeWhere((ball) => ball.ballUuid == element);
    });
    if(outputPort != null){
      outputPort.searchResult(result);
    }
    return result;
  }

  @override
  set searchPosition(Position _searchPosition) {
    throw UnimplementedError();
  }


}