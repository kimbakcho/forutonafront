import 'package:flutter/cupertino.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/UserPolicyRepository.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/UserPolicy/UserPolicyUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Dto/UserPolicyResDto.dart';

class UserPolicyUseCase implements UserPolicyUseCaseInputPort {
  final UserPolicyRepository _userPolicyRepository;

  UserPolicyUseCase({@required UserPolicyRepository userPolicyRepository})
      : _userPolicyRepository = userPolicyRepository;

  @override
  Future<UserPolicyResDto> getUserPolicy(String policy) async {
    return await _userPolicyRepository.getUserPolicy(policy);
  }
}
