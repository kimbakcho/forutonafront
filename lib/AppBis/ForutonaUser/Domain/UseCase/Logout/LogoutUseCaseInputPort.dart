import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/Logout/LogoutUseCaseOutputPort.dart';

abstract class LogoutUseCaseInputPort {
  tryLogout({LogoutUseCaseOutputPort outputPort});
}