import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Data/DataSource/PhoneAuthRemoteDataSource.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/Repository/PhoneAuthRepository.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PhoneAuthNumberReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PhoneAuthNumberResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PhoneAuthReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PhoneAuthResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PwChangeFromPhoneAuthReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PwChangeFromPhoneAuthResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PwFindPhoneAuthNumberReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PwFindPhoneAuthNumberResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PwFindPhoneAuthReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PwFindPhoneAuthResDto.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PhoneAuthRepository)
class PhoneAuthRepositoryImpl implements PhoneAuthRepository {
  PhoneAuthRemoteSource _phoneAuthRemoteSource;

  PhoneAuthRepositoryImpl(
      {required PhoneAuthRemoteSource phoneAuthRemoteSource})
      : _phoneAuthRemoteSource = phoneAuthRemoteSource;

  @override
  Future<PwChangeFromPhoneAuthResDto> reqChangePwAuthPhone(
      PwChangeFromPhoneAuthReqDto reqDto) async {
    return await _phoneAuthRemoteSource.reqChangePwAuthPhone(reqDto, FDio.noneToken())  ;
  }

  @override
  Future<PhoneAuthNumberResDto> reqNumberAuthReq(PhoneAuthNumberReqDto reqDto) async {
    return await _phoneAuthRemoteSource.reqNumberAuthReq(reqDto, FDio.noneToken())  ;
  }

  @override
  Future<PhoneAuthResDto> reqPhoneAuth(PhoneAuthReqDto reqDto) async {
    return await _phoneAuthRemoteSource.reqPhoneAuth(reqDto,FDio.noneToken());
  }

  @override
  Future<PwFindPhoneAuthNumberResDto> reqPwFindNumberAuth(
      PwFindPhoneAuthNumberReqDto reqDto) async {
    return await _phoneAuthRemoteSource.reqPwFindNumberAuth(reqDto,FDio.noneToken());
  }

  @override
  Future<PwFindPhoneAuthResDto> reqPwFindPhoneAuth(
      PwFindPhoneAuthReqDto reqDto) async {
    return await _phoneAuthRemoteSource.reqPwFindPhoneAuth(reqDto,FDio.noneToken());
  }
}
