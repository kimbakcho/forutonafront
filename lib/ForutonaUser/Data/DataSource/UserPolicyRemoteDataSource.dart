import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/ForutonaUser/Dto/UserPolicyResDto.dart';

abstract class UserPolicyRemoteDataSource {
  Future<UserPolicyResDto> getPersonaSettingNotice(String policy,FDio noneToken);
}
class UserPolicyRemoteDataSourceImpl implements UserPolicyRemoteDataSource{

  @override
  Future<UserPolicyResDto> getPersonaSettingNotice(String policy,FDio noneToken) async {
    var response = await noneToken.get("/v1/ForutonaUser/UserPolicy/"+policy);
    return UserPolicyResDto.fromJson(response.data);
  }

}