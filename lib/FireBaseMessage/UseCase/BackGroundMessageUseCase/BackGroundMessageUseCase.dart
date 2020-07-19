import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/Notification/NotiChannel/NotificationChannelBaseInputPort.dart';
import 'package:forutonafront/FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCaseInputPort.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';

class BackGroundMessageUseCase implements BaseMessageUseCaseInputPort {
  BaseMessageUseCaseInputPort _baseMessageUseCaseInputPort;

  BackGroundMessageUseCase({
    @required BaseMessageUseCaseInputPort baseMessageUseCaseInputPort
  }) : _baseMessageUseCaseInputPort = baseMessageUseCaseInputPort;

  @override
  Future<dynamic> message(Map<String, dynamic> message) {
    _baseMessageUseCaseInputPort.message(message);
  }

}
