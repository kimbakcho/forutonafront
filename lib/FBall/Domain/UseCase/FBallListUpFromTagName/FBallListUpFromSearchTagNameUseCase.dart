import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUpFromTagName/FBallListUpFromSearchTagUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromTagNameReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

import 'FBallListUpFromSearchTagUseCaseInputPort.dart';

class FBallListUpFromSearchTagNameUseCase
    implements FBallListUpFromSearchTagNameUseCaseInputPort {
  final FBallRepository fBallRepository;

  FBallListUpFromSearchTagNameUseCase({@required this.fBallRepository});

  @override
  ballListUpFromSearchTagName(
      {@required FBallListUpFromTagNameReqDto reqDto,
      FBallListUpFromSearchTagNameUseCaseOutputPort outputPort}) async {
    var fBallListUpWrap =
        await fBallRepository.listUpFromTagName(reqDto: reqDto);
    var result =
        fBallListUpWrap.balls.map((x) => FBallResDto.fromFBall(x)).toList();
    if (outputPort != null) {
      outputPort.onBallListUpFromSearchTagName(result);
      outputPort.onBallListUpFromSearchTagNameBallTotalCount(
          fBallListUpWrap.searchBallTotalCount);
    }
  }
}
