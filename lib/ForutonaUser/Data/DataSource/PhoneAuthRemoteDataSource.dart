import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PhoneAuthNumber.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PwChangeFromPhoneAuth.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PwFindPhoneAuth.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PwFindPhoneAuthNumber.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthNumberReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthNumberResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwChangeFromPhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwChangeFromPhoneAuthResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthNumberReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthNumberResDto.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PhoneAuth.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthResDto.dart';

abstract class PhoneAuthRemoteSource {

  Future<PhoneAuth> reqPhoneAuth(PhoneAuthReqDto reqDto,FDio noneToken);

  Future<PwFindPhoneAuth> reqPwFindPhoneAuth(PwFindPhoneAuthReqDto reqDto,FDio noneToken);

  Future<PhoneAuthNumber> reqNumberAuthReq(PhoneAuthNumberReqDto reqDto,FDio noneToken);

  Future<PwFindPhoneAuthNumber> reqPwFindNumberAuth(PwFindPhoneAuthNumberReqDto reqDto,FDio noneToken);

  Future<PwChangeFromPhoneAuth> reqChangePwAuthPhone(PwChangeFromPhoneAuthReqDto reqDto,FDio noneToken);

}

class PhoneAuthRemoteSourceImpl implements PhoneAuthRemoteSource{
  Future<PhoneAuth> reqPhoneAuth(PhoneAuthReqDto reqDto,FDio noneToken) async {
    var response = await noneToken.post("/v1/PhoneAuth/Req",data: reqDto.toJson());
    return PhoneAuth.fromJson(response.data);
  }

  Future<PwFindPhoneAuth> reqPwFindPhoneAuth(PwFindPhoneAuthReqDto reqDto,FDio noneToken) async {
    var response = await noneToken.post("/v1/PhoneAuth/PwFindReq",data: reqDto.toJson());
    return PwFindPhoneAuth.fromJson(response.data);
  }

  Future<PhoneAuthNumber> reqNumberAuthReq(PhoneAuthNumberReqDto reqDto,FDio noneToken) async {
    var response = await noneToken.post("/v1/PhoneAuth/NumberAuthReq",data: reqDto.toJson());
    return PhoneAuthNumber.fromJson(response.data);
  }

  Future<PwFindPhoneAuthNumber> reqPwFindNumberAuth(PwFindPhoneAuthNumberReqDto reqDto,FDio noneToken) async {
    var response = await noneToken.post("/v1/PhoneAuth/PwFindNumberAuthReq",data: reqDto.toJson());
    return PwFindPhoneAuthNumber.fromJson(response.data);
  }

  Future<PwChangeFromPhoneAuth> reqChangePwAuthPhone(PwChangeFromPhoneAuthReqDto reqDto,FDio noneToken) async {
    var response = await noneToken.put("/v1/PhoneAuth/changePwAuthPhone",data: reqDto.toJson());
    return PwChangeFromPhoneAuth.fromJson(response.data);
  }
}
