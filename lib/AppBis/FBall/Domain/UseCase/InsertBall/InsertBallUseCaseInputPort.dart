import 'package:forutonafront/AppBis/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallInsertReqDto/FBallInsertReqDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:injectable/injectable.dart';

abstract class InsertBallUseCaseInputPort {
  Future<FBallResDto> insertBall(FBallInsertReqDto reqDto,{InsertBallUseCaseOutputPort outputPort});
}
abstract class InsertBallUseCaseOutputPort {
  onInsertBall(FBallResDto fBallResDto);
}
@LazySingleton(as: InsertBallUseCaseInputPort)
class InsertBallUseCase implements InsertBallUseCaseInputPort{

  final FBallRepository _fBallRepository;

  InsertBallUseCase({FBallRepository fBallRepository})
      : _fBallRepository = fBallRepository;
  @override
  insertBall(FBallInsertReqDto reqDto, {InsertBallUseCaseOutputPort outputPort}) async {
    var saveFBall = await _fBallRepository.insertBall(reqDto);
    if (outputPort != null) {
      outputPort.onInsertBall(saveFBall);
    }
    return saveFBall;
  }

}