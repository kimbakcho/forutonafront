import 'package:forutonafront/AppBis/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:injectable/injectable.dart';

abstract class DeleteBallUseCaseInputPort {
  Future<String> deleteBall(String ballUuid,
      {DeleteBallUseCaseOutputPort outputPort});
}
abstract class DeleteBallUseCaseOutputPort {
  onDeleteBall(FBallResDto fBallResDto);
}
@LazySingleton(as: DeleteBallUseCaseInputPort)
class DeleteBallUseCase implements DeleteBallUseCaseInputPort {
  final FBallRepository _fBallRepository;

  DeleteBallUseCase({FBallRepository fBallRepository})
      : _fBallRepository = fBallRepository;


  @override
  Future<String> deleteBall(String ballUuid, {DeleteBallUseCaseOutputPort outputPort}) async {
     return await _fBallRepository.deleteBall(ballUuid);
  }
}
