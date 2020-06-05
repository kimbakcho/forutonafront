import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Data/DataStore/FBallPlayerRemoteDataSource.dart';
import 'package:forutonafront/FBall/Data/Repository/FBallPlayerRepositoryImpl.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallPlayerRepository.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToPlayBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/UserBall/UserToPlayBallResDto.dart';

import 'UserPlayBallListUpUseCaseInputPort.dart';
import 'UserPlayBallListUpUseCaseOutputPort.dart';

class UserPlayBallListUpUseCase implements UserPlayBallListUpUseCaseInputPort{

  FBallPlayerRepository _ifBallPlayerRepository = FBallPlayerRepositoryImpl(ifBallPlayerRemoteDataSource: new FBallPlayerRemoteDataSourceImpl());

  @override
  Future<List<UserToPlayBallResDto>> userPlayBallListUp({@required UserToPlayBallReqDto reqDto,@required UserPlayBallListUpUseCaseOutputPort outputPort}) async{
    var userToPlayBallWrap = await _ifBallPlayerRepository.getUserPlayBallList(reqDto);
    final userToPlayBallResDtos = userToPlayBallWrap.contents.map((x) =>
        UserToPlayBallResDto.fromUserToPlayBall(x)).toList();
    if(outputPort != null){
      outputPort.onBallPlayerListUp(userToPlayBallResDtos);
    }
    return userToPlayBallResDtos;
  }
}