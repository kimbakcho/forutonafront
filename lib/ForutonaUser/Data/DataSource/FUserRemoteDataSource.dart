import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/ForutonaUser/Data/Entity/FUserInfoSimple1.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/UserPositionUpdateReqDto.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';

abstract class FUserRemoteDataSource {

  Future<FUserInfoSimple1> getUserInfoSimple1(FUserReqDto reqDto,FDio noneTokenFDio);
  Future<int> updateUserPosition(LatLng latLng,FDio tokenFDio);
  Future<int> updateFireBaseMessageToken(String uid,String token,FDio tokenFDio);

}

class FUserRemoteDataSourceImpl implements FUserRemoteDataSource{

  @override
  Future<FUserInfoSimple1> getUserInfoSimple1(FUserReqDto reqDto,FDio noneTokenFDio) async {
    var response = await noneTokenFDio.get("/v1/ForutonaUser/UserInfoSimple1",queryParameters: reqDto.toJson());
    return FUserInfoSimple1.fromJson(response.data) ;
  }

  @override
  Future<int> updateUserPosition(LatLng latLng,FDio tokenFDio) async {
    var response = await tokenFDio.put("/v1/ForutonaUser/UserPosition",data:UserPositionUpdateReqDto(
      lng: latLng.longitude,
      lat: latLng.latitude,
    ).toJson());
    return response.data;
  }

  @override
  Future<int> updateFireBaseMessageToken(String uid, String token,FDio tokenFDio) async {
    var response = await tokenFDio.put("/v1/ForutonaUser/FireBaseMessageToken",
    queryParameters: {
      "uid":uid,
      "token":token
    });
    return response.data;
  }

}