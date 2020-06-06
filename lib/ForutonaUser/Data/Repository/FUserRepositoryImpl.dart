import 'package:flutter/material.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/ForutonaUser/Data/DataSource/FUserRemoteDataSource.dart';
import 'package:forutonafront/ForutonaUser/Data/Entity/FUserInfoSimple1.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserReqDto.dart';

class FUserRepositoryImpl implements FUserRepository{

  final FUserRemoteDataSource fUserRemoteDataSource;
  FUserRepositoryImpl({this.fUserRemoteDataSource});

  @override
  Future<FUserInfoSimple1> getUserInfoSimple1({@required FUserReqDto reqDto}) {
    return fUserRemoteDataSource.getUserInfoSimple1(reqDto: reqDto, noneTokenFDio: FDio.noneToken());
  }

}