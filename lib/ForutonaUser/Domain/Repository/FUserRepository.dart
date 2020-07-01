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
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class FUserRepository {
  Future<FUserInfoSimple1> getUserInfoSimple1(FUserReqDto reqDto);
  Future<int> updateUserPosition(LatLng latLng);
  Future<int> updateFireBaseMessageToken(String uid, String token);
  Future<bool> checkNickNameDuplication(String nickName);
  Future<FUserInfo> getForutonaGetMe(String uid);
  Future<String> uploadUserProfileImage(FormData formData);
  Future<int> updateAccountUserInfo(FuserAccountUpdateReqdto reqDto);
  Future<int> pWChange(FUserInfoPwChangeReqDto changePwReqDto);
  Future<FUserSnsCheckJoin> getSnsUserJoinCheckInfo(FUserSnSLoginReqDto reqDto);
  Future<FUserInfoJoin> joinUser(FUserInfoJoinReqDto reqDto);
}