import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';

import 'package:forutonafront/FBall/Dto/FBallListUpFromSearchTitleReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

import 'FBallListUpFromSearchTitleUseCaseInputPort.dart';
import 'FBallListUpFromSearchTitleUseCaseOutputPort.dart';

class FBallListUpFromSearchTitleUseCase
    implements FBallListUpFromSearchTitleUseCaseInputPort {
  List<FBallListUpFromSearchTitleUseCaseOutputPort> fBallListUpOutputPort = [];
  List<FBallListUpFromSearchTitleUseCaseOutputPort> fBallTotalCountOutputPort =
      [];
  final FBallRepository fBallRepository;

  FBallListUpFromSearchTitleUseCase({@required this.fBallRepository});

  @override
  addBallListUpFromSearchTitleListener(
      {@required FBallListUpFromSearchTitleUseCaseOutputPort outputPort}) {
    fBallListUpOutputPort.add(outputPort);
  }

  @override
  addBallListUpFromSearchTitleTotalCountListener(
      {FBallListUpFromSearchTitleUseCaseOutputPort outputPort}) {
    fBallTotalCountOutputPort.add(outputPort);
  }

  emitBallListUpFromSearchTitle(List<FBallResDto> fBallResDtoList) {
    fBallListUpOutputPort.forEach((element) {
      element.onBallListUpFromSearchTitle(fBallResDtoList);
    });
  }

  emitBallListUpFromSearchTitleTotalCount(int totalCount) {
    fBallTotalCountOutputPort.forEach((element) {
      element.onBallListUpFromSearchTitleBallTotalCount(totalCount);
    });
  }

  @override
  ballListUpFromSearchTitle(
      {@required FBallListUpFromSearchTitleReqDto reqDto}) async {
    var fBallListUpWrap =
        await fBallRepository.listUpFromSearchTitle(reqDto: reqDto);
    var list =
        fBallListUpWrap.balls.map((x) => FBallResDto.fromFBall(x)).toList();
    emitBallListUpFromSearchTitle(list);
    emitBallListUpFromSearchTitleTotalCount(fBallListUpWrap.searchBallTotalCount);
  }
}
