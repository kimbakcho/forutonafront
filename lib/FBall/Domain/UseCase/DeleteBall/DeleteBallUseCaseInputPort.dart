import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';

abstract class DeleteBallUseCaseInputPort {
  Future<String> deleteBall(String ballUuid,{DeleteBallUseCaseOutputPort outputPort});
}
abstract class DeleteBallUseCaseOutputPort {
  void onDeleteBall(String ballUuid);
}
class DeleteBallUseCase implements DeleteBallUseCaseInputPort {

  final FBallRepository _fBallRepository;

  DeleteBallUseCase({FBallRepository fBallRepository})
      : _fBallRepository = fBallRepository;

  @override
  Future<String> deleteBall(String ballUuid, {DeleteBallUseCaseOutputPort outputPort}) async {
    String deleteBall = await _fBallRepository.deleteBall(ballUuid);
    if (outputPort != null) {
      outputPort.onDeleteBall(deleteBall);
    }
    return deleteBall;
  }

}
