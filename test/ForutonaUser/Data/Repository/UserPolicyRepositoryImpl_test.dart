import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/ForutonaUser/Data/DataSource/UserPolicyRemoteDataSource.dart';
import 'package:forutonafront/ForutonaUser/Data/Repository/UserPolicyRepositoryImpl.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/UserPolicyRepository.dart';
import 'package:forutonafront/ForutonaUser/Dto/UserPolicyResDto.dart';
import 'package:forutonafront/Preference.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

class MockUserPolicyRemoteDataSource extends Mock
    implements UserPolicyRemoteDataSource {}

void main() {
  UserPolicyRepository userPolicyRepository;
  MockUserPolicyRemoteDataSource mockUserPolicyRemoteDataSource;
  final sl = GetIt.instance;
  sl.registerSingleton<Preference>(Preference());

  setUp(() {
    mockUserPolicyRemoteDataSource = MockUserPolicyRemoteDataSource();
    userPolicyRepository = UserPolicyRepositoryImpl(
        userPolicyRemoteDataSource: mockUserPolicyRemoteDataSource);
  });

  test('should be DataSource Call', () async {
    //arrange
    String policy = "testPolicy";
    UserPolicyResDto userPolicyResDto = UserPolicyResDto(
        policy, "test", "test", DateTime.now());
    when(mockUserPolicyRemoteDataSource.getPersonaSettingNotice(policy, any))
        .thenAnswer((realInvocation) async => userPolicyResDto);
    //act
    await userPolicyRepository.getPersonaSettingNotice(policy);
    //assert
    verify(mockUserPolicyRemoteDataSource.getPersonaSettingNotice(policy, any));
  });
}
