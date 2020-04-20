

import 'package:json_annotation/json_annotation.dart';

part 'TagSearchFromTextReqDto.g.dart';


 ///검색된 Tag을 사용하여 Ball을 찾을때 사용
@JsonSerializable()
class TagSearchFromTextReqDto {
  String searchText;
  //JSON으로 MultiSorts을 toQureyJson으로 풀어서 받는다.
  String sorts;
  int size;
  int page;
  //거리순 정렬이 있기에 좌표 넘겨줌
  double latitude;
  double longitude;
  TagSearchFromTextReqDto(this.searchText, this.sorts, this.size, this.page,
      this.latitude, this.longitude);
  factory TagSearchFromTextReqDto.onlyText(searchText) { return TagSearchFromTextReqDto(searchText,null,0,0,0,0); }

  factory TagSearchFromTextReqDto.fromJson(Map<String, dynamic> json) => _$TagSearchFromTextReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TagSearchFromTextReqDtoToJson(this);
}