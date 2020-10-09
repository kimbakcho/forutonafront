import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/SwipeGestureRecognizer/SwipeGestureRecognizer.dart';
import 'package:forutonafront/MainPage/CodeMainPageController.dart';
import 'package:forutonafront/MainPage/CodeMainViewModel.dart';
import 'package:mockito/mockito.dart';

class MockSwipeGestureRecognizerController extends Mock implements SwipeGestureRecognizerController{}
class MockCodeMainPageChangeListener extends Mock implements CodeMainPageChangeListener{}
void main () {
  CodeMainPageController codeMainPageController;
  MockSwipeGestureRecognizerController mockSwipeGestureRecognizerController;

  setUp((){
    mockSwipeGestureRecognizerController = MockSwipeGestureRecognizerController();
    codeMainPageController = CodeMainPageControllerImpl(
      swipeGestureRecognizerController: mockSwipeGestureRecognizerController
    );

  });


  test('리스너 테스트' , () async {
    //given
    MockCodeMainPageChangeListener mockCodeMainPageChangeListener = new MockCodeMainPageChangeListener();
    codeMainPageController.addListener(mockCodeMainPageChangeListener);
    //when
    codeMainPageController.updateChangeListener();
    //then
    verify(mockCodeMainPageChangeListener.onChangeMainPage());
  });
}