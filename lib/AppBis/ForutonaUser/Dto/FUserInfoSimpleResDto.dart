import 'package:forutonafront/AppBis/ForutonaUser/Domain/Entity/FUserInfoSimple.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FUserInfoSimpleResDto.g.dart';

@JsonSerializable()
class FUserInfoSimpleResDto {
  String? uid;
  String? nickName;
  String? profilePictureUrl;
  String? backGroundImageUrl;
  String? isoCode;
  double? userLevel;
  String? selfIntroduction;
  double? cumulativeInfluence;
  int? followerCount;
  int? followingCount;
  double? playerPower;

  FUserInfoSimpleResDto();

  static FUserInfoSimpleResDto fromJson(Map<String, dynamic> json) =>
      _$FUserInfoSimpleResDtoFromJson(json);

  static fromFUserInfoSimple(FUserInfoSimple fUserInfoSimple){
    FUserInfoSimpleResDto fUserInfoSimpleResDto = new FUserInfoSimpleResDto();
    fUserInfoSimpleResDto.uid = fUserInfoSimple.uid;
    fUserInfoSimpleResDto.nickName = fUserInfoSimple.nickName;
    fUserInfoSimpleResDto.profilePictureUrl = fUserInfoSimple.profilePictureUrl;
    fUserInfoSimpleResDto.backGroundImageUrl = fUserInfoSimple.backGroundImageUrl;
    fUserInfoSimpleResDto.isoCode = fUserInfoSimple.isoCode;
    fUserInfoSimpleResDto.userLevel = fUserInfoSimple.userLevel;
    fUserInfoSimpleResDto.selfIntroduction = fUserInfoSimple.selfIntroduction;
    fUserInfoSimpleResDto.cumulativeInfluence = fUserInfoSimple.cumulativeInfluence;
    fUserInfoSimpleResDto.followerCount = fUserInfoSimple.followerCount;
    fUserInfoSimpleResDto.followingCount = fUserInfoSimple.followingCount;
    fUserInfoSimpleResDto.playerPower = fUserInfoSimple.playerPower;
    return fUserInfoSimpleResDto;
  }

  static fromFUserInfoResDto(FUserInfoResDto fUserInfoResDto){
    FUserInfoSimpleResDto fUserInfoSimpleResDto = new FUserInfoSimpleResDto();
    fUserInfoSimpleResDto.uid = fUserInfoResDto.uid;
    fUserInfoSimpleResDto.nickName = fUserInfoResDto.nickName;
    fUserInfoSimpleResDto.profilePictureUrl = fUserInfoResDto.profilePictureUrl;
    fUserInfoSimpleResDto.backGroundImageUrl = fUserInfoResDto.backGroundImageUrl;
    fUserInfoSimpleResDto.isoCode = fUserInfoResDto.isoCode;
    fUserInfoSimpleResDto.userLevel = fUserInfoResDto.userLevel;
    fUserInfoSimpleResDto.selfIntroduction = fUserInfoResDto.selfIntroduction;
    fUserInfoSimpleResDto.cumulativeInfluence = fUserInfoResDto.cumulativeInfluence;
    fUserInfoSimpleResDto.followerCount = fUserInfoResDto.followerCount;
    fUserInfoSimpleResDto.followingCount = fUserInfoResDto.followingCount;
    fUserInfoSimpleResDto.playerPower = fUserInfoResDto.playerPower;
    return fUserInfoSimpleResDto;
  }

  Map<String, dynamic> toJson() => _$FUserInfoSimpleResDtoToJson(this);
}
