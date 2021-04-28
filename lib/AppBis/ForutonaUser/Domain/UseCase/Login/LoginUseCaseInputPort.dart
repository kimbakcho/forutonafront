import 'package:forutonafront/AppBis/ForutonaUser/Dto/SnsSupportService.dart';

abstract class LoginUseCaseInputPort {
  Future<bool> tryLogin();
  SnsSupportService? getSnsSupportService();
}
