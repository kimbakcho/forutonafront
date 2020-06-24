import 'package:flutter/material.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/ForutonaUser/Data/DataSource/FUserRemoteDataSource.dart';
import 'package:forutonafront/ForutonaUser/Data/Entity/FUserInfoSimple1.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserReqDto.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthBaseAdapter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FUserRepositoryImpl implements FUserRepository {
  final FireBaseAuthBaseAdapter fireBaseAuthBaseAdapter;

  final FUserRemoteDataSource fUserRemoteDataSource;

  FUserRepositoryImpl(
      {@required this.fUserRemoteDataSource,
      @required this.fireBaseAuthBaseAdapter})
      : assert(fUserRemoteDataSource != null),
        assert(FireBaseAuthBaseAdapter != null);

  @override
  Future<FUserInfoSimple1> getUserInfoSimple1(FUserReqDto reqDto) {
    return fUserRemoteDataSource.getUserInfoSimple1(reqDto, FDio.noneToken());
  }

  @override
  Future<int> updateUserPosition(LatLng latLng) async {
    return await fUserRemoteDataSource.updateUserPosition(
        latLng, FDio(await fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }

  @override
  Future<int> updateFireBaseMessageToken(String uid, String token) async {
    return await fUserRemoteDataSource.updateFireBaseMessageToken(
        uid, token, FDio(await fireBaseAuthBaseAdapter.getFireBaseIdToken()));
  }
}
