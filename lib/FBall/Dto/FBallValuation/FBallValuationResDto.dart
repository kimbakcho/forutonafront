
import 'package:json_annotation/json_annotation.dart';

part 'FBallValuationResDto.g.dart';

@JsonSerializable()
class FBallValuationResDto {
   int idx;
   String ballUuid;
   String uid;
   int upAndDown;

   FBallValuationResDto();

  factory FBallValuationResDto.fromJson(Map<String, dynamic> json) => _$FBallValuationResDtoFromJson(json);
   Map<String, dynamic> toJson() => _$FBallValuationResDtoToJson(this);

}