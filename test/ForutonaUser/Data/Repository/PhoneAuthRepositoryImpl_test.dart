import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/ForutonaUser/Data/DataSource/PhoneAuthRemoteDataSource.dart';
import 'package:forutonafront/ForutonaUser/Data/Repository/PhoneAuthRepositoryImpl.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PhoneAuth.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PhoneAuthNumber.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PwChangeFromPhoneAuth.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PwFindPhoneAuth.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PwFindPhoneAuthNumber.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/PhoneAuthRepository.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthNumberReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwChangeFromPhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthNumberReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthReqDto.dart';
import 'package:forutonafront/Preference.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

class MockPhoneAuthRemoteSource extends Mock implements PhoneAuthRemoteSource {}

void main() {
  PhoneAuthRepository phoneAuthRepository;
  MockPhoneAuthRemoteSource mockPhoneAuthRemoteSource;
  final sl = GetIt.instance;
  sl.registerSingleton<Preference>(Preference());

  setUp(() {
    mockPhoneAuthRemoteSource = MockPhoneAuthRemoteSource();
    phoneAuthRepository = PhoneAuthRepositoryImpl(
        phoneAuthRemoteSource: mockPhoneAuthRemoteSource);

  });

  test('should reqChangePwAuthPhone RemoteSource Call', () async {
    //arrange
    when(mockPhoneAuthRemoteSource.reqChangePwAuthPhone(any,any))
        .thenAnswer((_) async => PwChangeFromPhoneAuth());
    PwChangeFromPhoneAuthReqDto reqDto = PwChangeFromPhoneAuthReqDto();
    //act
    await phoneAuthRepository.reqChangePwAuthPhone(reqDto);
    //assert
    verify(mockPhoneAuthRemoteSource.reqChangePwAuthPhone(any,any));
  });

  test('should reqNumberAuthReq RemoteSource Call', () async {
    //arrange
    when(mockPhoneAuthRemoteSource.reqNumberAuthReq(any,any))
        .thenAnswer((_) async => PhoneAuthNumber());
    PhoneAuthNumberReqDto reqDto = PhoneAuthNumberReqDto();
    //act
    await phoneAuthRepository.reqNumberAuthReq(reqDto);
    //assert
    verify(mockPhoneAuthRemoteSource.reqNumberAuthReq(any,any));
  });

  test('should reqPhoneAuth RemoteSource Call', () async {
    //arrange
    when(mockPhoneAuthRemoteSource.reqPhoneAuth(any,any))
        .thenAnswer((_) async => PhoneAuth());
    PhoneAuthReqDto reqDto = PhoneAuthReqDto();
    //act
    await phoneAuthRepository.reqPhoneAuth(reqDto);
    //assert
    verify(mockPhoneAuthRemoteSource.reqPhoneAuth(any,any));
  });

  test('should reqPwFindNumberAuth RemoteSource Call', () async {
    //arrange
    when(mockPhoneAuthRemoteSource.reqPwFindNumberAuth(any,any))
        .thenAnswer((_) async => PwFindPhoneAuthNumber());
    PwFindPhoneAuthNumberReqDto reqDto = PwFindPhoneAuthNumberReqDto();
    //act
    await phoneAuthRepository.reqPwFindNumberAuth(reqDto);
    //assert
    verify(mockPhoneAuthRemoteSource.reqPwFindNumberAuth(any,any));
  });

  test('should reqPwFindPhoneAuth RemoteSource Call', () async {
    //arrange
    when(mockPhoneAuthRemoteSource.reqPwFindPhoneAuth(any,any))
        .thenAnswer((_) async => PwFindPhoneAuth());
    PwFindPhoneAuthReqDto reqDto = PwFindPhoneAuthReqDto();
    //act
    await phoneAuthRepository.reqPwFindPhoneAuth(reqDto);
    //assert
    verify(mockPhoneAuthRemoteSource.reqPwFindPhoneAuth(any,any));
  });
}
