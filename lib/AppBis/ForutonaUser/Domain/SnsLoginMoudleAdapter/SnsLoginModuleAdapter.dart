import 'package:forutonafront/AppBis/ForutonaUser/Domain/SnsLoginMoudleAdapter/FaceBookLoginAdapterImpl.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/SnsLoginMoudleAdapter/ForutonaLoginAdapterImpl.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/SnsLoginMoudleAdapter/KakaoLoginAdapterImpl.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:injectable/injectable.dart';

import 'NaverLoginAdapterImpl.dart';

@LazySingleton()
class SnsLoginModuleAdapterFactory {
  SnsLoginModuleAdapter getInstance(SnsSupportService snsSupportService){
    switch(snsSupportService){
      case SnsSupportService.Naver:
        return NaverLoginAdapterImpl();
      case SnsSupportService.Kakao:
        return KakaoLoginAdapterImpl();
      case SnsSupportService.FaceBook:
        return FaceBookLoginAdapterImpl();
      case SnsSupportService.Forutona:
        return ForutonaLoginAdapterImpl();
      default:
        throw Exception("don't support");
    }
  }
}


abstract class SnsLoginModuleAdapter {
  Future<SnsLoginModuleResDto> getSnsModuleUserInfo();
  SnsSupportService snsSupportService;
  Future<void> logout();
}

class SnsLoginModuleResDto {
  String uid;
  String accessToken;
  String userNickName;
  String email;
  String userProfileImageUrl;
  SnsLoginModuleResDto(this.uid, this.accessToken,{this.userNickName,this.email,this.userProfileImageUrl});
}
