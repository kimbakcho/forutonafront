import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/NavBtn.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/NavBtnSetDto.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnGroup/INavBtnGroup.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnGroup/TopNavBtnGroupViewModel.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnMediator.dart';
import 'package:forutonafront/Components/TopNav/TopNavRouterType.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart' as di;

void main(){
  INavBtnGroup navBtnGroup;
  TopNavBtnMediator topNavBtnMediator;
  setUp((){
    topNavBtnMediator = TopNavBtnMediatorImpl();
    navBtnGroup = TopNavBtnGroupViewModel(topNavBtnMediator: topNavBtnMediator);
  });

  test('top 버튼의 이름을 가진 Btn 스택 제일 뒤에 옮기기', () async {
    //arrange
    navBtnGroup.navBtnList = [];

    NavBtn mockINavBtn2 = new NavBtn(navBtnSetDto:  NavBtnSetDto(routerType: TopNavRouterType.H003), originIndex: 2);
    navBtnGroup.registerBtn(mockINavBtn2);

    NavBtn mockINavBtn1 = new NavBtn(navBtnSetDto:  NavBtnSetDto(routerType: TopNavRouterType.H_I_001),originIndex: 1);
    navBtnGroup.registerBtn(mockINavBtn1);

    NavBtn mockINavBtn4 = new NavBtn(navBtnSetDto:  NavBtnSetDto(routerType: TopNavRouterType.X002),originIndex: 4);
    navBtnGroup.registerBtn(mockINavBtn4);

    NavBtn mockINavBtn3 = new NavBtn(navBtnSetDto:  NavBtnSetDto(routerType: TopNavRouterType.X001),originIndex: 3);
    navBtnGroup.registerBtn(mockINavBtn3);

    //act
    navBtnGroup.arrangeBtnIndexStack(top: TopNavRouterType.X001);
    //assert
    NavBtn lastItem = navBtnGroup.navBtnList.last;
    expect(lastItem.routerType, equals(TopNavRouterType.X001));

    //act
    navBtnGroup.arrangeBtnIndexStack(top: TopNavRouterType.H_I_001);
    //assert
    NavBtn lastIte2 = navBtnGroup.navBtnList.last;
    expect(lastIte2.routerType, equals(TopNavRouterType.H_I_001));
  });
}