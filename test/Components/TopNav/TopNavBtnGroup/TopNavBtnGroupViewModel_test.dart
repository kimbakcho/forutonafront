import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/NavBtn.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/NavBtnSetDto.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnGroup/INavBtnGroup.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnGroup/TopNavBtnGroupViewModel.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnMediator.dart';
import 'package:forutonafront/Components/TopNav/TopNavExpendGroup/H_I_001/GeoViewSearchManager.dart';

import 'package:forutonafront/MainPage/CodeMainPageController.dart';

import 'package:get_it/get_it.dart';

void main() {
  INavBtnGroup navBtnGroup;
  TopNavBtnMediator topNavBtnMediator;
  setUp(() {
    topNavBtnMediator = TopNavBtnMediatorImpl();
    final sl = GetIt.instance;
    sl.registerLazySingleton<GeoViewSearchManagerInputPort>(
        () => GeoViewSearchManager());
    navBtnGroup = TopNavBtnGroupViewModel(topNavBtnMediator: topNavBtnMediator);
  });

  test('top 버튼의 이름을 가진 Btn 스택 제일 뒤에 옮기기', () async {
    //arrange
    NavBtn mockINavBtn2 = new NavBtn(
      codeMainPageController: null,
        navBtnMediator: null,
        navBtnSetDto: NavBtnSetDto(topOnMoveMainPage: CodeState.H003CODE),
        originIndex: 2);
    NavBtn mockINavBtn1 = new NavBtn(
        codeMainPageController: null,
        navBtnMediator: null,
        navBtnSetDto: NavBtnSetDto(topOnMoveMainPage: CodeState.H001CODE),
        originIndex: 1);
    NavBtn mockINavBtn4 = new NavBtn(
        codeMainPageController: null,
        navBtnMediator: null,
        navBtnSetDto: NavBtnSetDto(topOnMoveMainPage: CodeState.X002CODE),
        originIndex: 4);
    NavBtn mockINavBtn3 = new NavBtn(
        codeMainPageController: null,
        navBtnMediator: null,
        navBtnSetDto: NavBtnSetDto(topOnMoveMainPage: CodeState.X001CODE),
        originIndex: 3);
    navBtnGroup.navBtnList = [
      mockINavBtn2,mockINavBtn1,mockINavBtn4,mockINavBtn3
    ];

    //act
    navBtnGroup.arrangeBtnIndexStack(top: CodeState.X001CODE);
    //assert
    NavBtn lastItem = navBtnGroup.navBtnList.last;
    expect(lastItem.routerType, equals(CodeState.X001CODE));

    //act
    navBtnGroup.arrangeBtnIndexStack(top: CodeState.H001CODE);
    //assert
    NavBtn lastIte2 = navBtnGroup.navBtnList.last;
    expect(lastIte2.routerType, equals(CodeState.H001CODE));
  });
}
