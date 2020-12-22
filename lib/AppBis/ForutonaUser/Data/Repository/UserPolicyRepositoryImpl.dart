import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Data/DataSource/UserPolicyRemoteDataSource.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/Repository/UserPolicyRepository.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/UserPolicyResDto.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserPolicyRepository)
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
