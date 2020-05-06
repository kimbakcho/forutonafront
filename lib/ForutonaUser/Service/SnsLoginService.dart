import 'package:forutonafront/ForutonaUser/Dto/FUserSnSLoginReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnsCheckJoinResDto.dart';

class SnsLoginService {

  Future<bool> tryLogin() async{
    print("tryLogin");
  }

  Future<FUserSnsCheckJoinResDto> snsUidJoinCheck(FUserSnSLoginReqDto accessToken) async{
    print("checkSnsUidJoinCheck");
  }
}