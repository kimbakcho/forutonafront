import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/FireBaseAdapter/FireBaseAdapter.dart';
import 'package:forutonafront/ForutonaUser/Data/DataSource/FUserRemoteDataSource.dart';
import 'package:forutonafront/ForutonaUser/Data/Entity/FUserInfoSimple1.dart';
import 'package:forutonafront/ForutonaUser/Data/Repository/FUserRepositoryImpl.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserReqDto.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/mockito.dart';

class MockUserRemoteDataSource extends Mock implements FUserRemoteDataSource {}
class MockFireBaseAdapter extends Mock implements FireBaseAdapter{}
void main() {
  FUserRepository fUserRepository;
  MockUserRemoteDataSource mockUserRemoteDataSource;
  MockFireBaseAdapter mockFireBaseAdapter;

  setUp(() {
    mockUserRemoteDataSource = MockUserRemoteDataSource();
    mockFireBaseAdapter = MockFireBaseAdapter();
    fUserRepository =
        FUserRepositoryImpl(fUserRemoteDataSource: mockUserRemoteDataSource,
        fireBaseAdapter: mockFireBaseAdapter);
    when(mockFireBaseAdapter.getFireBaseIdToken()).thenAnswer((realInvocation) async=> "token");
  });

  test('updateUserPosition', () async {
    //arrange
    when(mockUserRemoteDataSource.updateUserPosition(LatLng(121.0,37.0),any))
        .thenAnswer((_) async => 1);
    //act
    int result =
        await fUserRepository.updateUserPosition(LatLng(121.0, 37.0));
    //assert
    expect(result, 1);
  });

  test('getUserInfoSimple1', () async {
    //arrange
    var resResult = FUserInfoSimple1();
    resResult.nickName = "test";
    resResult.profilePictureUrl = "test";
    when(mockUserRemoteDataSource.getUserInfoSimple1(any,any))
        .thenAnswer((_)async => resResult);
    //act
    FUserInfoSimple1 result = await fUserRepository.getUserInfoSimple1(FUserReqDto("testUid"));
    //assert
    verify(mockUserRemoteDataSource.getUserInfoSimple1(any,any));
    expect(result.nickName, "test");
  });
}
