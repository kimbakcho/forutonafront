import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallReplyRepository.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallReply/FBallReplyUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallReply/FBallReplyUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyUpdateReqDto.dart';

class FBallReplyUseCase implements FBallReplyUseCaseInputPort {
  final FBallReplyRepository _fBallReplyRepository;


  FBallReplyUseCase({@required FBallReplyRepository fBallReplyRepository})
      : _fBallReplyRepository = fBallReplyRepository;

  @override
  Future<FBallReplyResDto> deleteFBallReply(String replyUuid,{FBallReplyUseCaseOutputPort outputPort}) async {
    var fBallReplyResDto = await _fBallReplyRepository.deleteFBallReply(replyUuid);
    if(outputPort != null){
      outputPort.onDeleteFBallReply(fBallReplyResDto);
    }
    return fBallReplyResDto;
  }

  @override
  Future<PageWrap<FBallReplyResDto>> reqFBallReply(FBallReplyReqDto reqDto,Pageable pageable,
      {FBallReplyUseCaseOutputPort outputPort}) async {
    PageWrap<FBallReplyResDto> pageWrapReply = await _fBallReplyRepository.getFBallReply(reqDto,pageable);
    if (outputPort != null) {
      outputPort.onFBallReply(pageWrapReply);
      outputPort.onFBallReplyTotalCount(pageWrapReply.totalElements);
    }
    return pageWrapReply;
  }

  @override
  Future<FBallReplyResDto> insertFBallReply(
      FBallReplyInsertReqDto reqDto,{FBallReplyUseCaseOutputPort outputPort}) async {
    var fBallReplyResDto = await _fBallReplyRepository.insertFBallReply(reqDto);
    if(outputPort != null){
      outputPort.onInsertFBallReply(fBallReplyResDto);
    }
    return fBallReplyResDto;
  }

  @override
  Future<FBallReplyResDto> updateFBallReply(FBallReplyUpdateReqDto reqDto,{FBallReplyUseCaseOutputPort outputPort}) async {
    var fBallReplyResDto = await _fBallReplyRepository.updateFBallReply(reqDto);
    if(outputPort != null){
      outputPort.onUpdateFBallReply(fBallReplyResDto);
    }
    return fBallReplyResDto;
  }

  Future<int> getBallReviewCount(String ballUuid) async{
    return await _fBallReplyRepository.getBallReviewCount(ballUuid);
  }

}
