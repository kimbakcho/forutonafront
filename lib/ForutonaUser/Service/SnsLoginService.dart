import 'package:forutonafront/ForutonaUser/Dto/FUserSnSLoginReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnsCheckJoinResDto.dart';

class SnsLoginService {

  tryLogin() async{
    print("tryLogin");
  }

  Future<FUserSnsCheckJoinResDto> snsUidJoinCheck(FUserSnSLoginReqDto accessToken){
    print("checkSnsUidJoinCheck");
  }
}