import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/PhoneAuthUseCase/PhoneAuthUseCaseInputPort.dart';
import 'package:forutonafront/Common/SignValid/PhonePwFindValidUseCase/PhoneFindValidUseCase.dart';
import 'package:forutonafront/Components/PhoneAuthComponent/PhoneAuthComponent.dart';
import 'package:injectable/injectable.dart';

import 'PhoneAuthModeUseCase.dart';

@injectable
class PhoneAuthModeFactory {

  final PhoneAuthUseCaseInputPort phoneAuthUseCaseInputPort;

  final PhoneFindValidUseCase phoneFindValidUseCase;


  PhoneAuthModeFactory(this.phoneAuthUseCaseInputPort, this.phoneFindValidUseCase);

  PhoneAuthModeUseCase getInstance(PhoneAuthMode phoneAuthMode,PhoneAuthComponentController phoneAuthComponentController,{String email}) {
    switch(phoneAuthMode) {
      case PhoneAuthMode.SignIn:
        return SignPhoneAuthModeUseCase(phoneAuthUseCaseInputPort,phoneAuthComponentController);
      case PhoneAuthMode.PhonePwFind:
        return PwFindAuthModeUseCase(phoneAuthUseCaseInputPort,phoneAuthComponentController,email,phoneFindValidUseCase);
      default :
        throw new Exception("don't support Type");
    }

  }
}