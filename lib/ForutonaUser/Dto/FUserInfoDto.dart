
import 'package:json_annotation/json_annotation.dart';

part 'FUserInfoDto.g.dart';

@JsonSerializable()
class FUserInfoDto {

   String uid;
   String nickName;
   String profilePicktureUrl;
   int gender;
   DateTime ageDate;
   String email;
   bool forutonaAgree;
   bool privateAgree;
   bool positionAgree;
   bool martketingAgree;
   bool ageLimitAgree;
   String snsService;
   String phoneNumber;
   String isoCode;
   double latitude;
   double longitude;
   DateTime positionUpdateTime;
   double userLevel;
   double expPoint;
   String fCMtoken;
   DateTime joinTime;
   int followCount;
   int backOut;
   DateTime lastBackOutTime;


   FUserInfoDto(
      this.uid,
      this.nickName,
      this.profilePicktureUrl,
      this.gender,
      this.ageDate,
      this.email,
      this.forutonaAgree,
      this.privateAgree,
      this.positionAgree,
      this.martketingAgree,
      this.ageLimitAgree,
      this.snsService,
      this.phoneNumber,
      this.isoCode,
      this.latitude,
      this.longitude,
      this.positionUpdateTime,
      this.userLevel,
      this.expPoint,
      this.fCMtoken,
      this.joinTime,
      this.followCount,
      this.backOut,
      this.lastBackOutTime);

  factory FUserInfoDto.fromJson(Map<String, dynamic> json) => _$FUserInfoDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FUserInfoDtoToJson(this);


}