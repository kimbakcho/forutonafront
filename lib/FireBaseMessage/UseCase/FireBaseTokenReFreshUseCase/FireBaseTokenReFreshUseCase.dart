
import 'FireBaseTokenReFreshUseCaseInputPort.dart';
class FireBaseTokenReFreshUseCase implements FireBaseTokenReFreshUseCaseInputPort{
  @override
  updateReFreshToken(String token) {
    print("FireBaseTokenReFreshUseCase");
    print("FireBase Token");
    print(token);
  }

}