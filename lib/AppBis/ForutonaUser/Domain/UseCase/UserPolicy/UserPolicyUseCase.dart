import 'package:flutter/cupertino.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/Repository/UserPolicyRepository.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/UserPolicy/UserPolicyUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/UserPolicyResDto.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserPolicyUseCaseInputPort)
class UserPolicyUseCase implements UserPolicyUseCaseInputPort {
  final UserPolicyRepository _userPolicyRepository;

  UserPolicyUseCase({@required UserPolicyRepository userPolicyRepository})
      : _userPolicyRepository = userPolicyRepository;

  @override
  Future<UserPolicyResDto> getUserPolicy(String policy) async {
    return await _userPolicyRepository.getUserPolicy(policy);
  }
}
