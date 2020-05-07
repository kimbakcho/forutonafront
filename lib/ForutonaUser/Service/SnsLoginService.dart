import 'package:forutonafront/ForutonaUser/Dto/FUserSnSLoginReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnsCheckJoinResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';

class SnsLoginService {

  SnsSupportService getSupportSnsService(){
    return null;
  }
  String getToken(){
    return null;
  }

  Future<bool> tryLogin() async{
    print("tryLogin");
  }

  Future<FUserSnsCheckJoinResDto> snsUidJoinCheck(FUserSnSLoginReqDto accessToken) async{
    print("checkSnsUidJoinCheck");
  }
}