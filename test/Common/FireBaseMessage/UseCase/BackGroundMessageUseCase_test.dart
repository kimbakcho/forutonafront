import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/FireBaseMessage/UseCase/BackGroundMessageUseCase/BackGroundMessageUseCase.dart';
import 'package:forutonafront/Common/FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCaseInputPort.dart';
import 'package:mockito/mockito.dart';
class MockBaseMessageUseCaseInputPort extends Mock implements BaseMessageUseCaseInputPort{}
void main(){
  BackGroundMessageUseCase backGroundMessageUseCase;
  MockBaseMessageUseCaseInputPort mockBaseMessageUseCaseInputPort = MockBaseMessageUseCaseInputPort();
  setUp((){
    backGroundMessageUseCase = BackGroundMessageUseCase(
      baseMessageUseCaseInputPort: mockBaseMessageUseCaseInputPort
    );
  });
  test('should baseMessageUseCaseInputPort 호출', () async {
    //arrange
    Map<String,dynamic> message = Map<String,dynamic>();
    //act
    backGroundMessageUseCase.message(message);
    //assert
    verify(mockBaseMessageUseCaseInputPort.message(message));
  });
}