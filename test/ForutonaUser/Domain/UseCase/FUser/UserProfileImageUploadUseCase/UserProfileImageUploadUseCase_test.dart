import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/FlutterImageCompressAdapter/FlutterImageCompressAdapter.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserProfileImageUploadUseCase/UserProfileImageUploadUseCase.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserProfileImageUploadUseCase/UserProfileImageUploadUseCaseInputPort.dart';
import 'package:mockito/mockito.dart';

import '../../../../../fixtures/fixture_reader.dart';

class MockFUserRepository extends Mock implements FUserRepository {}

class MockFlutterImageCompressAdapter extends Mock
    implements FlutterImageCompressAdapter {}

void main() {
  UserProfileImageUploadUseCaseInputPort userProfileImageUploadUseCase;
  MockFUserRepository mockFUserRepository = new MockFUserRepository();
  MockFlutterImageCompressAdapter mockFlutterImageCompressAdapter;
  setUp(() {
    mockFlutterImageCompressAdapter = MockFlutterImageCompressAdapter();
    userProfileImageUploadUseCase = UserProfileImageUploadUseCase(
        fUserRepository: mockFUserRepository,
        flutterImageCompressAdapter: mockFlutterImageCompressAdapter);
  });

  test('Profile Image should be Upload fast? Server ', () async {
    //given

    File imageFile = fixtureFile("FUser/profileImage.png");
    Uint8List originImage = imageFile.readAsBytesSync();
    List<int> compressImage = [1, 2, 3];
    when(mockFlutterImageCompressAdapter.compressImage(originImage, 70))
        .thenAnswer((_) async => compressImage);

    //act
    await userProfileImageUploadUseCase.upload(imageFile);

    //assert
    var captured2 =
        verify(mockFUserRepository.uploadUserProfileImage(captureAny))
            .captured[0] as FormData;

    expect(captured2.files[0].value.filename, "ProfileImage.jpg");
    List<List<int>> formDataFile =
        await captured2.files[0].value.finalize().toList();

    List<int> profileImageByte = formDataFile[0];
    expect(profileImageByte, compressImage);
  });
}
