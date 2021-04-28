import 'package:flutter/cupertino.dart';
import 'package:forutonafront/AppBis/FBallValuation/Domain/Repositroy/FBallValuationRepository.dart';
import 'package:forutonafront/AppBis/FBallValuation/Domain/Value/LikeActionType.dart';
import 'package:forutonafront/AppBis/FBallValuation/Dto/FBallVoteReqDto.dart';
import 'package:forutonafront/AppBis/FBallValuation/Dto/FBallVoteResDto.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

abstract class BallLikeUseCaseInputPort {
  Future<FBallVoteResDto> ballLike(int point, String ballUuid,{BallLikeUseCaseOutputPort outputPort});

  Future<FBallVoteResDto?> getBallLikeState(String ballUuid,String uid);
}

abstract class BallLikeUseCaseOutputPort {
  onResult(FBallVoteResDto resDto);
}

@LazySingleton(as: BallLikeUseCaseInputPort)
class BallLikeUseCase implements BallLikeUseCaseInputPort {
  final FBallValuationRepository _fBallValuationRepository;

  BallLikeUseCase({required FBallValuationRepository fBallValuationRepository})
      : _fBallValuationRepository = fBallValuationRepository;

  @override
  ballDisLike(int point, String ballUuid,
      {BallLikeUseCaseOutputPort? outputPort}) async {
    FBallVoteReqDto likeReqDto = FBallVoteReqDto();
    // likeReqDto.valueUuid = Uuid().v4();
    likeReqDto.likePoint = 0;
    likeReqDto.disLikePoint = point;
    likeReqDto.ballUuid = ballUuid;
    // likeReqDto.likeActionType = LikeActionType.DISLIKE;
    FBallVoteResDto fBallLikeResDto = await _fBallValuationRepository.ballVote(likeReqDto);
    if(outputPort != null){
      outputPort.onResult(fBallLikeResDto);
    }
    return fBallLikeResDto;
  }

  @override
  ballDisLikeCancel(int point, String ballUuid,
      {BallLikeUseCaseOutputPort? outputPort}) async {
    FBallVoteReqDto likeReqDto = FBallVoteReqDto();
    // likeReqDto.valueUuid = null;
    likeReqDto.likePoint = 0;
    likeReqDto.disLikePoint = point;
    likeReqDto.ballUuid = ballUuid;
    likeReqDto.likeActionType = LikeActionType.CANCEL;
    FBallVoteResDto fBallLikeResDto = await _fBallValuationRepository.ballVote(likeReqDto);
    if(outputPort != null){
      outputPort.onResult(fBallLikeResDto);
    }
    return fBallLikeResDto;
  }

  @override
  ballLike(int point, String ballUuid, {BallLikeUseCaseOutputPort? outputPort}) async {
    FBallVoteReqDto likeReqDto = FBallVoteReqDto();
    // likeReqDto.valueUuid = Uuid().v4();
    likeReqDto.likePoint = point;
    likeReqDto.disLikePoint = 0;
    likeReqDto.ballUuid = ballUuid;
    // likeReqDto.likeActionType = LikeActionType.LIKE;
    FBallVoteResDto fBallLikeResDto = await _fBallValuationRepository.ballVote(likeReqDto);
    if(outputPort != null){
      outputPort.onResult(fBallLikeResDto);
    }
    return fBallLikeResDto;
  }

  @override
  ballLikeCancel(int point, String ballUuid,{BallLikeUseCaseOutputPort? outputPort}) async {
    FBallVoteReqDto likeReqDto = FBallVoteReqDto();
    // likeReqDto.valueUuid = Uuid().v4();
    likeReqDto.likePoint = point;
    likeReqDto.disLikePoint = 0;
    likeReqDto.ballUuid = ballUuid;
    likeReqDto.likeActionType = LikeActionType.CANCEL;
    FBallVoteResDto fBallLikeResDto = await _fBallValuationRepository.ballVote(likeReqDto);
    if(outputPort != null){
      outputPort.onResult(fBallLikeResDto);
    }
    return fBallLikeResDto;
  }

  @override
  Future<FBallVoteResDto?> getBallLikeState(String ballUuid, String uid,{BallLikeUseCaseOutputPort? outputPort}) async {
     // FBallVoteResDto fBallLikeResDto = await _fBallValuationRepository.getBallLikeState(ballUuid, uid);
     // if(outputPort != null){
     //   outputPort.onResult(fBallLikeResDto);
     // }
     // return fBallLikeResDto;
    return null;
  }
}
