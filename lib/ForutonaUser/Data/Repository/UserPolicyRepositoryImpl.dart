import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/ForutonaUser/Data/DataSource/UserPolicyRemoteDataSource.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/UserPolicy.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/UserPolicyRepository.dart';

class UserPolicyRepositoryImpl implements UserPolicyRepository {
  UserPolicyRemoteDataSource _userPolicyRemoteDataSource;

  UserPolicyRepositoryImpl(
      {@required UserPolicyRemoteDataSource userPolicyRemoteDataSource})
      : _userPolicyRemoteDataSource = userPolicyRemoteDataSource;

  @override
  Future<UserPolicy> getPersonaSettingNotice(String policy) async {
    var userPolicyResDto = await _userPolicyRemoteDataSource.getPersonaSettingNotice(policy, FDio.noneToken());
    return UserPolicy.fromUserPolicyResDto(userPolicyResDto);
  }
  
}
