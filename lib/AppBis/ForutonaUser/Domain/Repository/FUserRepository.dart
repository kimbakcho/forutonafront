
import 'package:forutonafront/AppBis/ForutonaUser/Dto/UserAlarmConfigUpdateReqDto.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserAccountUpdateReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoJoinReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoJoinResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoSimpleResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserSnsCheckJoinResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class FUserRepository {
  Future<FUserInfoResDto> findByMe();

  Future<void> updateUserPosition(LatLng latLng);

  Future<void> updateFireBaseMessageToken(String token);

  Future<bool> checkNickNameDuplication(String nickName);

  Future<String> uploadUserProfileImage(List<int> imageByte);

  Future<FUserInfoResDto> updateAccountUserInfo(
      FUserAccountUpdateReqDto reqDto,List<int> profileImage,List<int> backgroundImage);

  Future<void> pWChange(String pw);

  Future<FUserSnsCheckJoinResDto> getSnsUserJoinCheckInfo(
      SnsSupportService snsService, String accessToken);

  Future<FUserInfoJoinResDto> joinUser(FUserInfoJoinReqDto reqDto,List<int> profileImage,List<int> backgroundImage);

  Future<PageWrap<FUserInfoSimpleResDto>> findByUserNickNameWithFullTextMatchIndex(
      String searchNickName, Pageable pageable);

  Future<void> updateMaliciousMessageCheck();

  Future<FUserInfoSimpleResDto> getFUserInfoSimple(String userUid) {}

  Future<FUserInfoResDto> userAlarmConfigUpdate(UserAlarmConfigUpdateReqDto userAlarmConfigUpdateReqDto);
}
