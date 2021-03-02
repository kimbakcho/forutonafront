import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBallValuation/Domain/Repositroy/FBallValuationRepository.dart';
import 'package:forutonafront/AppBis/FBallValuation/Dto/FBallVoteReqDto.dart';
import 'package:forutonafront/AppBis/FBallValuation/Dto/FBallVoteResDto.dart';
import 'package:injectable/injectable.dart';

abstract class FBallValuationUseCaseInputPort {
  Future<FBallVoteResDto> ballVote(FBallVoteReqDto reqDto);
  Future<FBallVoteResDto> getBallVoteState(String ballUuid);
}

@LazySingleton(as: FBallValuationUseCaseInputPort)
class FBallValuationUseCase implements FBallValuationUseCaseInputPort {

  final FBallValuationRepository _fBallValuationRepository;

  FBallValuationUseCase({@required FBallValuationRepository fBallValuationRepository})
      : _fBallValuationRepository = fBallValuationRepository;

  @override
  Future<FBallVoteResDto> ballVote(FBallVoteReqDto reqDto) async{
    var fBallVoteResDto = await _fBallValuationRepository.ballVote(reqDto);
    return fBallVoteResDto;
  }

  @override
  Future<FBallVoteResDto> getBallVoteState(String ballUuid) async {
    var fBallVoteResDto = await _fBallValuationRepository.findByBallVoteState(ballUuid);
    return fBallVoteResDto;
  }
}