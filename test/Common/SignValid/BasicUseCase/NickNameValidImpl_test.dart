import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/SignValid/BasicUseCase/NickNameValidImpl.dart';

import 'package:forutonafront/Common/SignValid/SignValid.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:mockito/mockito.dart';

class MockFUserRepository extends Mock implements FUserRepository{}
void main () {
  MockFUserRepository mockFUserRepository;
  SignValid nickNameValid;
  setUp((){
    mockFUserRepository = MockFUserRepository();
    nickNameValid = NickNameValidImpl(fUserRepository: mockFUserRepository);
  });

  test('nickNameValid', () async {
    when(mockFUserRepository.checkNickNameDuplication("text"))
        .thenAnswer((realInvocation) async => false);
    when(mockFUserRepository.checkNickNameDuplication("test"))
        .thenAnswer((realInvocation) async => true);

    await nickNameValid.valid("t");

    expect(nickNameValid.hasError(), true);
    expect(nickNameValid.errorText(),
        "닉네임은 최소 2글자 이상이어야 합니다.");

    await nickNameValid.valid("text");

    expect(nickNameValid.hasError(), false);

    await nickNameValid.valid("test");
    expect(nickNameValid.hasError(), true);
    expect(nickNameValid.errorText(), "이미 있는 닉네임입니다.");
  });
}