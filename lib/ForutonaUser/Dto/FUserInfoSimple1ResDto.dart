

import 'package:forutonafront/ForutonaUser/Data/Entity/FUserInfoSimple1.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FUserInfoSimple1ResDto.g.dart';

@JsonSerializable()
class FUserInfoSimple1ResDto {
  String nickName;
  double cumulativeInfluence;
  int followCount;
  String profilePictureUrl;
  FUserInfoSimple1ResDto();
  factory FUserInfoSimple1ResDto.fromJson(Map<String, dynamic> json) => _$FUserInfoSimple1ResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FUserInfoSimple1ResDtoToJson(this);

  factory FUserInfoSimple1ResDto.fromFUserInfoSimple1(FUserInfoSimple1 item){
    FUserInfoSimple1ResDto fUserInfoSimple1ResDto = FUserInfoSimple1ResDto();
    fUserInfoSimple1ResDto.nickName = item.nickName;
    fUserInfoSimple1ResDto.cumulativeInfluence = item.cumulativeInfluence;
    fUserInfoSimple1ResDto.followCount = item.followCount;
    fUserInfoSimple1ResDto.profilePictureUrl = item.profilePictureUrl;

    return fUserInfoSimple1ResDto;
  }
}