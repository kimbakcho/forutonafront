import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Dto/BallFromMapAreaReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromBallInfluencePowerReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromSearchTitleReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromTagNameReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToMakeBallReqDto.dart';

import 'FBallListUpUseCaseOutputPort.dart';

abstract class FBallListUpUseCaseInputPort {
  Future<PageWrap<FBallResDto>> searchBallListUpUserMakerBall(
      UserToMakeBallReqDto reqDto,
      Pageable pageable,
      FBallListUpUseCaseOutputPort outputPort);

  Future<PageWrap<FBallResDto>> searchFBallListUpFromInfluencePower(
      FBallListUpFromBallInfluencePowerReqDto listUpReqDto,
      Pageable pageable,
      FBallListUpUseCaseOutputPort outputPort);

  Future<PageWrap<FBallResDto>> searchFBallListUpFromMapArea(
      BallFromMapAreaReqDto reqDto,
      Pageable pageable,
      FBallListUpUseCaseOutputPort outputPort);

  Future<PageWrap<FBallResDto>> searchFBallListUpFromSearchTagName(
      FBallListUpFromTagNameReqDto reqDto,
      Pageable pageable,
      FBallListUpUseCaseOutputPort outputPort);

  Future<PageWrap<FBallResDto>> searchFBallListUpFromSearchTitle(
      FBallListUpFromSearchTitleReqDto reqDto,
      Pageable pageable,
      FBallListUpUseCaseOutputPort outputPort);
}

class FBallListUpUseCase implements FBallListUpUseCaseInputPort {
  final FBallRepository _fBallRepository;

  FBallListUpUseCase({@required FBallRepository fBallRepository})
      : _fBallRepository = fBallRepository;

  @override
  Future<PageWrap<FBallResDto>> searchBallListUpUserMakerBall(
      UserToMakeBallReqDto reqDto,
      Pageable pageable,
      FBallListUpUseCaseOutputPort outputPort) async {
    PageWrap<FBallResDto> pageWrap =
    await _fBallRepository.getUserToMakerBalls(reqDto: reqDto);
    executeOutPort(outputPort, pageWrap);
    return pageWrap;
  }

  @override
  Future<PageWrap<FBallResDto>> searchFBallListUpFromInfluencePower(
      FBallListUpFromBallInfluencePowerReqDto listUpReqDto,
      Pageable pageable,
      FBallListUpUseCaseOutputPort outputPort) async {
    PageWrap<FBallResDto> pageWrap = await _fBallRepository
        .listUpFromInfluencePower(listUpReqDto: listUpReqDto);
    executeOutPort(outputPort, pageWrap);
    return pageWrap;
  }

  @override
  Future<PageWrap<FBallResDto>> searchFBallListUpFromMapArea(
      BallFromMapAreaReqDto reqDto,
      Pageable pageable,
      FBallListUpUseCaseOutputPort outputPort) async {
    PageWrap<FBallResDto> pageWrap =
    await _fBallRepository.ballListUpFromMapArea(reqDto: reqDto);
    executeOutPort(outputPort, pageWrap);
    return pageWrap;
  }

  void executeOutPort(FBallListUpUseCaseOutputPort outputPort,
      PageWrap<FBallResDto> pageWrap) {
    if (outputPort != null) {
      outputPort.searchResult(pageWrap);
    }
  }

  @override
  Future<PageWrap<FBallResDto>> searchFBallListUpFromSearchTagName(
      FBallListUpFromTagNameReqDto reqDto,
      Pageable pageable,
      FBallListUpUseCaseOutputPort outputPort) async {
    PageWrap<FBallResDto> pageWrap =
    await _fBallRepository.listUpFromTagName(reqDto: reqDto);
    executeOutPort(outputPort, pageWrap);
    return pageWrap;
  }

  @override
  Future<PageWrap<FBallResDto>> searchFBallListUpFromSearchTitle(
      FBallListUpFromSearchTitleReqDto reqDto, Pageable pageable,
      FBallListUpUseCaseOutputPort outputPort) async {
    PageWrap<FBallResDto> pageWrap =
    await _fBallRepository.listUpFromSearchTitle(reqDto: reqDto);
    executeOutPort(outputPort, pageWrap);
    return pageWrap;
  }


}
