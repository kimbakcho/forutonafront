import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FBall/Data/DataStore/FBallRemoteDataSource.dart';
import 'package:forutonafront/FBall/Data/Repository/FBallRepositoryImpl.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Domain/UseCase/UserMakeBallListUp/UserMakeBallListUpUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToMakeBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToMakeBallResDto.dart';

import 'UserMakeBallListUpUseCaseOutputPort.dart';

class UserMakeBallListUpUseCase implements UserMakeBallListUpUseCaseInputPort{

  FBallRepository _fBallRepository = new FBallRepositoryImpl(fBallRemoteDataSource: FBallRemoteSourceImpl());

  @override
  Future<List<UserToMakeBallResDto>> userMakeBallListUp({@required UserToMakeBallReqDto reqDto,UserMakeBallListUpUseCaseOutputPort outputPort}) async{
    var userToMakeBallWrap = await _fBallRepository.getUserToMakerBalls(reqDto: reqDto);
    var result = userToMakeBallWrap.contents.map((x) => UserToMakeBallResDto.fromUserToMakerBall(x)).toList();
    if(outputPort != null){
      outputPort.onUserMakeBallListUp(result);
    }

    return result;
  }

}