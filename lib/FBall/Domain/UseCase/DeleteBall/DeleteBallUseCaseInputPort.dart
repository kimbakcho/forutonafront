import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

abstract class DeleteBallUseCaseInputPort {
  Future<String> deleteBall(String ballUuid,
      {DeleteBallUseCaseOutputPort outputPort});
}
abstract class DeleteBallUseCaseOutputPort {
  onDeleteBall(FBallResDto fBallResDto);
}
class DeleteBallUseCase implements DeleteBallUseCaseInputPort {
  final FBallRepository _fBallRepository;

  DeleteBallUseCase({FBallRepository fBallRepository})
      : _fBallRepository = fBallRepository;


  @override
  Future<String> deleteBall(String ballUuid, {DeleteBallUseCaseOutputPort outputPort}) async {
     return await _fBallRepository.deleteBall(ballUuid);
  }
}
