import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/ForutonaUser/Data/DataSource/UserPolicyRemoteDataSource.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/UserPolicyRepository.dart';
import 'package:forutonafront/ForutonaUser/Dto/UserPolicyResDto.dart';

class UserPolicyRepositoryImpl implements UserPolicyRepository {
  UserPolicyRemoteDataSource _userPolicyRemoteDataSource;

  UserPolicyRepositoryImpl(
      {@required UserPolicyRemoteDataSource userPolicyRemoteDataSource})
      : _userPolicyRemoteDataSource = userPolicyRemoteDataSource;

  @override
  Future<UserPolicyResDto> getUserPolicy(String policy) async {
    return await _userPolicyRemoteDataSource.getPersonaSettingNotice(policy, FDio.noneToken());
  }
  
}
