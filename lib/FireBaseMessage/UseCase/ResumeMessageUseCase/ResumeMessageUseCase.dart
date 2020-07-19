import 'package:forutonafront/FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCaseInputPort.dart';

class ResumeMessageUseCase implements BaseMessageUseCaseInputPort {
  @override
  Future<dynamic> message(Map<String, dynamic> message) {
    print("ResumeMessageUseCase");
    print(message.toString());
    throw UnimplementedError();
  }

}