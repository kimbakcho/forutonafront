
import 'PwFindPhoneUseCaseOutputPort.dart';

abstract class PwFindPhoneUseCaseInputPort {
  String email;
  String emailPhoneAuthToken;
  String internationalizedPhoneNumber;
  String password;
  Future<void> phonePwChange({PwFindPhoneUseCaseOutputPort outputPort});
}