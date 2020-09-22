import 'package:flutter/material.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/ForutonaUser/Data/DataSource/FUserRemoteDataSource.dart';
import 'package:forutonafront/ForutonaUser/Domain/Entity/FUserInfo.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoJoinReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoJoinResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnsCheckJoinResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserAccountUpdateReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthBaseAdapter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: FUserRepository)
class FUserRepositoryImpl implements FUserRepository {
  final FireBaseAuthBaseAdapter _fireBaseAuthBaseAdapter;

  final FUserRemoteDataSource _fUserRemoteDataSource;

  FUserRepositoryImpl(
      {@required FireBaseAuthBaseAdapter fireBaseAuthBaseAdapter,
      @required FUserRemoteDataSource fUserRemoteDataSource})
      : _fireBaseAuthBaseAdapter = fireBaseAuthBaseAdapter,
        _fUserRemoteDataSource = fUserRemoteDataSource;

  @override
  Future<void> updateUserPosition(LatLng latLng) async {
    return await _fUserRemoteDataSource.updateUserPosition(
        latLng, FDio(await _fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }

  @override
  Future<void> updateFireBaseMessageToken(String fcmToken) async {
    return await _fUserRemoteDataSource.updateFireBaseMessageToken(
        fcmToken, FDio(await _fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }

  Future<bool> checkNickNameDuplication(String nickName) async {
    return await _fUserRemoteDataSource.checkNickNameDuplication(
        nickName, FDio.noneToken());
  }

  @override
  Future<String> uploadUserProfileImage(List<int> imageByte) async {
    return await _fUserRemoteDataSource.uploadUserProfileImage(
        imageByte, FDio(await _fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }

  @override
  Future<FUserInfoResDto> updateAccountUserInfo(
      FUserAccountUpdateReqDto reqDto) async {
    return await _fUserRemoteDataSource.updateAccountUserInfo(
        reqDto, FDio(await _fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }

  @override
  Future<void> pWChange(String changePwReqDto) async {
    return await _fUserRemoteDataSource.pWChange(changePwReqDto,
        FDio(await _fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }

  @override
  Future<FUserSnsCheckJoinResDto> getSnsUserJoinCheckInfo(
      SnsSupportService snsService, String accessToken) async {
    return await _fUserRemoteDataSource.getSnsUserJoinCheckInfo(
        snsService, accessToken, FDio.noneToken());
  }

  @override
  Future<FUserInfoJoinResDto> joinUser(FUserInfoJoinReqDto reqDto) async {
    return await _fUserRemoteDataSource.joinUser(reqDto, FDio.noneToken());
  }

  @override
  Future<FUserInfo> findByMe() async {
    return await _fUserRemoteDataSource.findByMe(FDio(await _fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }
}
