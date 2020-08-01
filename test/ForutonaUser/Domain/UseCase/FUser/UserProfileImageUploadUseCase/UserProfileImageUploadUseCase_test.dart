import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/FlutterImageCompressAdapter/FlutterImageCompressAdapter.dart';
import 'package:forutonafront/ForutonaUser/Domain/Entity/FUserInfo.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserProfileImageUploadUseCase/UserProfileImageUploadUseCase.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserProfileImageUploadUseCase/UserProfileImageUploadUseCaseInputPort.dart';
import 'package:mockito/mockito.dart';

import '../../../../../fixtures/fixture_reader.dart';


class MockSignInUserInfoUseCaseInputPort extends Mock
    implements SignInUserInfoUseCaseInputPort {}
class MockFlutterImageCompressAdapter extends Mock
    implements FlutterImageCompressAdapter {}
class MockFUserInfo extends Mock implements FUserInfo {}

void main() {
  UserProfileImageUploadUseCaseInputPort userProfileImageUploadUseCase;
  MockSignInUserInfoUseCaseInputPort mockSignInUserInfoUseCaseInputPort = new MockSignInUserInfoUseCaseInputPort();
  MockFlutterImageCompressAdapter mockFlutterImageCompressAdapter;
  MockFUserInfo mockFUserInfo = new MockFUserInfo();
  setUp(() {
    mockFlutterImageCompressAdapter = MockFlutterImageCompressAdapter();
    userProfileImageUploadUseCase = UserProfileImageUploadUseCase(
        signInUserInfoUseCaseInputPort: mockSignInUserInfoUseCaseInputPort,
        flutterImageCompressAdapter: mockFlutterImageCompressAdapter);
  });

  test('Profile Image should be Upload fast? Server ', () async {
    //given

    File imageFile = fixtureFile("FUser/profileImage.png");
    Uint8List originImage = imageFile.readAsBytesSync();
    List<int> compressImage = [1, 2, 3];
    when(mockFlutterImageCompressAdapter.compressImage(originImage, 70))
        .thenAnswer((_) async => compressImage);
    when(mockSignInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory())
        .thenAnswer((realInvocation) => mockFUserInfo);
    //act
    await userProfileImageUploadUseCase.upload(imageFile);

    //assert
    var captured2 =
    verify(mockFUserInfo.uploadUserProfileImage(captureAny))
        .captured[0] as List<int>;

    expect(captured2, compressImage);
  });
}
