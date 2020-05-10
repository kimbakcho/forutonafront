import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthNumberReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthNumberResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwChangeFromPhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwChangeFromPhoneAuthResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthNumberReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthNumberResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PwFindPhoneAuthResDto.dart';

class PhoneAuthRepository {
  Future<PhoneAuthResDto> reqPhoneAuth(PhoneAuthReqDto reqDto) async {
    FDio dio = FDio("none");
    var response = await dio.post("/v1/PhoneAuth/Req",data: reqDto.toJson());
    return PhoneAuthResDto.fromJson(response.data);
  }

  Future<PwFindPhoneAuthResDto> reqPwFindPhoneAuth(PwFindPhoneAuthReqDto reqDto) async {
    FDio dio = FDio("none");
    var response = await dio.post("/v1/PhoneAuth/PwFindReq",data: reqDto.toJson());
    return PwFindPhoneAuthResDto.fromJson(response.data);
  }

  Future<PhoneAuthNumberResDto> reqNumberAuthReq(PhoneAuthNumberReqDto reqDto) async {
    FDio dio = FDio("none");
    var response = await dio.post("/v1/PhoneAuth/NumberAuthReq",data: reqDto.toJson());
    return PhoneAuthNumberResDto.fromJson(response.data);
  }

  Future<PwFindPhoneAuthNumberResDto> reqPwFindNumberAuth(PwFindPhoneAuthNumberReqDto reqDto) async {
    FDio dio = FDio("none");
    var response = await dio.post("/v1/PhoneAuth/PwFindNumberAuthReq",data: reqDto.toJson());
    return PwFindPhoneAuthNumberResDto.fromJson(response.data);
  }


  Future<PwChangeFromPhoneAuthResDto> reqChangePwAuthPhone(PwChangeFromPhoneAuthReqDto reqDto) async {
    FDio dio = FDio("none");
    var response = await dio.put("/v1/PhoneAuth/changePwAuthPhone",data: reqDto.toJson());
    return PwChangeFromPhoneAuthResDto.fromJson(response.data);
  }

}