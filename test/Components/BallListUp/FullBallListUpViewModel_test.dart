import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/Components/BallListUp/FullBallListUp.dart';
import 'package:mockito/mockito.dart';

class MockBallListMediator extends Mock implements BallListMediator{}

void main(){

  FullBallListUpViewModel fullBallListUpViewModel;
  MockBallListMediator mockBallListMediator;
  setUp((){
    mockBallListMediator =  MockBallListMediator();
    fullBallListUpViewModel = FullBallListUpViewModel(
      ballListMediator: mockBallListMediator
    );
  });

  test('should 생성시 행위 테스트', () async {
    //given

    //when

    //then
    verify(mockBallListMediator.registerComponent(fullBallListUpViewModel));
  });

  test('should 해제시 행위 테스트', () async {
    //given

    //when
    fullBallListUpViewModel.dispose();
    //then
    verify(mockBallListMediator.unregisterComponent(fullBallListUpViewModel));
  });


}