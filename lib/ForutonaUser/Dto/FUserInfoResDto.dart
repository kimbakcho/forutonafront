
import 'package:forutonafront/ForutonaUser/Domain/Entity/FUserInfo.dart';
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
   double longitude;
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

  static FUserInfoResDto fromFUserInfo(FUserInfo fUserInfo) {
     FUserInfoResDto fUserInfoResDto = new FUserInfoResDto();
     fUserInfoResDto.uid = fUserInfo.uid;
     fUserInfoResDto.nickName = fUserInfo.nickName;
     fUserInfoResDto.profilePictureUrl = fUserInfo.profilePictureUrl;
     fUserInfoResDto.gender = fUserInfo.gender;
     fUserInfoResDto.ageDate = fUserInfo.ageDate;
     fUserInfoResDto.email = fUserInfo.email;
     fUserInfoResDto.forutonaAgree = fUserInfo.forutonaAgree;
     fUserInfoResDto.privateAgree = fUserInfo.privateAgree;
     fUserInfoResDto.positionAgree = fUserInfo.positionAgree;
     fUserInfoResDto.martketingAgree = fUserInfo.martketingAgree;
     fUserInfoResDto.ageLimitAgree = fUserInfo.ageLimitAgree;
     fUserInfoResDto.snsService = fUserInfo.snsService;
     fUserInfoResDto.phoneNumber = fUserInfo.phoneNumber;
     fUserInfoResDto.isoCode = fUserInfo.isoCode;
     fUserInfoResDto.latitude = fUserInfo.latitude;
     fUserInfoResDto.longitude = fUserInfo.longitude;
     fUserInfoResDto.positionUpdateTime = fUserInfo.positionUpdateTime;
     fUserInfoResDto.userLevel = fUserInfo.userLevel;
     fUserInfoResDto.expPoint = fUserInfo.expPoint;
     fUserInfoResDto.fCMtoken = fUserInfo.fCMtoken;
     fUserInfoResDto.joinTime = fUserInfo.joinTime;
     fUserInfoResDto.followCount = fUserInfo.followCount;
     fUserInfoResDto.backOut = fUserInfo.backOut;
     fUserInfoResDto.lastBackOutTime = fUserInfo.lastBackOutTime;
     fUserInfoResDto.selfIntroduction = fUserInfo.selfIntroduction;
     fUserInfoResDto.cumulativeInfluence = fUserInfo.cumulativeInfluence;
     fUserInfoResDto.uPoint = fUserInfo.uPoint;
     fUserInfoResDto.naPoint= fUserInfo.naPoint;
     fUserInfoResDto.historyOpenAll = fUserInfo.historyOpenAll;
     fUserInfoResDto.historyOpenFollowSponsor = fUserInfo.historyOpenFollowSponsor;
     fUserInfoResDto.historyOpenNoOpen = fUserInfo.historyOpenNoOpen;
     fUserInfoResDto.sponsorHistoryOpenAll = fUserInfo.sponsorHistoryOpenAll;
     fUserInfoResDto.sponsorHistoryOpenSponAndFollowFromMe = fUserInfo.sponsorHistoryOpenSponAndFollowFromMe;
     fUserInfoResDto.sponsorHistoryOpenSponNoOpen = fUserInfo.sponsorHistoryOpenSponNoOpen;
     fUserInfoResDto.alarmChatMessage = fUserInfo.alarmChatMessage;
     fUserInfoResDto.alarmContentReply = fUserInfo.alarmChatMessage;
     fUserInfoResDto.alarmReplyAndReply = fUserInfo.alarmReplyAndReply;
     fUserInfoResDto.alarmFollowNewContent = fUserInfo.alarmFollowNewContent;
     fUserInfoResDto.alarmSponNewContent = fUserInfo.alarmSponNewContent;
     fUserInfoResDto.deactivation = fUserInfo.deactivation;
     return fUserInfoResDto;
  }


}