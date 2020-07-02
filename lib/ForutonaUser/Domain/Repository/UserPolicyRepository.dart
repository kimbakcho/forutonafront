import 'package:forutonafront/ForutonaUser/Data/Value/UserPolicy.dart';

abstract class UserPolicyRepository {
  Future<UserPolicy> getPersonaSettingNotice(String policy);
}