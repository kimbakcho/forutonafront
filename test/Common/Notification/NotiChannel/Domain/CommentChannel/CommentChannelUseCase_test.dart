import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/Notification/NotiChannel/Domain/CommentChannel/CommentChannelBaseServiceUseCaseInputPort.dart';
import 'package:forutonafront/Common/Notification/NotiChannel/Domain/CommentChannel/CommentChannelUseCase.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:mockito/mockito.dart';

class MockCommentChannelBaseServiceUseCaseInputPort extends Mock
    implements CommentChannelBaseServiceUseCaseInputPort {}

void main() {
  CommentChannelUseCase commentChannelUseCase;
  MockCommentChannelBaseServiceUseCaseInputPort
      mockCommentChannelBaseServiceUseCaseInputPort;
  setUpAll(() {
    mockCommentChannelBaseServiceUseCaseInputPort =
        MockCommentChannelBaseServiceUseCaseInputPort();
    sl.registerFactoryParam<CommentChannelBaseServiceUseCaseInputPort, String,
        String>((serviceKey, param2) {
      return mockCommentChannelBaseServiceUseCaseInputPort;
    }, instanceName: "CommentChannelBaseServiceUseCaseInputPortFactory");
  });

  setUp(() {
    commentChannelUseCase = CommentChannelUseCase();
  });
  test('should serviceKey 가 있을때', () async {
    //arrange
    Map<String, dynamic> dataMessage = Map<String, dynamic>();
    dataMessage["serviceKey"] = "FBallRootReplyFCMService";
    Map<String, dynamic> message = Map<String, dynamic>();
    message["data"] = dataMessage;

    //act
    commentChannelUseCase.reqNotification(message);
    //assert
    verify(mockCommentChannelBaseServiceUseCaseInputPort.reqNotification(message, any));
  });

  test('should serviceKey 가 없을때', () async {
    //arrange
    Map<String, dynamic> dataMessage = Map<String, dynamic>();
    Map<String, dynamic> message = Map<String, dynamic>();
    message["data"] = dataMessage;
    //act
    commentChannelUseCase.reqNotification(message);
    //assert
    verifyNever(mockCommentChannelBaseServiceUseCaseInputPort.reqNotification(message, any));
  });
}
