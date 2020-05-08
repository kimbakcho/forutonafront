import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoJoinReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoJoinResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoPwChangeReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnSLoginReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnsCheckJoinResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FuserAccountUpdateReqdto.dart';
import 'package:forutonafront/ForutonaUser/Dto/NickNameDuplicationCheckResDto.dart';

class FUserRepository {
  Future<FUserInfoResDto> getForutonaGetMe() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    var idToken = await firebaseUser.getIdToken(refresh: true);
    FDio dio = FDio(idToken.token);
    var response = await dio.get("/v1/ForutonaUser/Me",
        queryParameters: FUserReqDto(firebaseUser.uid).toJson());

    return FUserInfoResDto.fromJson(response.data);
  }

  Future<NickNameDuplicationCheckResDto> checkNickNameDuplication(
      String nickName) async {
    FDio dio = FDio("none");
    var response = await dio.get("/v1/ForutonaUser/checkNickNameDuplication",
        queryParameters: {"nickName": nickName});
    return NickNameDuplicationCheckResDto.fromJson(response.data);
  }

  Future<String> updateUserProfileImage(File file) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    var idToken = await firebaseUser.getIdToken(refresh: true);
    FDio dio = FDio(idToken.token);
    FormData formData = FormData.fromMap({
      "ProfileImage": await MultipartFile.fromFile(file.path)
    });
    var response = await dio.put("/v1/ForutonaUser/ProfileImage",data: formData);
    return response.data;
  }


  Future<int> updateAccountUserInfo(FuserAccountUpdateReqdto reqDto)async{
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    var idToken = await firebaseUser.getIdToken(refresh: true);
    FDio dio = FDio(idToken.token);
    var response = await dio.put("/v1/ForutonaUser/AccountUserInfo",data: reqDto.toJson());
    return response.data;
  }

  Future<int> pWChange(FUserInfoPwChangeReqDto changePwReqDto)async{
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    var idToken = await firebaseUser.getIdToken(refresh: true);
    FDio dio = FDio(idToken.token);
    print(idToken.token);
    print(changePwReqDto.toJson());

      var response = await dio.put("/v1/ForutonaUser/PwChange",data: changePwReqDto.toJson());
      print(response.data);
      return int.parse(response.data);

  }

  ///클라이언트에서 개인 정보를 취득하는것을 막기위해 인증이 필요 없는 데이터만 가져 오기 위한 Simple 쿼리
  Future<FUserInfoResDto> getUserInfoSimple1(FUserReqDto reqDto) async {
    FDio dio = FDio("none");
    var response = await dio.get("/v1/ForutonaUser/UserInfoSimple1",queryParameters: reqDto.toJson());
    return FUserInfoResDto.fromJson(response.data) ;
  }

  Future<FUserSnsCheckJoinResDto> getSnsUserJoinCheckInfo(FUserSnSLoginReqDto reqDto) async{
    FDio dio = FDio("none");
    var response = await dio.get("/v1/ForutonaUser/SnsUserJoinCheckInfo",queryParameters: reqDto.toJson());
    return FUserSnsCheckJoinResDto.fromJson(response.data);
  }

  Future<FUserInfoJoinResDto> joinUser(FUserInfoJoinReqDto reqDto)async{
    FDio dio = FDio("none");
    var response = await dio.post("/v1/ForutonaUser/JoinUser",data:reqDto.toJson());
    return FUserInfoJoinResDto.fromJson(response.data);
  }


}
