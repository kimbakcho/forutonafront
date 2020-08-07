import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';

abstract class HitBallUseCaseInputPort {
   Future<int> hit(String ballUuid);
}
class HitBallUseCase implements HitBallUseCaseInputPort{

  final FBallRepository _fBallRepository;

  HitBallUseCase({FBallRepository fBallRepository})
      : _fBallRepository = fBallRepository;

  @override
  Future<int> hit(String ballUuid) async {
      return await _fBallRepository.ballHit(ballUuid);
  }

}