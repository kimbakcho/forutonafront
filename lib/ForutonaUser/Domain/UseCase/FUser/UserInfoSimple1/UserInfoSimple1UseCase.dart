import 'package:flutter/cupertino.dart';
import 'package:forutonafront/ForutonaUser/Data/DataSource/FUserRemoteDataSource.dart';
import 'package:forutonafront/ForutonaUser/Data/Repository/FUserRepositoryImpl.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoSimple1ResDto.dart';

import 'package:forutonafront/ForutonaUser/Dto/FUserReqDto.dart';

import 'UserInfoSimple1UseCaseInputPort.dart';
import 'UserInfoSimple1UseCaseOutputPort.dart';

class UserInfoSimple1UseCase implements UserInfoSimple1UseCaseInputPort{


  FUserRepository _fUserRepository = FUserRepositoryImpl(fUserRemoteDataSource:FUserRemoteDataSourceImpl());

  @override
  Future<FUserInfoSimple1ResDto> getBallMakerInfo({@required FUserReqDto makerUid,UserInfoSimple1UseCaseOutputPort outputPort}) async {
     var fUserInfoSimple1 = await _fUserRepository.getUserInfoSimple1(reqDto: makerUid);
     var fUserInfoSimple1ResDto = FUserInfoSimple1ResDto.fromFUserInfoSimple1(fUserInfoSimple1);
     outputPort.onBallMakerInfo(fUserInfoSimple1ResDto);
     return fUserInfoSimple1ResDto;
  }

}