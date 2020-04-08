import 'package:json_annotation/json_annotation.dart';

part 'BallNameSearchReqDto.g.dart';

@JsonSerializable()
class BallNameSearchReqDto {
  String searchText;
  //JSON으로 MultiSorts을 toQureyJson으로 풀어서 받는다.
  String sorts;
  int size;
  int page;
  double latitude;
  double longitude;


  BallNameSearchReqDto(this.searchText, this.sorts, this.size, this.page,
      this.latitude, this.longitude);

  factory BallNameSearchReqDto.fromJson(Map<String, dynamic> json) => _$BallNameSearchReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$BallNameSearchReqDtoToJson(this);
}