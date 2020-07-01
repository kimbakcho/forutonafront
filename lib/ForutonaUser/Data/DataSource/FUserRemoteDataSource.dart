import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/ForutonaUser/Data/Entity/FUserInfo.dart';
import 'package:forutonafront/ForutonaUser/Data/Entity/FUserInfoSimple1.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/FUserInfoJoin.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/FUserSnsCheckJoin.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoJoinReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoPwChangeReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnSLoginReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FuserAccountUpdateReqdto.dart';
import 'package:forutonafront/ForutonaUser/Dto/UserPositionUpdateReqDto.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';

abstract class FUserRemoteDataSource {

  Future<FUserInfoSimple1> getUserInfoSimple1(FUserReqDto reqDto,FDio noneTokenFDio);
  Future<int> updateUserPosition(LatLng latLng,FDio tokenFDio);
  Future<int> updateFireBaseMessageToken(String uid,String token,FDio tokenFDio);
  Future<bool> checkNickNameDuplication(String nickName,FDio noneTokenFDio);
  Future<FUserInfo> getForutonaGetMe(FDio tokenFDio);
  Future<String> uploadUserProfileImage(FormData formData,FDio tokenFDio);
  Future<int> updateAccountUserInfo(FuserAccountUpdateReqdto reqDto,FDio tokenFDio);
  Future<int> pWChange(FUserInfoPwChangeReqDto changePwReqDto,FDio tokenFDio);
  Future<FUserSnsCheckJoin> getSnsUserJoinCheckInfo(FUserSnSLoginReqDto reqDto,FDio noneTokenFDio);
  Future<FUserInfoJoin> joinUser(FUserInfoJoinReqDto reqDto, FDio noneTokenFDio);
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

  @override
  Future<bool> checkNickNameDuplication(String nickName,FDio noneTokenFDio) async{
    var response = await noneTokenFDio.get("/v1/ForutonaUser/checkNickNameDuplication",
        queryParameters: {"nickName": nickName});
    return response.data;
  }

  @override
  Future<FUserInfo> getForutonaGetMe(FDio tokenFDio) async{
    var response = await tokenFDio.get("/v1/ForutonaUser/Me");
    return FUserInfo.fromJson(response.data);
  }

  @override
  Future<String> uploadUserProfileImage(FormData formData,FDio tokenFDio) async {
    var response = await tokenFDio.put("/v1/ForutonaUser/ProfileImage",data: formData);
    return response.data;
  }

  @override
  Future<int> updateAccountUserInfo(FuserAccountUpdateReqdto reqDto, FDio tokenFDio) async {
    var response = await tokenFDio.put("/v1/ForutonaUser/AccountUserInfo",data: reqDto.toJson());
    return response.data;
  }

  @override
  Future<int> pWChange(FUserInfoPwChangeReqDto changePwReqDto, FDio tokenFDio) async {
    var response = await tokenFDio.put("/v1/ForutonaUser/PwChange",data: changePwReqDto.toJson());
    return response.data;
  }

  @override
  Future<FUserSnsCheckJoin> getSnsUserJoinCheckInfo(FUserSnSLoginReqDto reqDto, FDio noneTokenFDio) async {
    var response = await noneTokenFDio.get("/v1/ForutonaUser/SnsUserJoinCheckInfo",queryParameters: reqDto.toJson());
    return FUserSnsCheckJoin.fromJson(response.data);
  }

  @override
  Future<FUserInfoJoin> joinUser(FUserInfoJoinReqDto reqDto, FDio noneTokenFDio) async {
    var response = await noneTokenFDio.post("/v1/ForutonaUser/JoinUser",data:reqDto.toJson());
    return FUserInfoJoin.fromJson(response.data);
  }

}