import 'package:forutonafront/ForutonaUser/Dto/UserPolicyResDto.dart';

abstract class UserPolicyRepository {
  Future<UserPolicyResDto> getUserPolicy(String policy);
}