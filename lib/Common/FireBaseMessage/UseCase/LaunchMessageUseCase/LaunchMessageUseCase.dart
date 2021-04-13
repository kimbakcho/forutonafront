


import 'package:injectable/injectable.dart';

import '../FCMMessageUseCaseInputPort.dart';

@Named("LaunchMessageUseCase")
@LazySingleton(as: FCMMessageUseCaseInputPort)
class LaunchMessageUseCase implements FCMMessageUseCaseInputPort {
  @override
  Future<dynamic> message(Map<String, dynamic> message) async {
    print("LaunchMessageUseCase");
    print(message.toString());
    throw UnimplementedError();
  }

}