import 'package:flutter/cupertino.dart';
import 'package:forutonafront/FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCaseInputPort.dart';
import 'package:injectable/injectable.dart';

@named
@Injectable(as: BaseMessageUseCaseInputPort)
class BackGroundMessageUseCase implements BaseMessageUseCaseInputPort {
  BaseMessageUseCaseInputPort _baseMessageUseCaseInputPort;

  BackGroundMessageUseCase({
    @required BaseMessageUseCaseInputPort baseMessageUseCaseInputPort
  }) : _baseMessageUseCaseInputPort = baseMessageUseCaseInputPort;

  @override
  // ignore: missing_return
  Future<dynamic> message(Map<String, dynamic> message) {
    _baseMessageUseCaseInputPort.message(message);
  }

}
