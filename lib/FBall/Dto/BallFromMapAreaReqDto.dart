
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'BallFromMapAreaReqDto.g.dart';

/// 지도에서 사각형 으로 각끝에 좌표를 받은 다음 BackEnd 로 메세지 넘기는 부분 구조
@JsonSerializable()
class BallFromMapAreaReqDto {
  double southwestLat;
  double southwestLng;
  double northeastLat;
  double northeastLng;
  double centerPointLat;
  double centerPointLng;
  int page;
  int size;
  //MultiSorts 타입의 Json String을 입력
  String sorts;


  BallFromMapAreaReqDto(
      this.southwestLat,
      this.southwestLng,
      this.northeastLat,
      this.northeastLng,
      this.centerPointLat,
      this.centerPointLng,
      this.page,
      this.size,
      this.sorts);

  factory BallFromMapAreaReqDto.fromJson(Map<String, dynamic> json) => _$BallFromMapAreaReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$BallFromMapAreaReqDtoToJson(this);
}