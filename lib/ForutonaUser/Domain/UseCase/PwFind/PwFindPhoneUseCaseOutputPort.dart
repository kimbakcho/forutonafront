import 'package:forutonafront/ForutonaUser/Dto/PwChangeFromPhoneAuthResDto.dart';

abstract class  PwFindPhoneUseCaseOutputPort {
  void onPhonePwChange(PwChangeFromPhoneAuthResDto pwChangeFromPhoneAuthResDto);
}
