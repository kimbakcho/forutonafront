import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallUpdateReqDto/FBallUpdateReqDto.dart';

abstract class UpdateBallUseCaseInputPort {
  Future<FBallResDto> updateBall(FBallUpdateReqDto reqDto,
      {UpdateBallUseCaseOutputPort outputPort});
}

abstract class UpdateBallUseCaseOutputPort {
  onUpdateBall(FBallResDto fBallResDto);
}

class UpdateBallUseCase implements UpdateBallUseCaseInputPort {
  final FBallRepository _fBallRepository;

  UpdateBallUseCase({FBallRepository fBallRepository})
      : _fBallRepository = fBallRepository;

  @override
  Future<FBallResDto> updateBall(FBallUpdateReqDto reqDto,
      {UpdateBallUseCaseOutputPort outputPort}) async {
    var fBallResDto = await _fBallRepository.updateBall(reqDto);
    if (outputPort != null) {
      outputPort.onUpdateBall(fBallResDto);
    }
    return fBallResDto;
  }
}
