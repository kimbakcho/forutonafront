import 'package:forutonafront/AppBis/FBall/Domain/Repository/FBallRepository.dart';
import 'package:injectable/injectable.dart';

abstract class HitBallUseCaseInputPort {
   Future<int> hit(String ballUuid);
}
@LazySingleton(as: HitBallUseCaseInputPort)
class HitBallUseCase implements HitBallUseCaseInputPort{

  final FBallRepository _fBallRepository;

  HitBallUseCase({required FBallRepository fBallRepository})
      : _fBallRepository = fBallRepository;

  @override
  Future<int> hit(String ballUuid) async {
      return await _fBallRepository.ballHit(ballUuid);
  }

}