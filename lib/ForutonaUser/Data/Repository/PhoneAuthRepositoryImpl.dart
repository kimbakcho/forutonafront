import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/ForutonaUser/Data/DataSource/PhoneAuthRemoteDataSource.dart';
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

class PhoneAuthRepositoryImpl implements PhoneAuthRepository {
  PhoneAuthRemoteSource _phoneAuthRemoteSource;

  PhoneAuthRepositoryImpl(
      {@required PhoneAuthRemoteSource phoneAuthRemoteSource})
      : _phoneAuthRemoteSource = phoneAuthRemoteSource;

  @override
  Future<PwChangeFromPhoneAuth> reqChangePwAuthPhone(
      PwChangeFromPhoneAuthReqDto reqDto) async {
    return await _phoneAuthRemoteSource.reqChangePwAuthPhone(reqDto, FDio.noneToken())  ;
  }

  @override
  Future<PhoneAuthNumber> reqNumberAuthReq(PhoneAuthNumberReqDto reqDto) async {
    return await _phoneAuthRemoteSource.reqNumberAuthReq(reqDto, FDio.noneToken())  ;
  }

  @override
  Future<PhoneAuth> reqPhoneAuth(PhoneAuthReqDto reqDto) async {
    return await _phoneAuthRemoteSource.reqPhoneAuth(reqDto,FDio.noneToken());
  }

  @override
  Future<PwFindPhoneAuthNumber> reqPwFindNumberAuth(
      PwFindPhoneAuthNumberReqDto reqDto) async {
    return await _phoneAuthRemoteSource.reqPwFindNumberAuth(reqDto,FDio.noneToken());
  }

  @override
  Future<PwFindPhoneAuth> reqPwFindPhoneAuth(
      PwFindPhoneAuthReqDto reqDto) async {
    return await _phoneAuthRemoteSource.reqPwFindPhoneAuth(reqDto,FDio.noneToken());
  }
}
