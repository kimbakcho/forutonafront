import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoSimpleResDto.dart';

class FUserInfoSimpleTestUtil {
  static FUserInfoSimpleResDto getBasicUserResDto(String userUid){
    FUserInfoSimpleResDto fUserInfoSimpleResDto = FUserInfoSimpleResDto();
    fUserInfoSimpleResDto.uid = userUid;
    fUserInfoSimpleResDto.profilePictureUrl =
    "https://storage.googleapis.com/publicforutona/profileimage/basicprofileimage.png";
    fUserInfoSimpleResDto.cumulativeInfluence = 2.0;
    fUserInfoSimpleResDto.followCount = 6;
    fUserInfoSimpleResDto.nickName = "TESTUser";
    fUserInfoSimpleResDto.isoCode = "KR";
    fUserInfoSimpleResDto.userLevel = 3.0;
    return fUserInfoSimpleResDto;
  }
}