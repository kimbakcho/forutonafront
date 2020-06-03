import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Data/DataStore/IIssueBallTypeRemoteDateSource.dart';
import 'package:forutonafront/FBall/Data/Entity/FBall.dart';
import 'package:forutonafront/FBall/Data/Entity/IssueBall.dart';
import 'package:forutonafront/FBall/Data/Repository/IssueBallTypeRepositoryImpl.dart';
import 'package:forutonafront/FBall/Data/Value/FBallType.dart';
import 'package:forutonafront/FBall/Domain/Repository/IssueBallTypeRepository.dart';
import 'package:forutonafront/FBall/Dto/FBallJoinReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';

import 'IssueBallUseCaseIp.dart';
import 'IssueBallUseCaseOp.dart';

class IssueBallUseCase implements IssueBallUseCaseIp {
  IssueBallTypeRepository issueBallTypeRepository =
      new IssueBallTypeRepositoryImpl(
          issueBallTypeRemoteDateSource: new IssueBallTypeRemoteDateSource());

  @override
  Future<int> ballHit({@required FBallReqDto reqDto,@required IssueBallUseCaseOp op}) async {
    op.onBallHit();
    return await issueBallTypeRepository.ballHit(reqDto);
  }

  @override
  Future<int> joinBall({@required FBallJoinReqDto reqDto}) async{
    return await issueBallTypeRepository.joinBall(reqDto);
  }

  @override
  Future<FBallResDto> selectBall({@required String ballUuid,@required IssueBallUseCaseOp op}) async{
    FBallReqDto fBallReqDto = FBallReqDto(FBallType.IssueBall, ballUuid);
    var fBall = await issueBallTypeRepository.selectBall(fBallReqDto);
    var result = FBallResDto.fromFBall(fBall);
    op.onSelectBall(result);
    return result;
  }

  @override
  Future<int> deleteBall({String ballUuid,@required IssueBallUseCaseOp op}) async{
    FBallReqDto fBallReqDto = FBallReqDto(FBallType.IssueBall, ballUuid);
    op.onDeleteBall();
    var result = await issueBallTypeRepository.deleteBall(fBallReqDto);
    return result;
  }



}
