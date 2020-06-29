

import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Background/Presentation/MainBackGround.dart';
import 'package:forutonafront/FireBaseMessage/Presentation/FireBaseMessageController.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/GlobalModel.dart';
import 'package:forutonafront/MainModel.dart';
import 'package:mockito/mockito.dart';

class MockGlobalModel extends Mock implements GlobalModel{}
class MockFireBaseMessageController extends Mock implements FireBaseMessageController{}
class MockFireBaseAuthAdapterForUseCase extends Mock implements FireBaseAuthAdapterForUseCase{}
class MockMainBackGround extends Mock implements MainBackGround{}

void main(){

  MockFireBaseMessageController mockFireBaseMessageController = MockFireBaseMessageController();
  MockFireBaseAuthAdapterForUseCase mockFireBaseAuthAdapterForUseCase = MockFireBaseAuthAdapterForUseCase();
  MockMainBackGround mockMainBackGround = MockMainBackGround();
  MainModel mainModel;


  test('앱 시작에 필요한 서비스 호출 검증 ', () async {
    //arrange

    //act
    mainModel = MainModel(
      fireBaseMessageController: mockFireBaseMessageController,
      fireBaseAuthAdapterForUseCase: mockFireBaseAuthAdapterForUseCase,
      mainBackGround: mockMainBackGround,
    );
    //assert
    verify(mockMainBackGround.startBackGroundService());
    verify(mockFireBaseMessageController.controllerStartService());
    verify(mockFireBaseAuthAdapterForUseCase.startOnAuthStateChangedListen());
  });
}