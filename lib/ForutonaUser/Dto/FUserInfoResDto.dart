
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FUserInfoResDto.g.dart';

@JsonSerializable()
class FUserInfoResDto {

   String uid;
   String nickName;
   String profilePictureUrl;
   int gender;
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
   double intitude;
   DateTime positionUpdateTime;
   double userLevel;
   double expPoint;
   String fCMtoken;
   DateTime joinTime;
   int followCount;
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
   int alarmChatMessage;
   int alarmContentReply;
   int alarmReplyAndReply;
   int alarmFollowNewContent;
   int alarmSponNewContent;
   int deactivation;


   FUserInfoResDto();

  factory FUserInfoResDto.fromJson(Map<String, dynamic> json) => _$FUserInfoResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FUserInfoResDtoToJson(this);


}