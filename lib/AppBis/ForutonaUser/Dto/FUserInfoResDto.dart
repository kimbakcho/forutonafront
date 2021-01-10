
import 'package:forutonafront/AppBis/ForutonaUser/Domain/Entity/FUserInfo.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/Components/GenderSelectComponent/GenderType.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FUserInfoResDto.g.dart';

@JsonSerializable()
class FUserInfoResDto {
   String uid;
   String nickName;
   String profilePictureUrl;
   String backGroundImageUrl;
   GenderType gender;
   DateTime ageDate;
   String email;
   bool forutonaAgree;
   bool privateAgree;
   bool positionAgree;
   bool martketingAgree;
   bool ageLimitAgree;
   SnsSupportService snsService;
   String phoneNumber;
   String isoCode;
   double latitude;
   double longitude;
   DateTime positionUpdateTime;
   double userLevel;
   double expPoint;
   String fCMtoken;
   DateTime joinTime;
   int followerCount;
   int followingCount;
   int backOut;
   DateTime lastBackOutTime;
   String selfIntroduction;
   double cumulativeInfluence;
   double uPoint;
   double naPoint;
   int historyOpenAll;
   int historyOpenFollowSponsor;
   int historyOpenNoOpen;
   int sponsorHistoryOpenAll;
   int sponsorHistoryOpenSponAndFollowFromMe;
   int sponsorHistoryOpenSponNoOpen;
   bool alarmChatMessage;
   bool alarmContentReply;
   bool alarmReplyAndReply;
   bool alarmFollowNewContent;
   bool alarmSponNewContent;
   int deactivation;
   int maliciousCount;
   DateTime stopPeriod;
   bool maliciousMessageCheck;
   String maliciousCause;

   FUserInfoResDto();

  factory FUserInfoResDto.fromJson(Map<String, dynamic> json) => _$FUserInfoResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FUserInfoResDtoToJson(this);



}