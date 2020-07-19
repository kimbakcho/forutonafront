import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/Notification/NotiChannel/NotificationChannelBaseInputPort.dart';
import 'package:forutonafront/FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCase.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:mockito/mockito.dart';

class MockNotificationChannelBaseInputPort extends Mock
    implements NotificationChannelBaseInputPort {}

void main() {
  BaseMessageUseCase baseMessageUseCase;
  MockNotificationChannelBaseInputPort mockNotificationChannelBaseInputPort;
  setUpAll((){
    sl.registerFactoryParam<NotificationChannelBaseInputPort, String, String>(
            (String commentKey, param2) {
          return mockNotificationChannelBaseInputPort;
        }, instanceName: "NotificationChannelBaseInputPortFactory");
  });
  setUp(() {
    mockNotificationChannelBaseInputPort =
        MockNotificationChannelBaseInputPort();
    baseMessageUseCase = BaseMessageUseCase();
  });

  test('isNotification & commandKey가 있을때 ', () async {
    //arrange
    Map<String, dynamic> dataMessage = Map<String, dynamic>();
    dataMessage["commandKey"] = "CommentChannelUseCase";
    dataMessage["isNotification"] = "true";
    Map<String, dynamic> message = Map<String, dynamic>();
    message["data"] = dataMessage;
    //act
    baseMessageUseCase.message(message);
    //assert
    verify(mockNotificationChannelBaseInputPort.reqNotification(message));
  });

  test('isNotification 가 false 일때 ', () async {
    //arrange
    Map<String, dynamic> dataMessage = Map<String, dynamic>();
    dataMessage["commandKey"] = "CommentChannelUseCase";
    dataMessage["isNotification"] = "false";
    Map<String, dynamic> message = Map<String, dynamic>();
    message["data"] = dataMessage;
    //act
    baseMessageUseCase.message(message);
    //assert
    verifyNever(mockNotificationChannelBaseInputPort.reqNotification(message));
  });

  test('isNotification 가 true 이고 commandKey 가 없을때 ', () async {
    //arrange
    Map<String, dynamic> dataMessage = Map<String, dynamic>();
    dataMessage["isNotification"] = "false";
    Map<String, dynamic> message = Map<String, dynamic>();
    message["data"] = dataMessage;
    //act
    baseMessageUseCase.message(message);
    //assert
    verifyNever(mockNotificationChannelBaseInputPort.reqNotification(message));
  });
}