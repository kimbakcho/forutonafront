import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/INavBtn.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/NavBtn.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/NavBtnSetDto.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnGroup/INavBtnGroup.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnGroup/TopNavBtnGroup.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnGroup/TopNavBtnGroupViewModel.dart';
import 'package:forutonafront/Components/TopNav/TopNavRouterType.dart';
import 'package:mockito/mockito.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart' as di;

void main(){
  INavBtnGroup navBtnGroup;
  setUp((){
    di.init();
    navBtnGroup = TopNavBtnGroupViewModel();
  });

  test('top 버튼의 이름을 가진 Btn 스택 제일 뒤에 옮기기', () async {
    //arrange
    navBtnGroup.navBtnList = [];

    NavBtn mockINavBtn2 = new NavBtn(navBtnSetDto:  NavBtnSetDto(routerType: TopNavRouterType.H003), originIndex: 2);
    navBtnGroup.registerBtn(mockINavBtn2);

    NavBtn mockINavBtn1 = new NavBtn(navBtnSetDto:  NavBtnSetDto(routerType: TopNavRouterType.H001),originIndex: 1);
    navBtnGroup.registerBtn(mockINavBtn1);

    NavBtn mockINavBtn4 = new NavBtn(navBtnSetDto:  NavBtnSetDto(routerType: TopNavRouterType.ZZ001),originIndex: 4);
    navBtnGroup.registerBtn(mockINavBtn4);

    NavBtn mockINavBtn3 = new NavBtn(navBtnSetDto:  NavBtnSetDto(routerType: TopNavRouterType.Z001),originIndex: 3);
    navBtnGroup.registerBtn(mockINavBtn3);

    //act
    navBtnGroup.arrangeBtnIndexStack(top: TopNavRouterType.Z001);
    //assert
    NavBtn lastItem = navBtnGroup.navBtnList.last;
    expect(lastItem.routerType, equals(TopNavRouterType.Z001));

    //act
    navBtnGroup.arrangeBtnIndexStack(top: TopNavRouterType.H001);
    //assert
    NavBtn lastIte2 = navBtnGroup.navBtnList.last;
    expect(lastIte2.routerType, equals(TopNavRouterType.H001));
  });
}