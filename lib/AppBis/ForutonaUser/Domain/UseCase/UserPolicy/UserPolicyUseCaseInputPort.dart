import 'package:forutonafront/AppBis/ForutonaUser/Dto/UserPolicyResDto.dart';

abstract class UserPolicyUseCaseInputPort {
  Future<UserPolicyResDto> getUserPolicy(String policy);
}