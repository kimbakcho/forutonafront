import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/ForutonaUser/Data/Entity/FUserInfoSimple1.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserReqDto.dart';

abstract class FUserRemoteDataSource {
  Future<FUserInfoSimple1> getUserInfoSimple1({@required FUserReqDto reqDto,@required FDio noneTokenFDio});
}

class FUserRemoteDataSourceImpl implements FUserRemoteDataSource{

  @override
  Future<FUserInfoSimple1> getUserInfoSimple1({@required FUserReqDto reqDto,@required FDio noneTokenFDio }) async {
    var response = await noneTokenFDio.get("/v1/ForutonaUser/UserInfoSimple1",queryParameters: reqDto.toJson());
    return FUserInfoSimple1.fromJson(response.data) ;
  }

}