import 'package:forutonafront/FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCaseInputPort.dart';
import 'package:injectable/injectable.dart';


@named
@LazySingleton(as: BaseMessageUseCaseInputPort)
class ResumeMessageUseCase implements BaseMessageUseCaseInputPort {
  @override
  Future<dynamic> message(Map<String, dynamic> message) {
    print("ResumeMessageUseCase");
    print(message.toString());
    throw UnimplementedError();
  }

}