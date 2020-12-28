
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserSnsCheckJoinResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/Common/SnsLoginMoudleAdapter/FaceBookLoginAdapterImpl.dart';
import 'package:forutonafront/Common/SnsLoginMoudleAdapter/ForutonaLoginAdapterImpl.dart';
import 'package:forutonafront/Common/SnsLoginMoudleAdapter/KakaoLoginAdapterImpl.dart';
import 'package:injectable/injectable.dart';

import 'NaverLoginAdapterImpl.dart';

@lazySingleton
class SnsLoginModuleAdapterFactory {

  final FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;

  SnsLoginModuleAdapterFactory(this._fireBaseAuthAdapterForUseCase);

  SnsLoginModuleAdapter getInstance(SnsSupportService snsSupportService){
    switch(snsSupportService){
      case SnsSupportService.Naver:
        return NaverLoginAdapterImpl(_fireBaseAuthAdapterForUseCase);
      case SnsSupportService.Kakao:
        return KakaoLoginAdapterImpl(_fireBaseAuthAdapterForUseCase);
      case SnsSupportService.FaceBook:
        return FaceBookLoginAdapterImpl(_fireBaseAuthAdapterForUseCase);
      default:
        throw Exception("don't support");
    }
  }

  SnsLoginModuleAdapter getForutonaLoginAdapterInstance(String userEmailId,String password) {
    return ForutonaLoginAdapterImpl(_fireBaseAuthAdapterForUseCase,userEmailId,password);
  }

}


abstract class SnsLoginModuleAdapter {
  Future<SnsLoginModuleResDto> getSnsModuleUserInfo();
  SnsSupportService snsSupportService;
  Future<void> login(FUserSnsCheckJoinResDto fUserSnsCheckJoinResDto);
  Future<void> logout();
}

class SnsLoginModuleResDto {
  String uid;
  String accessToken;
  String userNickName;
  String email;
  String userProfileImageUrl;
  String appUid;
  SnsLoginModuleResDto(this.uid, this.accessToken,{this.userNickName,this.email,this.userProfileImageUrl,this.appUid});
}
