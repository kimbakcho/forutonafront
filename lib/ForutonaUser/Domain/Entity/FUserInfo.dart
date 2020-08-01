
import 'package:forutonafront/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserAccountUpdateReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/Preference.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

   @JsonKey(ignore: true)
   FUserRepository _fUserRepository = sl();

   FUserInfo();


   get profilePictureUrl {
      Preference preference = sl();
      if(_profilePictureUrl == null || _profilePictureUrl.length == 0){
         return preference.basicProfileImageUrl;
      }else {
         return _profilePictureUrl;
      }
   }

   set profilePictureUrl(String value) {
      _profilePictureUrl = value;
   }
   
   factory FUserInfo.fromJson(Map<String, dynamic> json) => _$FUserInfoFromJson(json);

   Map<String, dynamic> toJson() => _$FUserInfoToJson(this);

   Future<FUserInfoResDto> updateAccountUserInfo(FUserAccountUpdateReqDto reqDto) async {
      FUserInfoResDto fUserInfoResDto = await _fUserRepository.updateAccountUserInfo(reqDto);
      this.isoCode = fUserInfoResDto.isoCode;
      this.nickName = fUserInfoResDto.nickName;
      this.selfIntroduction = fUserInfoResDto.selfIntroduction;
      this.profilePictureUrl = fUserInfoResDto.profilePictureUrl;
      return fUserInfoResDto;
   }

   Future<void> pwChange(String pw) async {
      return await _fUserRepository.pWChange(pw);
   }

   Future<String> uploadUserProfileImage(List<int> imageByte) async {
      String imageUrl = await _fUserRepository.uploadUserProfileImage(imageByte);
      this.profilePictureUrl = imageUrl;
      return this.profilePictureUrl;
   }

   Future<void> updateUserPosition(LatLng latLng)async{
      return await _fUserRepository.updateUserPosition(latLng);
   }

  Future<void> updateFCMToken(String token) async {
     await _fUserRepository.updateFireBaseMessageToken(token);
  }

  static FUserInfo fromFUserInfoResDto(FUserInfoResDto resDto) {
     FUserInfo fUserInfo = new FUserInfo();
     fUserInfo.uid = resDto.uid;
     fUserInfo.nickName = resDto.nickName;
     fUserInfo.profilePictureUrl = resDto.profilePictureUrl;
     fUserInfo.gender = resDto.gender;
     fUserInfo.ageDate = resDto.ageDate;
     fUserInfo.email = resDto.email;
     fUserInfo.forutonaAgree = resDto.forutonaAgree;
     fUserInfo.privateAgree = resDto.privateAgree;
     fUserInfo.positionAgree = resDto.positionAgree;
     fUserInfo.martketingAgree = resDto.martketingAgree;
     fUserInfo.ageLimitAgree = resDto.ageLimitAgree;
     fUserInfo.snsService = resDto.snsService;
     fUserInfo.phoneNumber = resDto.phoneNumber;
     fUserInfo.isoCode = resDto.isoCode;
     fUserInfo.latitude = resDto.latitude;
     fUserInfo.longitude = resDto.longitude;
     fUserInfo.positionUpdateTime = resDto.positionUpdateTime;
     fUserInfo.userLevel = resDto.userLevel;
     fUserInfo.expPoint = resDto.expPoint;
     fUserInfo.fCMtoken = resDto.fCMtoken;
     fUserInfo.joinTime = resDto.joinTime;
     fUserInfo.followCount = resDto.followCount;
     fUserInfo.backOut = resDto.backOut;
     fUserInfo.lastBackOutTime = resDto.lastBackOutTime;
     fUserInfo.selfIntroduction = resDto.selfIntroduction;
     fUserInfo.cumulativeInfluence = resDto.cumulativeInfluence;
     fUserInfo.uPoint = resDto.uPoint;
     fUserInfo.naPoint= resDto.naPoint;
     fUserInfo.historyOpenAll = resDto.historyOpenAll;
     fUserInfo.historyOpenFollowSponsor = resDto.historyOpenFollowSponsor;
     fUserInfo.historyOpenNoOpen = resDto.historyOpenNoOpen;
     fUserInfo.sponsorHistoryOpenAll = resDto.sponsorHistoryOpenAll;
     fUserInfo.sponsorHistoryOpenSponAndFollowFromMe = resDto.sponsorHistoryOpenSponAndFollowFromMe;
     fUserInfo.sponsorHistoryOpenSponNoOpen = resDto.sponsorHistoryOpenSponNoOpen;
     fUserInfo.alarmChatMessage = resDto.alarmChatMessage;
     fUserInfo.alarmContentReply = resDto.alarmChatMessage;
     fUserInfo.alarmReplyAndReply = resDto.alarmReplyAndReply;
     fUserInfo.alarmFollowNewContent = resDto.alarmFollowNewContent;
     fUserInfo.alarmSponNewContent = resDto.alarmSponNewContent;
     fUserInfo.deactivation = resDto.deactivation;
     return fUserInfo;
  }


}