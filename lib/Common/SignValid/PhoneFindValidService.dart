import 'package:forutonafront/Common/SignValid/SignVaildService.dart';

abstract class PhoneFindValidService extends SignValidService {
  Future<void> phoneEmailIdValid(String phoneNumber,String email);
  bool hasPhoneEmailError();
  String phoneEmailErrorText();
}