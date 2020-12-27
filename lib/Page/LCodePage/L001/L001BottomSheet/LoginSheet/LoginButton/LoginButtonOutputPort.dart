import 'package:flutter/cupertino.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/SnsSupportService.dart';

abstract class LoginButtonOutputPort {
  tryLogin(SnsSupportService snsSupportService,BuildContext context);
}