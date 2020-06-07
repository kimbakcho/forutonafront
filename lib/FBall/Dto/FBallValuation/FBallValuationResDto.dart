
import 'package:forutonafront/FBall/Data/Entity/FBallValuation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'FBallValuationInsertReqDto.dart';

part 'FBallValuationResDto.g.dart';

@JsonSerializable()
class FBallValuationResDto {
   String valueUuid;
   String ballUuid;
   String uid;
   int upAndDown;

   FBallValuationResDto();

  factory FBallValuationResDto.fromJson(Map<String, dynamic> json) => _$FBallValuationResDtoFromJson(json);
   Map<String, dynamic> toJson() => _$FBallValuationResDtoToJson(this);

   factory FBallValuationResDto.fromFBallValuation(FBallValuation item){
     FBallValuationResDto fBallValuationResDto  = new FBallValuationResDto();
     fBallValuationResDto.valueUuid = item.valueUuid;
     fBallValuationResDto.ballUuid = item.ballUuid;
     fBallValuationResDto.uid = item.uid;
     fBallValuationResDto.upAndDown = item.upAndDown;
     return fBallValuationResDto;
   }
   factory FBallValuationResDto.fromFBallValuationInsertReqDto(FBallValuationInsertReqDto item){
     FBallValuationResDto fBallValuationResDto  = new FBallValuationResDto();
     fBallValuationResDto.valueUuid = item.valueUuid;
     fBallValuationResDto.ballUuid = item.ballUuid;
     fBallValuationResDto.uid = item.uid;
     fBallValuationResDto.upAndDown = item.upAndDown;
     return fBallValuationResDto;
   }

}