
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/FireBaseMessage/UseCase/FireBaseTokenUpdateUseCase/FireBaseMessageTokenUpdateUseCase.dart';
import 'package:forutonafront/FireBaseMessage/UseCase/FireBaseTokenUpdateUseCase/FireBaseMessageTokenUpdateUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';

import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:mockito/mockito.dart';


class MockFUserFireBaseRepository extends Mock implements FUserRepository{}
void main(){
  FireBaseMessageTokenUpdateUseCaseInputPort fireBaseTokenUpdateUseCaseInputPort;
  MockFUserFireBaseRepository fUserRepository;
  setUp((){
    fUserRepository = MockFUserFireBaseRepository() ;
    fireBaseTokenUpdateUseCaseInputPort = FireBaseMessageTokenUpdateUseCase(fUserRepository: fUserRepository);
  });

  test('should be call repository ', () async {
    //arrange
    when(fUserRepository.updateFireBaseMessageToken(any, any)).thenAnswer((_)async => 1);
    //act
    await fireBaseTokenUpdateUseCaseInputPort.updateFireBaseMessageToken("test", "testToken");
    //assert
    verify(fUserRepository.updateFireBaseMessageToken(any, any));
  });
}