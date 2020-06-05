import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Data/DataStore/IssueBallTypeRemoteDateSource.dart';
import 'package:forutonafront/FBall/Data/Repository/IssueBallTypeRepositoryImpl.dart';
import 'package:forutonafront/FBall/Data/Value/FBallType.dart';
import 'package:forutonafront/FBall/Domain/Repository/IssueBallTypeRepository.dart';
import 'package:forutonafront/FBall/Dto/FBallJoinReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

import 'IssueBallUseCaseInputPort.dart';
import 'IssueBallUseCaseOutputPort.dart';

class IssueBallUseCase implements IssueBallUseCaseInputPort {
  IssueBallTypeRepository issueBallTypeRepository =
      new IssueBallTypeRepositoryImpl(
          issueBallTypeRemoteDateSource: new IssueBallTypeRemoteDateSourceImpl());

  @override
  Future<int> ballHit({@required FBallReqDto reqDto,@required IssueBallUseCaseOutputPort outputPort}) async {
    if(outputPort != null){
      outputPort.onBallHit();
    }
    return await issueBallTypeRepository.ballHit(reqDto);
  }

  @override
  Future<int> joinBall({@required FBallJoinReqDto reqDto}) async{
    return await issueBallTypeRepository.joinBall(reqDto);
  }

  @override
  Future<FBallResDto> selectBall({@required String ballUuid,@required IssueBallUseCaseOutputPort outputPort}) async{
    FBallReqDto fBallReqDto = FBallReqDto(FBallType.IssueBall, ballUuid);
    var fBall = await issueBallTypeRepository.selectBall(fBallReqDto);
    var result = FBallResDto.fromFBall(fBall);
    if(outputPort != null){
      outputPort.onSelectBall(result);
    }
    return result;
  }

  @override
  Future<int> deleteBall({String ballUuid,@required IssueBallUseCaseOutputPort outputPort}) async{
    FBallReqDto fBallReqDto = FBallReqDto(FBallType.IssueBall, ballUuid);
    if(outputPort != null){
      outputPort.onDeleteBall();
    }
    var result = await issueBallTypeRepository.deleteBall(fBallReqDto);
    return result;
  }



}
