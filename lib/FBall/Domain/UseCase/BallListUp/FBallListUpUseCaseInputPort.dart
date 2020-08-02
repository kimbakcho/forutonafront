import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallPlayerRepository.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Dto/BallFromMapAreaReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromBallInfluencePowerReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromSearchTitleReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpFromTagNameReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallPlayerResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

abstract class FBallListUpUseCaseInputPort {
  Future<PageWrap<FBallResDto>> searchFBallListUpUserMakerBall(
      String makerUid, Pageable pageable,
      {FBallListUpUseCaseOutputPort outputPort});

  Future<PageWrap<FBallResDto>> searchFBallListUpFromInfluencePower(
      FBallListUpFromBallInfluencePowerReqDto listUpReqDto, Pageable pageable,
      {FBallListUpUseCaseOutputPort outputPort});

  Future<PageWrap<FBallResDto>> searchFBallListUpFromMapArea(
      BallFromMapAreaReqDto reqDto, Pageable pageable,
      {FBallListUpUseCaseOutputPort outputPort});

  Future<PageWrap<FBallResDto>> searchFBallListUpFromSearchTagName(
      FBallListUpFromTagNameReqDto reqDto, Pageable pageable,
      {FBallListUpUseCaseOutputPort outputPort});

  Future<PageWrap<FBallResDto>> searchFBallListUpFromSearchTitle(
      FBallListUpFromSearchTitleReqDto reqDto, Pageable pageable,
      {FBallListUpUseCaseOutputPort outputPort});

  Future<PageWrap<FBallResDto>> searchFBallListUpUserPlayBall(
      String playerUid, Pageable pageable,
      {FBallListUpUseCaseOutputPort outputPort});
}

abstract class FBallListUpUseCaseOutputPort {
  void searchResult(PageWrap<FBallResDto> listUpItem);
}

class FBallListUpUseCase implements FBallListUpUseCaseInputPort {
  final FBallRepository _fBallRepository;
  final FBallPlayerRepository _fBallPlayerRepository;

  FBallListUpUseCase(
      {@required FBallRepository fBallRepository,
      @required FBallPlayerRepository fBallPlayerRepository})
      : _fBallRepository = fBallRepository,
        _fBallPlayerRepository = fBallPlayerRepository;

  @override
  Future<PageWrap<FBallResDto>> searchFBallListUpUserMakerBall(
      String makerUid, Pageable pageable,
      {FBallListUpUseCaseOutputPort outputPort}) async {
    PageWrap<FBallResDto> pageWrap = await _fBallRepository
        .searchUserToMakerBalls(makerUid: makerUid, pageable: pageable);
    executeOutPort(outputPort, pageWrap);
    return pageWrap;
  }

  @override
  Future<PageWrap<FBallResDto>> searchFBallListUpFromInfluencePower(
      FBallListUpFromBallInfluencePowerReqDto listUpReqDto, Pageable pageable,
      {FBallListUpUseCaseOutputPort outputPort}) async {
    PageWrap<FBallResDto> pageWrap =
        await _fBallRepository.listUpFromInfluencePower(
            listUpReqDto: listUpReqDto, pageable: pageable);
    executeOutPort(outputPort, pageWrap);
    return pageWrap;
  }

  @override
  Future<PageWrap<FBallResDto>> searchFBallListUpFromMapArea(
      BallFromMapAreaReqDto reqDto, Pageable pageable,
      {FBallListUpUseCaseOutputPort outputPort}) async {
    PageWrap<FBallResDto> pageWrap = await _fBallRepository
        .ballListUpFromMapArea(reqDto: reqDto, pageable: pageable);
    executeOutPort(outputPort, pageWrap);
    return pageWrap;
  }

  void executeOutPort(
      FBallListUpUseCaseOutputPort outputPort, PageWrap<FBallResDto> pageWrap) {
    if (outputPort != null) {
      outputPort.searchResult(pageWrap);
    }
  }

  @override
  Future<PageWrap<FBallResDto>> searchFBallListUpFromSearchTagName(
      FBallListUpFromTagNameReqDto reqDto, Pageable pageable,
      {FBallListUpUseCaseOutputPort outputPort}) async {
    PageWrap<FBallResDto> pageWrap = await _fBallRepository.listUpFromTagName(
        reqDto: reqDto, pageable: pageable);
    executeOutPort(outputPort, pageWrap);
    return pageWrap;
  }

  @override
  Future<PageWrap<FBallResDto>> searchFBallListUpFromSearchTitle(
      FBallListUpFromSearchTitleReqDto reqDto, Pageable pageable,
      {FBallListUpUseCaseOutputPort outputPort}) async {
    PageWrap<FBallResDto> pageWrap = await _fBallRepository
        .listUpFromSearchTitle(reqDto: reqDto, pageable: pageable);
    executeOutPort(outputPort, pageWrap);
    return pageWrap;
  }

  @override
  Future<PageWrap<FBallResDto>> searchFBallListUpUserPlayBall(
      String playerUid, Pageable pageable,
      {FBallListUpUseCaseOutputPort outputPort}) async {
    PageWrap<FBallPlayerResDto> pageWrap =
        await _fBallPlayerRepository.getUserPlayBallList(playerUid, pageable);
    var contentList = pageWrap.content.map((e) => e.ballUuid).toList();
    PageWrap<FBallResDto> pageFBallResDto = PageWrap<FBallResDto>(
        pageable: pageWrap.pageable,
        size: pageWrap.size,
        sort: pageWrap.sort,
        empty: pageWrap.empty,
        first: pageWrap.first,
        last: pageWrap.last,
        number: pageWrap.number,
        numberOfElements: pageWrap.numberOfElements,
        totalElements: pageWrap.totalElements,
        totalPages: pageWrap.totalPages,
        content: contentList);
    return pageFBallResDto;
  }
}
