import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';

abstract class SnsLoginModuleAdapter {
  Future<SnsLoginModuleResDto> getSnsModuleUserInfo();
  SnsSupportService snsSupportService;
}

class SnsLoginModuleResDto {
  String uid;
  String accessToken;
  SnsLoginModuleResDto(this.uid, this.accessToken);
}
