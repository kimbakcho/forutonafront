import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallValuationRepository.dart';
import 'package:forutonafront/FBall/Domain/Value/LikeActionType.dart';
import 'package:forutonafront/FBall/Dto/FBallLikeReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallLikeResDto.dart';
import 'package:uuid/uuid.dart';

abstract class BallLikeUseCaseInputPort {
  Future<FBallLikeResDto> ballLike(int point, String ballUuid);

  Future<FBallLikeResDto> ballDisLike(int point, String ballUuid);

  Future<FBallLikeResDto> ballLikeCancel(int point, String ballUuid);

  Future<FBallLikeResDto> ballDisLikeCancel(int point, String ballUuid);
}

abstract class BallLikeUseCaseOutputPort {
  onResult(FBallLikeResDto resDto);
}

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
    likeReqDto.likeActionType = LikeActionType.LIKE;
    return await _fBallValuationRepository.ballLike(likeReqDto);
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
    return await _fBallValuationRepository.ballLike(likeReqDto);
  }

  @override
  ballLike(int point, String ballUuid, {BallLikeUseCaseOutputPort outputPort}) async {
    FBallLikeReqDto likeReqDto = FBallLikeReqDto();
    likeReqDto.valueUuid = Uuid().v4();
    likeReqDto.likePoint = point;
    likeReqDto.disLikePoint = 0;
    likeReqDto.ballUuid = ballUuid;
    likeReqDto.likeActionType = LikeActionType.LIKE;
    return await _fBallValuationRepository.ballLike(likeReqDto);
  }

  @override
  ballLikeCancel(int point, String ballUuid) async {
    FBallLikeReqDto likeReqDto = FBallLikeReqDto();
    likeReqDto.valueUuid = Uuid().v4();
    likeReqDto.likePoint = point;
    likeReqDto.disLikePoint = 0;
    likeReqDto.ballUuid = ballUuid;
    likeReqDto.likeActionType = LikeActionType.CANCEL;
    return await _fBallValuationRepository.ballLike(likeReqDto);
  }
}
