
import 'package:json_annotation/json_annotation.dart';

part 'FUserInfoSimple1.g.dart';

@JsonSerializable()
class FUserInfoSimple1 {
   String nickName;
   double cumulativeInfluence;
   int followCount;
   String profilePictureUrl;
   FUserInfoSimple1();
   factory FUserInfoSimple1.fromJson(Map<String, dynamic> json) => _$FUserInfoSimple1FromJson(json);
   Map<String, dynamic> toJson() => _$FUserInfoSimple1ToJson(this);

}