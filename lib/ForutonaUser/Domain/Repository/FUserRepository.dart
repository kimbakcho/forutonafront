import 'package:forutonafront/ForutonaUser/Domain/Entity/FUserInfo.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoJoinReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoJoinResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnsCheckJoinResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserAccountUpdateReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class FUserRepository {
  Future<FUserInfo> findByMe();
  Future<void> updateUserPosition(LatLng latLng);
  Future<void> updateFireBaseMessageToken(String token);
  Future<bool> checkNickNameDuplication(String nickName);
  Future<String> uploadUserProfileImage(List<int> imageByte);
  Future<FUserInfoResDto> updateAccountUserInfo(FUserAccountUpdateReqDto reqDto);
  Future<void> pWChange(String pw);
  Future<FUserSnsCheckJoinResDto> getSnsUserJoinCheckInfo(SnsSupportService snsService, String accessToken);
  Future<FUserInfoJoinResDto> joinUser(FUserInfoJoinReqDto reqDto);


}