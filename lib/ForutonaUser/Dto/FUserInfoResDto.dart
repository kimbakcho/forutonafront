
import 'package:json_annotation/json_annotation.dart';

part 'FUserInfoResDto.g.dart';

@JsonSerializable()
class FUserInfoResDto {

   String uid;
   String nickName;
   String profilePicktureUrl;
   int gender;
   DateTime ageDate;
   String email;
   int forutonaAgree;
   int privateAgree;
   int positionAgree;
   int martketingAgree;
   int ageLimitAgree;
   String snsService;
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


   FUserInfoResDto(
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
      this.intitude,
      this.positionUpdateTime,
      this.userLevel,
      this.expPoint,
      this.fCMtoken,
      this.joinTime,
      this.followCount,
      this.backOut,
      this.lastBackOutTime,
      this.selfIntroduction,
      this.cumulativeInfluence,
      this.uPoint,
      this.naPoint,
      this.historyOpenAll,
      this.historyOpenFollowSponsor,
      this.historyOpenNoOpen,
      this.sponsorHistoryOpenAll,
      this.sponsorHistoryOpenSponAndFollowFromMe,
      this.sponsorHistoryOpenSponNoOpen,
      this.alarmChatMessage,
      this.alarmContentReply,
      this.alarmReplyAndReply,
      this.alarmFollowNewContent,
      this.alarmSponNewContent,
      this.deactivation);

  factory FUserInfoResDto.fromJson(Map<String, dynamic> json) => _$FUserInfoResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FUserInfoResDtoToJson(this);


}