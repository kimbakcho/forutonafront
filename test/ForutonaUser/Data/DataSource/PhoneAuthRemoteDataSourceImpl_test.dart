import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/ForutonaUser/Data/DataSource/PhoneAuthRemoteDataSource.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PhoneAuthNumber.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PwChangeFromPhoneAuth.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PwFindPhoneAuth.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthNumberReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthNumberResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwChangeFromPhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwChangeFromPhoneAuthResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthResDto.dart';
import 'package:mockito/mockito.dart';

class MockFDio extends Mock implements FDio {}

void main(){

  PhoneAuthRemoteSource phoneAuthRemoteSource;
  FDio fDio;
  setUp((){
    phoneAuthRemoteSource = PhoneAuthRemoteSourceImpl();
    fDio = MockFDio();
  });

  test('should reqPhoneAuth API Call', () async {
    //arrange
    var resResult = PhoneAuthResDto();
    resResult.makeTime = DateTime.now();
    resResult.isoCode = "KR";
    resResult.internationalizedPhoneNumber = "+8201045458888";
    resResult.phoneNumber = "+8201055554444";
    resResult.authRetryAvailableTime = DateTime.now().add(Duration(hours: 2));
    resResult.authTime = DateTime.now();

    when(fDio.post("/v1/PhoneAuth/Req",
        data: anyNamed('data')))
        .thenAnswer((_) async => Response<dynamic>(data: resResult.toJson()));

    PhoneAuthReqDto reqDto = PhoneAuthReqDto();
    reqDto.isoCode = "Kr";
    reqDto.phoneNumber = "+8201055554444";
    reqDto.internationalizedPhoneNumber = "+8201045458888";
    //act
    await phoneAuthRemoteSource.reqPhoneAuth(
        reqDto, fDio);
    //assert
    verify(fDio.post("/v1/PhoneAuth/Req",data: reqDto.toJson()));
  });

  test('should reqPwFindPhoneAuth API Call', () async {
    //arrange
    var resResult = PwFindPhoneAuthResDto();
    resResult.makeTime = DateTime.now();
    resResult.isoCode = "KR";
    resResult.internationalizedPhoneNumber = "+8201045458888";
    resResult.phoneNumber = "+8201055554444";
    resResult.authRetryAvailableTime = DateTime.now().add(Duration(hours: 2));
    resResult.authTime = DateTime.now();
    resResult.error = false;
    resResult.cause = "TEST";

    when(fDio.post("/v1/PhoneAuth/PwFindReq",
        data: anyNamed('data')))
        .thenAnswer((_) async => Response<dynamic>(data: resResult.toJson()));

    PwFindPhoneAuthReqDto reqDto = PwFindPhoneAuthReqDto();
    reqDto.isoCode = "Kr";
    reqDto.phoneNumber = "+8201055554444";
    reqDto.internationalizedPhoneNumber = "+8201045458888";
    reqDto.email="test@google.com";
    reqDto.emailPhoneAuthToken = "TESTTESTTSET";
    //act
    await phoneAuthRemoteSource.reqPwFindPhoneAuth(
        reqDto, fDio);
    //assert
    verify(fDio.post("/v1/PhoneAuth/PwFindReq",data: reqDto.toJson()));
  });

  test('should reqNumberAuthReq API Call', () async {
    //arrange
    var resResult = PhoneAuthNumberResDto();
    resResult.errorFlag = false;
    resResult.errorCause = "TEST";
    resResult.phoneAuthToken = "TESTTEST";
    resResult.internationalizedPhoneNumber = "+8201045458888";
    resResult.phoneNumber = "+8201055554444";


    when(fDio.post("/v1/PhoneAuth/NumberAuthReq",
        data: anyNamed('data')))
        .thenAnswer((_) async => Response<dynamic>(data: resResult.toJson()));

    PhoneAuthNumberReqDto reqDto = PhoneAuthNumberReqDto();
    reqDto.isoCode = "Kr";
    reqDto.phoneNumber = "+8201055554444";
    reqDto.internationalizedPhoneNumber = "+8201045458888";
    reqDto.authNumber = "123456";

    //act
    await phoneAuthRemoteSource.reqNumberAuthReq(
        reqDto, fDio);
    //assert
    verify(fDio.post("/v1/PhoneAuth/NumberAuthReq",data: reqDto.toJson()));
  });

  test('should reqChangePwAuthPhone API Call', () async {
    //arrange
    var resResult = PwChangeFromPhoneAuthResDto();
    resResult.errorFlag = false;
    resResult.email="TEST@dfdf.com";
    resResult.cause = "TEST";
    resResult.internationalizedPhoneNumber = "+8201045458888";

    when(fDio.put("/v1/PhoneAuth/changePwAuthPhone",
        data: anyNamed('data')))
        .thenAnswer((_) async => Response<dynamic>(data: resResult.toJson()));

    PwChangeFromPhoneAuthReqDto reqDto = PwChangeFromPhoneAuthReqDto();
    reqDto.email="TEST@google.com";
    reqDto.emailPhoneAuthToken = "TESTTEST";
    reqDto.password = "Aa123123";
    reqDto.internationalizedPhoneNumber= "+8201045458888";

    //act
    await phoneAuthRemoteSource.reqChangePwAuthPhone(
        reqDto, fDio);
    //assert
    verify(fDio.put("/v1/PhoneAuth/changePwAuthPhone",data: reqDto.toJson()));
  });
}