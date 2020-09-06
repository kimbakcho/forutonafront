import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnGroup/INavBtnGroup.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnGroup/TopNavBtnComponent.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnGroup/TopNavBtnMediator.dart';
import 'package:mockito/mockito.dart';

class MockTopNavBtnComponent extends Mock implements TopNavBtnComponent{}
class MockINavBtnGroup extends Mock implements INavBtnGroup{}
void main (){

  TopNavBtnMediator navBtnMediator;

  setUp((){
    navBtnMediator = TopNavBtnMediatorImpl();
  });

  test('컴포넌트 등록', () async {
    //arrange
    MockTopNavBtnComponent topNavBtnComponent = MockTopNavBtnComponent();
    //act
    navBtnMediator.registerComponent(topNavBtnComponent);
    navBtnMediator.openNavList();
    //assert
    verify(topNavBtnComponent.aniForward());
  });

  test('컴포넌트 해지', () async {
    //arrange
    MockTopNavBtnComponent topNavBtnComponent = MockTopNavBtnComponent();
    //act
    navBtnMediator.registerComponent(topNavBtnComponent);
    navBtnMediator.unRegisterComponent(topNavBtnComponent);
    //assert
    verifyNever(topNavBtnComponent.aniForward());
  });

  test('메디에이터 NavOpen 상태 테스트', () async {
    //arrange
    MockTopNavBtnComponent topNavBtnComponent = MockTopNavBtnComponent();
    //act
    navBtnMediator.openNavList();
    //assert
    expect(navBtnMediator.aniState,equals(NavBtnMediatorState.Open));
  });

  test('메디에이터 NavClose 상태 테스트', () async {
    //arrange
    MockTopNavBtnComponent topNavBtnComponent = MockTopNavBtnComponent();
    //act
    navBtnMediator.closeNavList();
    //assert
    expect(navBtnMediator.aniState,equals(NavBtnMediatorState.Close));
  });

  test('메디에이터 open 시에 Group Stack index 실행 ', () async {
    //arrange
    MockINavBtnGroup mockINavBtnGroup = MockINavBtnGroup();
    navBtnMediator.iNavBtnGroup = mockINavBtnGroup;
    //act
    navBtnMediator.openNavList();
    //assert
    verify(mockINavBtnGroup.arrangeBtnIndexStack(top: anyNamed("top")));
  });


}