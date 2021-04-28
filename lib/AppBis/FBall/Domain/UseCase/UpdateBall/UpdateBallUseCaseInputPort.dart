import 'package:forutonafront/AppBis/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallUpdateReqDto/FBallUpdateReqDto.dart';
import 'package:injectable/injectable.dart';

abstract class UpdateBallUseCaseInputPort {
  Future<FBallResDto> updateBall(FBallUpdateReqDto reqDto,
      {UpdateBallUseCaseOutputPort outputPort});
}

abstract class UpdateBallUseCaseOutputPort {
  onUpdateBall(FBallResDto fBallResDto);
}
@LazySingleton(as: UpdateBallUseCaseInputPort)
class UpdateBallUseCase implements UpdateBallUseCaseInputPort {
  final FBallRepository _fBallRepository;

  UpdateBallUseCase({required FBallRepository fBallRepository})
      : _fBallRepository = fBallRepository;

  @override
  Future<FBallResDto> updateBall(FBallUpdateReqDto reqDto,
      {UpdateBallUseCaseOutputPort? outputPort}) async {
    var fBallResDto = await _fBallRepository.updateBall(reqDto);
    if (outputPort != null) {
      outputPort.onUpdateBall(fBallResDto);
    }
    return fBallResDto;
  }
}
