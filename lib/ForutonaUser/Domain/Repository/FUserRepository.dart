import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/ForutonaUser/Data/Entity/FUserInfoSimple1.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserReqDto.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class FUserRepository {
  Future<FUserInfoSimple1> getUserInfoSimple1(FUserReqDto reqDto);
  Future<int> updateUserPosition(LatLng latLng);
  Future<int> updateFireBaseMessageToken(String uid, String token);
  Future<bool> checkNickNameDuplication(String nickName);

}