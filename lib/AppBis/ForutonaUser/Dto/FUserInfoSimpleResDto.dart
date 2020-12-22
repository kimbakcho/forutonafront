import 'package:forutonafront/AppBis/ForutonaUser/Domain/Entity/FUserInfoSimple.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FUserInfoSimpleResDto.g.dart';

@JsonSerializable()
class FUserInfoSimpleResDto {
  String uid;
  String nickName;
  String profilePictureUrl;
  String isoCode;
  double userLevel;
  String selfIntroduction;
  double cumulativeInfluence;
  int followCount;
  double playerPower;

  FUserInfoSimpleResDto();

  static FUserInfoSimpleResDto fromJson(Map<String, dynamic> json) =>
      _$FUserInfoSimpleResDtoFromJson(json);

  static fromFUserInfoSimple(FUserInfoSimple fUserInfoSimple){
    FUserInfoSimpleResDto fUserInfoSimpleResDto = new FUserInfoSimpleResDto();
    fUserInfoSimpleResDto.uid = fUserInfoSimple.uid;
    fUserInfoSimpleResDto.nickName = fUserInfoSimple.nickName;
    fUserInfoSimpleResDto.profilePictureUrl = fUserInfoSimple.profilePictureUrl;
    fUserInfoSimpleResDto.isoCode = fUserInfoSimple.isoCode;
    fUserInfoSimpleResDto.userLevel = fUserInfoSimple.userLevel;
    fUserInfoSimpleResDto.selfIntroduction = fUserInfoSimple.selfIntroduction;
    fUserInfoSimpleResDto.cumulativeInfluence = fUserInfoSimple.cumulativeInfluence;
    fUserInfoSimpleResDto.followCount = fUserInfoSimple.followCount;
    fUserInfoSimpleResDto.playerPower = fUserInfoSimple.playerPower;
    return fUserInfoSimpleResDto;
  }

  Map<String, dynamic> toJson() => _$FUserInfoSimpleResDtoToJson(this);
}
