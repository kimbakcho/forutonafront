import 'package:forutonafront/AppBis/ForutonaUser/Dto/PwChangeFromPhoneAuthResDto.dart';

abstract class  PwFindPhoneUseCaseOutputPort {
  void onPhonePwChange(PwChangeFromPhoneAuthResDto pwChangeFromPhoneAuthResDto);
}
