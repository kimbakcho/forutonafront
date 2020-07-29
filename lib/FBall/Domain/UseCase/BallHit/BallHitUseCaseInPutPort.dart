import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';

abstract class BallHitUseCaseInPutPort {
  Future<int> hit(String ballUuid);
}
class BallHitUseCase implements BallHitUseCaseInPutPort {

  final FBallRepository _fBallRepository;

  BallHitUseCase({@required FBallRepository fBallRepository})
      : _fBallRepository = fBallRepository;

  @override
  Future<int> hit(String ballUuid) async {
     return await _fBallRepository.ballHit(ballUuid);
  }
}