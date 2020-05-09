import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthNumberReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthNumberResDto.dart';

class PhoneAuthRepository {
  Future<PhoneAuthResDto> reqPhoneAuth(PhoneAuthReqDto reqDto) async {
    FDio dio = FDio("none");
    var response = await dio.post("/v1/PhoneAuth/Req",data: reqDto.toJson());
    return PhoneAuthResDto.fromJson(response.data);
  }

  Future<PhoneAuthNumberResDto> reqNumberAuthReq(PhoneAuthNumberReqDto reqDto) async {
    FDio dio = FDio("none");
    var response = await dio.post("/v1/PhoneAuth/NumberAuthReq",data: reqDto.toJson());
    return PhoneAuthNumberResDto.fromJson(response.data);
  }
}