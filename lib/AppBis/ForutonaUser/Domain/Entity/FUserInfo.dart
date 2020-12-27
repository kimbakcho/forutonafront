
import 'package:forutonafront/AppBis/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/Preference.dart';

import 'package:json_annotation/json_annotation.dart';

part 'FUserInfo.g.dart';

@JsonSerializable()
class FUserInfo {
   String uid;
   String nickName;
   String _profilePictureUrl;
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

   FUserInfo();

   get profilePictureUrl {

      if(_profilePictureUrl == null || _profilePictureUrl.length == 0){
         return Preference.basicProfileImageUrl;
      }else {
         return _profilePictureUrl;
      }
   }

   set profilePictureUrl(String value) {
      _profilePictureUrl = value;
   }
   
   factory FUserInfo.fromJson(Map<String, dynamic> json) => _$FUserInfoFromJson(json);

   Map<String, dynamic> toJson() => _$FUserInfoToJson(this);

}