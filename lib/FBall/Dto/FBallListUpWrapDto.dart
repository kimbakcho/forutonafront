import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FBallListUpWrapDto.g.dart';

@JsonSerializable()
class FBallListUpWrapDto {
  DateTime searchTime;
  List<FBallResDto> balls;
  //Ball의 전체 카운터 검색어 에서만 사용
  int searchBallCount = 0;

  FBallListUpWrapDto(this.searchTime, this.balls);

  factory FBallListUpWrapDto.fromJson(Map<String, dynamic> json) =>
      _$FBallListUpWrapDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FBallListUpWrapDtoToJson(this);
}
