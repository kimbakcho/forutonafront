import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/PhoneAuthResDto.dart';

class PhoneAuthRepository {
  Future<PhoneAuthResDto> reqPhoneAuth(PhoneAuthReqDto reqDto) async {
    FDio dio = FDio("none");
    var response = await dio.post("/v1/PhoneAuth/Req",data: reqDto.toJson());
    return PhoneAuthResDto.fromJson(response.data);
  }
}