import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthNumberReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthNumberResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwChangeFromPhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwChangeFromPhoneAuthResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthNumberReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthNumberResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthResDto.dart';
import 'package:injectable/injectable.dart';


abstract class PhoneAuthRemoteSource {

  Future<PhoneAuthResDto> reqPhoneAuth(PhoneAuthReqDto reqDto,FDio noneToken);

  Future<PwFindPhoneAuthResDto> reqPwFindPhoneAuth(PwFindPhoneAuthReqDto reqDto,FDio noneToken);

  Future<PhoneAuthNumberResDto> reqNumberAuthReq(PhoneAuthNumberReqDto reqDto,FDio noneToken);

  Future<PwFindPhoneAuthNumberResDto> reqPwFindNumberAuth(PwFindPhoneAuthNumberReqDto reqDto,FDio noneToken);

  Future<PwChangeFromPhoneAuthResDto> reqChangePwAuthPhone(PwChangeFromPhoneAuthReqDto reqDto,FDio noneToken);

}
@Injectable(as: PhoneAuthRemoteSource)
class PhoneAuthRemoteSourceImpl implements PhoneAuthRemoteSource{

  Future<PhoneAuthResDto> reqPhoneAuth(PhoneAuthReqDto reqDto,FDio noneToken) async {
    var response = await noneToken.post("/v1/PhoneAuth/Req",data: reqDto.toJson());
    return PhoneAuthResDto.fromJson(response.data);
  }

  Future<PwFindPhoneAuthResDto> reqPwFindPhoneAuth(PwFindPhoneAuthReqDto reqDto,FDio noneToken) async {
    var response = await noneToken.post("/v1/PhoneAuth/PwFindReq",data: reqDto.toJson());
    return PwFindPhoneAuthResDto.fromJson(response.data);
  }

  Future<PhoneAuthNumberResDto> reqNumberAuthReq(PhoneAuthNumberReqDto reqDto,FDio noneToken) async {
    var response = await noneToken.post("/v1/PhoneAuth/NumberAuthReq",data: reqDto.toJson());
    return PhoneAuthNumberResDto.fromJson(response.data);
  }

  Future<PwFindPhoneAuthNumberResDto> reqPwFindNumberAuth(PwFindPhoneAuthNumberReqDto reqDto,FDio noneToken) async {
    var response = await noneToken.post("/v1/PhoneAuth/PwFindNumberAuthReq",data: reqDto.toJson());
    return PwFindPhoneAuthNumberResDto.fromJson(response.data);
  }

  Future<PwChangeFromPhoneAuthResDto> reqChangePwAuthPhone(PwChangeFromPhoneAuthReqDto reqDto,FDio noneToken) async {
    var response = await noneToken.put("/v1/PhoneAuth/changePwAuthPhone",data: reqDto.toJson());
    return PwChangeFromPhoneAuthResDto.fromJson(response.data);
  }
}
