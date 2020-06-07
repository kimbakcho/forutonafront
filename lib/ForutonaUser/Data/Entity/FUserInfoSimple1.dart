
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoSimple1ResDto.dart';
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
   factory FUserInfoSimple1.fromFUserInfoSimple1ResDto(FUserInfoSimple1ResDto simple1resDto){
      FUserInfoSimple1 fUserInfoSimple1 = FUserInfoSimple1();
      fUserInfoSimple1.nickName = simple1resDto.nickName;
      fUserInfoSimple1.cumulativeInfluence = simple1resDto.cumulativeInfluence;
      fUserInfoSimple1.followCount = simple1resDto.followCount;
      fUserInfoSimple1.profilePictureUrl = simple1resDto.profilePictureUrl;
      return fUserInfoSimple1;
   }
   plusCumulativeInfluence(int point){
      this.cumulativeInfluence += point;
   }
   minusCumulativeInfluence(int point){
      this.cumulativeInfluence -= point;
   }

}