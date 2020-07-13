import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallReplyRepository.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallReply/FBallReplyUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallReply/FBallReplyUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResWrapDto.dart';

class FBallReplyUseCase implements FBallReplyUseCaseInputPort {
  final FBallReplyRepository _fBallReplyRepository;


  FBallReplyUseCase({@required FBallReplyRepository fBallReplyRepository})
      : _fBallReplyRepository = fBallReplyRepository;

  @override
  Future<int> deleteFBallReply(String replyUuid,{FBallReplyUseCaseOutputPort outputPort}) async {
    outputPort.onDeleteFBallReply(replyUuid);
    return await _fBallReplyRepository.deleteFBallReply(replyUuid);
  }

  @override
  Future<FBallReplyResWrapDto> reqFBallReply(FBallReplyReqDto reqDto,
      {FBallReplyUseCaseOutputPort outputPort}) async {
    var fBallReplyWrap = await _fBallReplyRepository.getFBallReply(reqDto);
    var fBallReplyResWrapDto =
        FBallReplyResWrapDto.fromFBallReplyResWrap(fBallReplyWrap);
    if (outputPort != null) {
      outputPort.onFBallReply(fBallReplyResWrapDto);
      outputPort.onFBallReplyTotalCount(fBallReplyResWrapDto.replyTotalCount);
    }
    return fBallReplyResWrapDto;
  }

  @override
  Future<FBallReplyResDto> insertFBallReply(
      FBallReplyInsertReqDto reqDto,{FBallReplyUseCaseOutputPort outputPort}) async {
    var fBallReply = await _fBallReplyRepository.insertFBallReply(reqDto);
    var fBallReplyResDto = FBallReplyResDto.fromFBallReply(fBallReply);
    outputPort.onInsertFBallReply(fBallReplyResDto);
    return fBallReplyResDto;
  }

  @override
  Future<FBallReplyResDto> updateFBallReply(FBallReplyInsertReqDto reqDto,{FBallReplyUseCaseOutputPort outputPort}) async {
    var fBallReply = await _fBallReplyRepository.updateFBallReply(reqDto);
    var fBallReplyResDto = FBallReplyResDto.fromFBallReply(fBallReply);
    outputPort.onUpdateFBallReply(fBallReplyResDto);
    return fBallReplyResDto;
  }

}
