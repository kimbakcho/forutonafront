import 'package:forutonafront/ForutonaUser/Data/Value/UserPolicy.dart';

abstract class UserPolicyRepository {
  Future<UserPolicy> getUserPolicy(String policy);
}