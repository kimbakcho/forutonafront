abstract class SnsLoginModuleAdapter {
  Future<SnsLoginModuleResDto> getSnsModuleUserInfo();
}

class SnsLoginModuleResDto {
  String uid;
  String accessToken;
  SnsLoginModuleResDto(this.uid, this.accessToken);
}
