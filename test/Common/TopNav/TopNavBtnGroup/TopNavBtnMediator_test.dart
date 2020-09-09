import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/TopNavBtnComponent.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnGroup/INavBtnGroup.dart';

import 'package:forutonafront/Components/TopNav/TopNavBtnMediator.dart';
import 'package:forutonafront/Components/TopNav/TopNavExpendGroup/TopNavExpendComponent.dart';
import 'package:forutonafront/Components/TopNav/TopNavRouterType.dart';

import 'package:mockito/mockito.dart';

class MockTopNavBtnComponent extends Mock implements TopNavBtnComponent{}
class MockTopNavExpendComponent extends Mock implements TopNavExpendComponent{}
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
    navBtnMediator.topNavBtnRegisterComponent(topNavBtnComponent);
    navBtnMediator.openNavList();
    //assert
    verify(topNavBtnComponent.aniForward());
  });

  test('컴포넌트 해지', () async {
    //arrange
    MockTopNavBtnComponent topNavBtnComponent = MockTopNavBtnComponent();
    //act
    navBtnMediator.topNavBtnRegisterComponent(topNavBtnComponent);
    navBtnMediator.topNavBtnUnRegisterComponent(topNavBtnComponent);
    //assert
    verifyNever(topNavBtnComponent.aniForward());
  });

  test('메디에이터 NavOpen 상태 테스트', () async {
    //arrange
    MockTopNavBtnComponent topNavBtnComponent = MockTopNavBtnComponent();
    MockTopNavExpendComponent mockTopNavExpendComponent = MockTopNavExpendComponent();
    when(mockTopNavExpendComponent.getTopNavRouterType()).thenAnswer((realInvocation) => TopNavRouterType.H001);
    navBtnMediator.topNavExpendRegisterComponent(mockTopNavExpendComponent);
    //act
    navBtnMediator.openNavList();
    //assert
    expect(navBtnMediator.aniState,equals(NavBtnMediatorState.Open));
  });

  test('메디에이터 NavClose 상태 테스트', () async {
    //arrange
    MockINavBtnGroup mockINavBtnGroup = MockINavBtnGroup();
    navBtnMediator.iNavBtnGroup = mockINavBtnGroup;

    MockTopNavBtnComponent topNavBtnComponent = MockTopNavBtnComponent();
    when(topNavBtnComponent.getTopNavRouterType()).thenAnswer((realInvocation) => TopNavRouterType.H001);
    navBtnMediator.topNavBtnRegisterComponent(topNavBtnComponent);


    //act
    navBtnMediator.closeNavList(navRouterType: TopNavRouterType.H003);
    //assert
    expect(navBtnMediator.aniState,equals(NavBtnMediatorState.Close));
    verify(mockINavBtnGroup.arrangeBtnIndexStack(top: anyNamed("top")));
  });



}