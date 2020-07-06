import 'package:forutonafront/ForutonaUser/Dto/UserPolicyResDto.dart';

abstract class UserPolicyUseCaseInputPort {
  Future<UserPolicyResDto> getUserPolicy(String policy);
}