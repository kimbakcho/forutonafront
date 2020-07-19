

import 'package:forutonafront/FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCaseInputPort.dart';

class LaunchMessageUseCase implements BaseMessageUseCaseInputPort {
  @override
  Future<dynamic> message(Map<String, dynamic> message) {
    print("LaunchMessageUseCase");
    print(message.toString());
    throw UnimplementedError();
  }

}