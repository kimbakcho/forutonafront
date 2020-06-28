import 'package:flutter/material.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/ForutonaUser/Data/DataSource/FUserRemoteDataSource.dart';
import 'package:forutonafront/ForutonaUser/Data/Entity/FUserInfoSimple1.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserReqDto.dart';
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
    return await _fUserRemoteDataSource.updateFireBaseMessageToken(
        uid, fcmToken, FDio(await _fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }

  Future<bool> checkNickNameDuplication(String nickName) async {
    return await _fUserRemoteDataSource.checkNickNameDuplication(nickName, FDio.noneToken());
  }

}
