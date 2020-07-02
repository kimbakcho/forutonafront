import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/ForutonaUser/Data/DataSource/UserPolicyRemoteDataSource.dart';
import 'package:forutonafront/ForutonaUser/Dto/UserPolicyResDto.dart';
import 'package:mockito/mockito.dart';

class MockFDio extends Mock implements FDio {}

void main(){
  UserPolicyRemoteDataSource userPolicyRemoteDataSource;
  FDio fDio;
  setUp((){
    userPolicyRemoteDataSource = UserPolicyRemoteDataSourceImpl();
    fDio = MockFDio();
  });

  test('should API Call REST ', () async {
    String policy = "testPolicy";
    UserPolicyResDto resDto = UserPolicyResDto("testPolicy","testcontent","ko",DateTime.now());
    //arrange
    when(fDio.get("/v1/ForutonaUser/UserPolicy/"+policy))
        .thenAnswer((_) async => Response<dynamic>(data: resDto.toJson()));
    //act
    await userPolicyRemoteDataSource.getPersonaSettingNotice(policy, fDio);
    //assert
    verify(fDio.get("/v1/ForutonaUser/UserPolicy/"+policy));
  });
}