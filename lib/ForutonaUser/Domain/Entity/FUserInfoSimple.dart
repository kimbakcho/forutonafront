import 'package:forutonafront/ForutonaUser/Dto/FUserInfoSimpleResDto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FUserInfoSimple.g.dart';

@JsonSerializable()
class FUserInfoSimple {
  String uid;
  String nickName;
  String profilePictureUrl;
  String isoCode;
  double userLevel;
  String selfIntroduction;
  double cumulativeInfluence;
  int followCount;

  FUserInfoSimple();

  factory FUserInfoSimple.fromJson(Map<String, dynamic> json) =>
      _$FUserInfoSimpleFromJson(json);

  Map<String, dynamic> toJson() => _$FUserInfoSimpleToJson(this);

}
