import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/INavBtn.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/NavBtn.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnGroup/INavBtnGroup.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnGroup/TopNavBtnGroup.dart';
import 'package:mockito/mockito.dart';

void main(){
  INavBtnGroup navBtnGroup;
  setUp((){
    navBtnGroup = NavBtnGroup();
  });
  test('top 버튼의 이름을 가진 Btn 스택 제일 뒤에 옮기기', () async {
    //arrange

    NavBtn mockINavBtn2 = new NavBtn();
    mockINavBtn2.originIndex = 2;
    mockINavBtn2.btnName = "2";
    navBtnGroup.registerBtn(mockINavBtn2);

    NavBtn mockINavBtn1 = new NavBtn();
    mockINavBtn1.originIndex = 1;
    mockINavBtn1.btnName = "1";
    navBtnGroup.registerBtn(mockINavBtn1);

    NavBtn mockINavBtn4 = new NavBtn();
    mockINavBtn4.originIndex = 4;
    mockINavBtn4.btnName = "4";
    navBtnGroup.registerBtn(mockINavBtn4);

    NavBtn mockINavBtn3 = new NavBtn();
    mockINavBtn3.originIndex = 3;
    mockINavBtn3.btnName = "3";
    navBtnGroup.registerBtn(mockINavBtn3);

    String topItemName = "3";
    //act
    navBtnGroup.arrangeBtnIndexStack(top: topItemName);
    //assert
    NavBtn lastItem = navBtnGroup.navBtnList.last;
    expect(lastItem.btnName, equals(topItemName));

    String topItemNam2 = "1";
    //act
    navBtnGroup.arrangeBtnIndexStack(top: topItemNam2);
    //assert
    NavBtn lastIte2 = navBtnGroup.navBtnList.last;
    expect(lastIte2.btnName, equals(topItemNam2));
  });
}