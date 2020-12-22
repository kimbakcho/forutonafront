import 'package:forutonafront/AppBis/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:injectable/injectable.dart';

abstract class  SelectBallUseCaseInputPort {
  Future<FBallResDto> selectBall(String ballUuid,{SelectBallUseCaseOutputPort outputPort});
}
abstract class SelectBallUseCaseOutputPort {
  onSelectBall(FBallResDto fBallResDto);
}
@LazySingleton(as: SelectBallUseCaseInputPort)
class SelectBallUseCase implements SelectBallUseCaseInputPort{

  final FBallRepository _fBallRepository;

  SelectBallUseCase({FBallRepository fBallRepository})
      : _fBallRepository = fBallRepository;

  @override
  Future<FBallResDto> selectBall(String ballUuid,{SelectBallUseCaseOutputPort outputPort}) async {
    FBallResDto fBallResDto = await _fBallRepository.selectBall(ballUuid);
    if (outputPort != null) {
      outputPort.onSelectBall(fBallResDto);
    }
    return fBallResDto;
  }

}