import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/ForutonaUser/Service/Impl/FaceBookLoginService.dart';
import 'package:forutonafront/ForutonaUser/Service/Impl/ForutonaLoginService.dart';
import 'package:forutonafront/ForutonaUser/Service/Impl/KakaoLoginService.dart';
import 'package:forutonafront/ForutonaUser/Service/Impl/NaverLoginService.dart';

import 'package:forutonafront/ForutonaUser/Service/SnsLoginService.dart';

class SnsSupportServiceFactory {
  static SnsLoginService createSnsSupportService(SnsSupportService service) {
    if(service == SnsSupportService.FaceBook){
      return FaceBookLoginService();
    }else if(service == SnsSupportService.Naver){
      return NaverLoginService();
    }else if(service == SnsSupportService.Kakao){
      return KakaoLoginService();
    }else if(service == SnsSupportService.Forutona){
      return ForutonaLoginService();
    }else {
      return ForutonaLoginService();
    }
  }
}