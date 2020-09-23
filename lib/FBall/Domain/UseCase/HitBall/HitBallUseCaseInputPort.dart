import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:injectable/injectable.dart';

abstract class HitBallUseCaseInputPort {
   Future<int> hit(String ballUuid);
}
@LazySingleton(as: HitBallUseCaseInputPort)
class HitBallUseCase implements HitBallUseCaseInputPort{

  final FBallRepository _fBallRepository;

  HitBallUseCase({FBallRepository fBallRepository})
      : _fBallRepository = fBallRepository;

  @override
  Future<int> hit(String ballUuid) async {
      return await _fBallRepository.ballHit(ballUuid);
  }

}