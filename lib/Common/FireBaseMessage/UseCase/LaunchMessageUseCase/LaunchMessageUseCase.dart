

import 'package:forutonafront/Common/FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCaseInputPort.dart';
import 'package:injectable/injectable.dart';

@named
@LazySingleton(as: BaseMessageUseCaseInputPort)
class LaunchMessageUseCase implements BaseMessageUseCaseInputPort {
  @override
  Future<dynamic> message(Map<String, dynamic> message) {
    print("LaunchMessageUseCase");
    print(message.toString());
    throw UnimplementedError();
  }

}