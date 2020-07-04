import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';

abstract class SnsLoginModuleAdapter {
  Future<SnsLoginModuleResDto> getSnsModuleUserInfo();
  SnsSupportService snsSupportService;
}

class SnsLoginModuleResDto {
  String uid;
  String accessToken;
  String userNickName;
  String email;
  String userProfileImageUrl;
  SnsLoginModuleResDto(this.uid, this.accessToken,{this.userNickName,this.email,this.userProfileImageUrl});
}
