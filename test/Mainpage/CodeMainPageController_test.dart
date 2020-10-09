import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/SwipeGestureRecognizer/SwipeGestureRecognizer.dart';
import 'package:forutonafront/MainPage/CodeMainPageController.dart';
import 'package:mockito/mockito.dart';

class MockSwipeGestureRecognizerController extends Mock
    implements SwipeGestureRecognizerController {}

class MockCodeMainPageChangeListener extends Mock
    implements CodeMainPageChangeListener {}

void main() {
  CodeMainPageController codeMainPageController;
  MockSwipeGestureRecognizerController mockSwipeGestureRecognizerController;

  setUp(() {
    mockSwipeGestureRecognizerController =
        MockSwipeGestureRecognizerController();
    codeMainPageController = CodeMainPageControllerImpl(
        mapCodeMainPageLink: Map(),
        swipeGestureRecognizerController: mockSwipeGestureRecognizerController,
        topNavBtnMediator: null,
        currentState: CodeState.H001CODE);
  });

  test('should', () {
    //given
    Map<CodeState, CodeMainPageLinkDto> maps =
        Map<CodeState, CodeMainPageLinkDto>();
    maps[CodeState.H001CODE] =
        CodeMainPageLinkDto(gestureFlag: false, pageNumber: 0);
    maps[CodeState.X001CODE] =
        CodeMainPageLinkDto(gestureFlag: false, pageNumber: 1);
    maps[CodeState.X002CODE] =
        CodeMainPageLinkDto(gestureFlag: false, pageNumber: 2);
    //when

    //then
    expect(maps[CodeState.H001CODE].pageNumber, 0);
    expect(maps[CodeState.X001CODE].pageNumber, 1);
    expect(maps[CodeState.X002CODE].pageNumber, 2);
  });

  test('리스너 테스트', () async {
    //given
    MockCodeMainPageChangeListener mockCodeMainPageChangeListener =
        new MockCodeMainPageChangeListener();
    codeMainPageController.addListener(mockCodeMainPageChangeListener);
    //when
    codeMainPageController.updateChangeListener();
    //then
    verify(mockCodeMainPageChangeListener.onChangeMainPage());
  });
}
