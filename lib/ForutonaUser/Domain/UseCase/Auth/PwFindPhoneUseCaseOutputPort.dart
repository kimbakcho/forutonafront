import 'package:forutonafront/ForutonaUser/Data/Value/PwChangeFromPhoneAuth.dart';

abstract class  PwFindPhoneUseCaseOutputPort {
  void onPhonePwChange(PwChangeFromPhoneAuth pwChangeFromPhoneAuthResDto);
}
