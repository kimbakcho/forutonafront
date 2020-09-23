import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBallValuation/Domain/Repositroy/FBallValuationRepository.dart';
import 'package:forutonafront/FBallValuation/Domain/Value/LikeActionType.dart';
import 'package:forutonafront/FBallValuation/Dto/FBallLikeReqDto.dart';
import 'package:forutonafront/FBallValuation/Dto/FBallLikeResDto.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

abstract class BallLikeUseCaseInputPort {
  Future<FBallLikeResDto> ballLike(int point, String ballUuid,{BallLikeUseCaseOutputPort outputPort});

  Future<FBallLikeResDto> ballDisLike(int point, String ballUuid,{BallLikeUseCaseOutputPort outputPort});

  Future<FBallLikeResDto> ballLikeCancel(int point, String ballUuid,{BallLikeUseCaseOutputPort outputPort});

  Future<FBallLikeResDto> ballDisLikeCancel(int point, String ballUuid,{BallLikeUseCaseOutputPort outputPort});

  Future<FBallLikeResDto> getBallLikeState(String ballUuid,String uid);
}

abstract class BallLikeUseCaseOutputPort {
  onResult(FBallLikeResDto resDto);
}
@LazySingleton(as: BallLikeUseCaseInputPort)
class BallLikeUseCase implements BallLikeUseCaseInputPort {
  final FBallValuationRepository _fBallValuationRepository;

  BallLikeUseCase({@required FBallValuationRepository fBallValuationRepository})
      : _fBallValuationRepository = fBallValuationRepository;

  @override
  ballDisLike(int point, String ballUuid,
      {BallLikeUseCaseOutputPort outputPort}) async {
    FBallLikeReqDto likeReqDto = FBallLikeReqDto();
    likeReqDto.valueUuid = Uuid().v4();
    likeReqDto.likePoint = 0;
    likeReqDto.disLikePoint = point;
    likeReqDto.ballUuid = ballUuid;
    likeReqDto.likeActionType = LikeActionType.DISLIKE;
    FBallLikeResDto fBallLikeResDto = await _fBallValuationRepository.ballLike(likeReqDto);
    if(outputPort != null){
      outputPort.onResult(fBallLikeResDto);
    }
    return fBallLikeResDto;
  }

  @override
  ballDisLikeCancel(int point, String ballUuid,
      {BallLikeUseCaseOutputPort outputPort}) async {
    FBallLikeReqDto likeReqDto = FBallLikeReqDto();
    likeReqDto.valueUuid = null;
    likeReqDto.likePoint = 0;
    likeReqDto.disLikePoint = point;
    likeReqDto.ballUuid = ballUuid;
    likeReqDto.likeActionType = LikeActionType.CANCEL;
    FBallLikeResDto fBallLikeResDto = await _fBallValuationRepository.ballLike(likeReqDto);
    if(outputPort != null){
      outputPort.onResult(fBallLikeResDto);
    }
    return fBallLikeResDto;
  }

  @override
  ballLike(int point, String ballUuid, {BallLikeUseCaseOutputPort outputPort}) async {
    FBallLikeReqDto likeReqDto = FBallLikeReqDto();
    likeReqDto.valueUuid = Uuid().v4();
    likeReqDto.likePoint = point;
    likeReqDto.disLikePoint = 0;
    likeReqDto.ballUuid = ballUuid;
    likeReqDto.likeActionType = LikeActionType.LIKE;
    FBallLikeResDto fBallLikeResDto = await _fBallValuationRepository.ballLike(likeReqDto);
    if(outputPort != null){
      outputPort.onResult(fBallLikeResDto);
    }
    return fBallLikeResDto;
  }

  @override
  ballLikeCancel(int point, String ballUuid,{BallLikeUseCaseOutputPort outputPort}) async {
    FBallLikeReqDto likeReqDto = FBallLikeReqDto();
    likeReqDto.valueUuid = Uuid().v4();
    likeReqDto.likePoint = point;
    likeReqDto.disLikePoint = 0;
    likeReqDto.ballUuid = ballUuid;
    likeReqDto.likeActionType = LikeActionType.CANCEL;
    FBallLikeResDto fBallLikeResDto = await _fBallValuationRepository.ballLike(likeReqDto);
    if(outputPort != null){
      outputPort.onResult(fBallLikeResDto);
    }
    return fBallLikeResDto;
  }

  @override
  Future<FBallLikeResDto> getBallLikeState(String ballUuid, String uid,{BallLikeUseCaseOutputPort outputPort}) async {
     FBallLikeResDto fBallLikeResDto = await _fBallValuationRepository.getBallLikeState(ballUuid, uid);
     if(outputPort != null){
       outputPort.onResult(fBallLikeResDto);
     }
     return fBallLikeResDto;
  }
}
