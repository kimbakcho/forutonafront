import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/Components/BallStyle/BallOptionButton/BallOptionButtonAction.dart';
import 'package:forutonafront/Components/BallStyle/BallOptionButton/NoInterestBallAddAction.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/NoInterestBallUseCase/NoInterestBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:mockito/mockito.dart';


class MockBallListMediator extends Mock implements BallListMediator{}
class MockNoInterestBallUseCaseInputPort extends Mock implements NoInterestBallUseCaseInputPort{}
void main (){

  BallOptionButtonAction noInterestBallAddAction;

  MockBallListMediator mockBallListMediator;

  MockNoInterestBallUseCaseInputPort mockNoInterestBallUseCaseInputPort;
  setUp((){
    mockBallListMediator = MockBallListMediator();
    mockNoInterestBallUseCaseInputPort = MockNoInterestBallUseCaseInputPort();

  });
  test('관심 없음 처리 ', () async {
    //given
    FBallResDto fBallResDto = new FBallResDto();
    fBallResDto.ballUuid = "TEST Ball Uuid";

    noInterestBallAddAction = NoInterestBallAddAction(
        ballListMediator: mockBallListMediator,
        fBallResDto:fBallResDto,
        noInterestBallUseCaseInputPort: mockNoInterestBallUseCaseInputPort
    );
    //when
    await noInterestBallAddAction.execute();
    //then
    verify(mockNoInterestBallUseCaseInputPort.save("TEST Ball Uuid"));
    verify(mockBallListMediator.hideBall("TEST Ball Uuid"));

  });
}