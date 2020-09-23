import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/ForutonaUser/Dto/UserPolicyResDto.dart';
import 'package:injectable/injectable.dart';

abstract class UserPolicyRemoteDataSource {
  Future<UserPolicyResDto> getPersonaSettingNotice(String policy,FDio noneToken);
}
@LazySingleton(as: UserPolicyRemoteDataSource)
class UserPolicyRemoteDataSourceImpl implements UserPolicyRemoteDataSource{

  @override
  Future<UserPolicyResDto> getPersonaSettingNotice(String policy,FDio noneToken) async {
    var response = await noneToken.get("/v1/UserPolicy/"+policy);
    return UserPolicyResDto.fromJson(response.data);
  }

}