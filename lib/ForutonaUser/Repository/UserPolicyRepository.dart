
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/ForutonaUser/Dto/UserPolicyResDto.dart';

class UserPolicyRepository {
  Future<UserPolicyResDto> getPersonaSettingNotice(String policy ) async{
    FDio fDio = new FDio("noneToken");
    var response = await fDio.get("/v1/ForutonaUser/UserPolicy/"+policy);
    return UserPolicyResDto.fromJson(response.data);
  }
}