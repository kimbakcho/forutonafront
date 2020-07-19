import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/Notification/MessageChanel/Domain/MessageChanelUseCaseInputPort.dart';
import 'package:forutonafront/FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCaseInputPort.dart';

class BackGroundMessageUseCase implements BaseMessageUseCaseInputPort {
  MessageChanelUseCaseInputPort _messageChanelUseCaseInputPort;

  BackGroundMessageUseCase(
      {@required MessageChanelUseCaseInputPort messageChanelUseCaseInputPort})
      : _messageChanelUseCaseInputPort = messageChanelUseCaseInputPort;

  @override
  Future<dynamic> message(Map<String, dynamic> message) {
    // TODO: implement message
    print("BackGroundMessageUseCase");
    _messageChanelUseCaseInputPort.reqNotification();
//    throw UnimplementedError();
  }
}
