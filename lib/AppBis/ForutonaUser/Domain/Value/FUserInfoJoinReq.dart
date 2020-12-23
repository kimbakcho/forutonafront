import 'package:forutonafront/AppBis/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/Preference.dart';
import 'package:injectable/injectable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FUserInfoJoinReq.g.dart';


@JsonSerializable()
@lazySingleton
class FUserInfoJoinReq {
  bool forutonaAgree;
  bool forutonaManagementAgree;
  bool privateAgree;
  bool positionAgree;
  bool martketingAgree;
  bool ageLimitAgree;
  String nickName;
  String email;
  String _userProfileImageUrl;
  SnsSupportService snsSupportService;
  String countryCode;
  String snsToken;
  String userIntroduce;
  String internationalizedPhoneNumber;
  DateTime ageDate;

  //해당 토큰으로 최종 가입 절차에서 인증 받은 폰인지 체크한다.
  String phoneAuthToken;
  String password;
  String emailUserUid;

  // @JsonKey(ignore: true)
  // Preference _preference;


  FUserInfoJoinReq();

  clearPassword(){
    this.password = "";
  }

  get userProfileImageUrl {
    if (_userProfileImageUrl == null) {
      return Preference.basicProfileImageUrl;
    }else {
      return _userProfileImageUrl;
    }
  }
  set userProfileImageUrl(String url) {
    _userProfileImageUrl = url;
  }

  factory FUserInfoJoinReq.fromJson(Map<String, dynamic> json) =>
      _$FUserInfoJoinReqFromJson(json);

  Map<String, dynamic> toJson() => _$FUserInfoJoinReqToJson(this);
}