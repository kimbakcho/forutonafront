import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUpFromTagName/FBallListUpFromSearchTagUseCaseOutputPort.dart';


import 'package:forutonafront/FBall/Dto/FBallListUpFromTagNameReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

import 'FBallListUpFromSearchTagUseCaseInputPort.dart';

class FBallListUpFromSearchTagNameUseCase implements FBallListUpFromSearchTagNameUseCaseInputPort{

  List<FBallListUpFromSearchTagNameUseCaseOutputPort> fBallListUpOutputPort = [];
  List<FBallListUpFromSearchTagNameUseCaseOutputPort> fBallTotalCountOutputPort = [];
  final FBallRepository fBallRepository;
  FBallListUpFromSearchTagNameUseCase({@required this.fBallRepository});
  @override
  addBallListUpFromSearchTagNameListener({@required FBallListUpFromSearchTagNameUseCaseOutputPort outputPort}) {
    fBallListUpOutputPort.add(outputPort);
  }

  @override
  addBallListUpFromSearchTagNameTotalCountListener({@required FBallListUpFromSearchTagNameUseCaseOutputPort outputPort}) {
    fBallTotalCountOutputPort.add(outputPort);
  }

  @override
  ballListUpFromSearchTagName({@required FBallListUpFromTagNameReqDto reqDto}) async{
    var fBallListUpWrap =
        await fBallRepository.listUpFromTagName(reqDto: reqDto);
    var result =
        fBallListUpWrap.balls.map((x) => FBallResDto.fromFBall(x)).toList();
    emitBallListUpFromSearchTagName(result);
    emitBallListUpFromSearchTitleTotalCount(fBallListUpWrap.searchBallTotalCount);
  }


  emitBallListUpFromSearchTagName(List<FBallResDto> fBallResDtoList) {
    fBallListUpOutputPort.forEach((element) {
      element.onBallListUpFromSearchTagName(fBallResDtoList);
    });
  }

  emitBallListUpFromSearchTitleTotalCount(int totalCount) {
    fBallTotalCountOutputPort.forEach((element) {
      element.onBallListUpFromSearchTagNameBallTotalCount(totalCount);
    });
  }

}