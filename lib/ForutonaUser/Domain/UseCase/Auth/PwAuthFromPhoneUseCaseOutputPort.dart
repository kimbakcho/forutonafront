import 'package:forutonafront/ForutonaUser/Data/Value/PhoneAuth.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthNumberResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthResDto.dart';

abstract class PwAuthFromPhoneUseCaseOutputPort {
  void onPhoneAuth(PhoneAuthResDto resDto);

  void onNumberAuthReq(PhoneAuthNumberResDto phoneAuthNumberResDto);
}