import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromSearchTitleReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';



abstract class FBallListUpFromSearchTitleUseCaseInputPort{
  ballListUpFromSearchTitle({@required FBallListUpFromSearchTitleReqDto reqDto,FBallListUpFromSearchTitleUseCaseOutputPort outputPort});
}

abstract class FBallListUpFromSearchTitleUseCaseOutputPort {
  onBallListUpFromSearchTitle(List<FBallResDto> fBallResDtoList);
  onBallListUpFromSearchTitleBallTotalCount(int count);
}

class FBallListUpFromSearchTitleUseCase
    implements FBallListUpFromSearchTitleUseCaseInputPort {
  final FBallRepository _fBallRepository;

  FBallListUpFromSearchTitleUseCase({@required FBallRepository fBallRepository})
      : _fBallRepository = fBallRepository;

  @override
  ballListUpFromSearchTitle(
      {@required FBallListUpFromSearchTitleReqDto reqDto,
        FBallListUpFromSearchTitleUseCaseOutputPort outputPort}) async {
    var fBallListUpWrap =
    await _fBallRepository.listUpFromSearchTitle(reqDto: reqDto);
    var list =
    fBallListUpWrap.balls.map((x) => FBallResDto.fromFBall(x)).toList();

    if (outputPort != null) {
      outputPort.onBallListUpFromSearchTitle(list);
      outputPort.onBallListUpFromSearchTitleBallTotalCount(
          fBallListUpWrap.searchBallTotalCount);
    }
  }
}