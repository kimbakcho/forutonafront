import 'package:json_annotation/json_annotation.dart';

import 'FBall.dart';

part 'FBallListUpWrap.g.dart';

@JsonSerializable()
class FBallListUpWrap {
  DateTime searchTime;
  List<FBall> balls;
  //Ball의 전체 카운터 검색어 에서만 사용
  int searchBallTotalCount = 0;

  FBallListUpWrap({this.searchTime, this.balls});


  factory FBallListUpWrap.fromJson(Map<String, dynamic> json) =>
      _$FBallListUpWrapFromJson(json);

  Map<String, dynamic> toJson() => _$FBallListUpWrapToJson(this);
}