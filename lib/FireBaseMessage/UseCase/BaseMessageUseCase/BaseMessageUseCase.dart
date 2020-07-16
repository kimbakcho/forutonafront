

import 'package:forutonafront/Common/Notification/MessageChanel/Domain/MessageChanelUseCaseInputPort.dart';
import 'package:forutonafront/ServiceLocator.dart';

import 'BaseMessageUseCaseInputPort.dart';

class BaseMessageUseCase implements BaseMessageUseCaseInputPort{

  final MessageChanelUseCaseInputPort _messageChanelUseCaseInputPort = sl();

  @override
  message(Map<String, dynamic> message) {
    // TODO: implement message
    // TODO 여기에 일반 메시지 부분 구현 해야 함
    _messageChanelUseCaseInputPort.reqNotification();
  }

}