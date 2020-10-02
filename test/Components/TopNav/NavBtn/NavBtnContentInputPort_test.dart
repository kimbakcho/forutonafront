import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/NavBtnAction.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/NavBtnComponent.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnMediator.dart';
import 'package:forutonafront/Components/TopNav/TopNavExpendGroup/TopNavExpendGroup.dart';
import 'package:forutonafront/MainPage/CodeMainViewModel.dart';
import 'package:mockito/mockito.dart';

class MockCodeMainViewModelInputPort extends Mock implements CodeMainViewModelInputPort{}
class MockNavBtnAction extends Mock implements NavBtnAction{}
void main() {
  NavBtnContentInputPort navBtnContentInputPort;
  TopNavBtnMediator navBtnMediator;
  MockNavBtnAction mockNavBtnAction;
  setUp(() {
    navBtnMediator  = TopNavBtnMediatorImpl();
    mockNavBtnAction = MockNavBtnAction();
    navBtnContentInputPort = NavBtnContent(
        topOnMoveMainPage: CodeState.H003CODE,
        btnColor: Colors.amber,
        btnIcon: Icon(Icons.print),
        navBtnMediator: navBtnMediator,
        navBtnAction: mockNavBtnAction,
    );
  });
  test('버튼 클릭시 애니메이션 Open 액션 테스트', () async {
    //arrange

    navBtnMediator.aniState = NavBtnMediatorState.Close;
    //act
    await navBtnContentInputPort.onNavTopBtnTop();
    //assert
    expect(navBtnMediator.aniState, NavBtnMediatorState.Open);
  });

  test('버튼 클릭시 애니메이션 Close 액션 테스트', () async {
    //arrange

    navBtnMediator.topNavExpendGroupViewModel = TopNavExpendGroupViewModel(context: null,topNavBtnMediator: navBtnMediator);

    MockCodeMainViewModelInputPort mockCodeMainViewModelInputPort = MockCodeMainViewModelInputPort();
    navBtnMediator.codeMainViewModelInputPort = mockCodeMainViewModelInputPort;

    navBtnMediator.aniState = NavBtnMediatorState.Open;
    //act
    await navBtnContentInputPort.onNavTopBtnTop();
    //assert
    expect(navBtnMediator.aniState, NavBtnMediatorState.Close);
    verify(mockCodeMainViewModelInputPort.jumpToPage(CodeState.H003CODE));
    verify(mockNavBtnAction.onCloseClick());
  });
}
