import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCase.dart';
import 'package:forutonafront/Common/FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCaseInputPort.dart';
import 'package:injectable/injectable.dart';

@named
@LazySingleton(as: BaseMessageUseCaseInputPort)
class BackGroundMessageUseCase implements BaseMessageUseCaseInputPort {
  BaseMessageUseCaseInputPort baseMessageUseCaseInputPort;

  BackGroundMessageUseCase({
    @required @Named.from(BaseMessageUseCase) this.baseMessageUseCaseInputPort
  }) ;

  @override
  // ignore: missing_return
  Future<dynamic> message(Map<String, dynamic> message) {
    baseMessageUseCaseInputPort.message(message);
  }

}
