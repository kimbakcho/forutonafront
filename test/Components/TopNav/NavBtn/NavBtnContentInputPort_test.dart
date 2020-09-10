import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/NavBtnComponent.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnMediator.dart';
import 'package:forutonafront/Components/TopNav/TopNavExpendGroup/TopNavExpendGroup.dart';
import 'package:forutonafront/Components/TopNav/TopNavRouterType.dart';
import 'package:forutonafront/MainPage/CodeMainViewModel.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart' as di;
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:mockito/mockito.dart';

class MockCodeMainViewModelInputPort extends Mock implements CodeMainViewModelInputPort{}
void main() {
  NavBtnContentInputPort navBtnContentInputPort;

  setUp(() {
    di.init();
    sl.allowReassignment = true;
    navBtnContentInputPort = NavBtnContent(
        topOnMoveMainPage: CodeState.H003CODE,
        btnColor: Colors.amber,
        btnIcon: Icon(Icons.print),
        navRouterType: TopNavRouterType.H003);
  });
  test('버튼 클릭시 애니메이션 Open 액션 테스트', () async {
    //arrange
    TopNavBtnMediator navBtnMediator = sl();


    navBtnMediator.aniState = NavBtnMediatorState.Close;
    //act
    await navBtnContentInputPort.onNavTopBtnTop();
    //assert
    expect(navBtnMediator.aniState, NavBtnMediatorState.Open);
  });

  test('버튼 클릭시 애니메이션 Close 액션 테스트', () async {
    //arrange
    TopNavBtnMediator navBtnMediator = sl();

    navBtnMediator.topNavExpendGroupViewModel = TopNavExpendGroupViewModel(null);

    MockCodeMainViewModelInputPort mockCodeMainViewModelInputPort = MockCodeMainViewModelInputPort();
    navBtnMediator.codeMainViewModelInputPort = mockCodeMainViewModelInputPort;

    navBtnMediator.aniState = NavBtnMediatorState.Open;
    //act
    await navBtnContentInputPort.onNavTopBtnTop();
    //assert
    expect(navBtnMediator.aniState, NavBtnMediatorState.Close);
    verify(mockCodeMainViewModelInputPort.jumpToPage(CodeState.H003CODE));
  });
}
