
import 'package:injectable/injectable.dart';

import '../FCMMessageUseCaseInputPort.dart';


@Named("ResumeMessageUseCase")
@LazySingleton(as: FCMMessageUseCaseInputPort)
class ResumeMessageUseCase implements FCMMessageUseCaseInputPort {
  @override
  Future<dynamic> message(Map<String, dynamic> message) async {
    print("ResumeMessageUseCase");
    print(message.toString());
    throw UnimplementedError();
  }

}