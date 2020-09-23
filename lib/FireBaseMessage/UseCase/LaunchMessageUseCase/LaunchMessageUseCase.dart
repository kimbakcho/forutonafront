

import 'package:forutonafront/FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCaseInputPort.dart';
import 'package:injectable/injectable.dart';

@named
@Injectable(as: BaseMessageUseCaseInputPort)
class LaunchMessageUseCase implements BaseMessageUseCaseInputPort {
  @override
  Future<dynamic> message(Map<String, dynamic> message) {
    print("LaunchMessageUseCase");
    print(message.toString());
    throw UnimplementedError();
  }

}