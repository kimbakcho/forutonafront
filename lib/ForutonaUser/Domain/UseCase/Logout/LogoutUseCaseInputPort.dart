import 'package:forutonafront/ForutonaUser/Domain/UseCase/Logout/LogoutUseCaseOutputPort.dart';

abstract class LogoutUseCaseInputPort {
  tryLogout({LogoutUseCaseOutputPort outputPort});
}