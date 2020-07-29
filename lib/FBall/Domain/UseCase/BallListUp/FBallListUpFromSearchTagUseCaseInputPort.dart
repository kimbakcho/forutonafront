import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/FSorts.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallListUp/FBallListUpUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromTagNameReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

import 'FBallListUpUseCaseInputPort.dart';


//abstract class FBallListUpFromSearchTagNameUseCaseInputPort {
//  ballListUpFromSearchTagName(
//      {@required FBallListUpFromTagNameReqDto reqDto,
//      FBallListUpFromSearchTagNameUseCaseOutputPort outputPort});
//}
//abstract class FBallListUpFromSearchTagNameUseCaseOutputPort {
//  onBallListUpFromSearchTagName(List<FBallResDto> fBallResDtoList);
//  onBallListUpFromSearchTagNameBallTotalCount(int count);
//}

class FBallListUpFromSearchTagNameUseCase
    implements FBallListUpUseCaseInputPort {
  final FBallRepository fBallRepository;

  FBallListUpFromSearchTagNameUseCase({@required this.fBallRepository});


  @override
  Future<PageWrap<FBallResDto>> search(reqDto,  Pageable pageable, FBallListUpUseCaseOutputPort outputPort) async{
    PageWrap<FBallResDto> pageWrap =
        await fBallRepository.listUpFromTagName(reqDto: reqDto);
    if (outputPort != null) {
      outputPort.searchResult(pageWrap);
    }
    return pageWrap;
  }
}