import 'package:dio/src/form_data.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/ForutonaUser/Data/DataSource/FUserRemoteDataSource.dart';
import 'package:forutonafront/ForutonaUser/Data/Entity/FUserInfo.dart';
import 'package:forutonafront/ForutonaUser/Data/Entity/FUserInfoSimple1.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/FUserInfoJoin.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/FUserSnsCheckJoin.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoJoinReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoPwChangeReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnSLoginReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FuserAccountUpdateReqdto.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthBaseAdapter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FUserRepositoryImpl implements FUserRepository {
  final FireBaseAuthBaseAdapter _fireBaseAuthBaseAdapter;

  final FUserRemoteDataSource _fUserRemoteDataSource;

  FUserRepositoryImpl(
      {@required FireBaseAuthBaseAdapter fireBaseAuthBaseAdapter,
      @required FUserRemoteDataSource fUserRemoteDataSource})
      : _fireBaseAuthBaseAdapter = fireBaseAuthBaseAdapter,
        _fUserRemoteDataSource = fUserRemoteDataSource;

  @override
  Future<FUserInfoSimple1> getUserInfoSimple1(FUserReqDto reqDto) {
    return _fUserRemoteDataSource.getUserInfoSimple1(reqDto, FDio.noneToken());
  }

  @override
  Future<int> updateUserPosition(LatLng latLng) async {
    return await _fUserRemoteDataSource.updateUserPosition(
        latLng, FDio(await _fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }

  @override
  Future<int> updateFireBaseMessageToken(String uid, String fcmToken) async {
    return await _fUserRemoteDataSource.updateFireBaseMessageToken(uid,
        fcmToken, FDio(await _fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }

  Future<bool> checkNickNameDuplication(String nickName) async {
    return await _fUserRemoteDataSource.checkNickNameDuplication(
        nickName, FDio.noneToken());
  }

  @override
  Future<FUserInfo> getForutonaGetMe(String uid) async {
    return await _fUserRemoteDataSource.getForutonaGetMe(
        FDio(await _fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }

  @override
  Future<String> updateUserProfileImage(FormData formData) async {
    return await _fUserRemoteDataSource.updateUserProfileImage(
        formData, FDio(await _fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }

  @override
  Future<int> updateAccountUserInfo(FuserAccountUpdateReqdto reqDto) async {
    return await _fUserRemoteDataSource.updateAccountUserInfo(
        reqDto, FDio(await _fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }

  @override
  Future<int> pWChange(FUserInfoPwChangeReqDto changePwReqDto) async {
    return await _fUserRemoteDataSource.pWChange(changePwReqDto,
        FDio(await _fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }

  @override
  Future<FUserSnsCheckJoin> getSnsUserJoinCheckInfo(
      FUserSnSLoginReqDto reqDto) async {
    return await _fUserRemoteDataSource.getSnsUserJoinCheckInfo(
        reqDto, FDio.noneToken());
  }

  @override
  Future<FUserInfoJoin> joinUser(FUserInfoJoinReqDto reqDto) async {
    return await _fUserRemoteDataSource.joinUser(reqDto, FDio.noneToken());
  }

}
