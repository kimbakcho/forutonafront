

import 'package:json_annotation/json_annotation.dart';

part 'TagSearchFromTextReqDto.g.dart';

@JsonSerializable()
class TagSearchFromTextReqDto {
  String searchText;
  //JSON으로 MultiSorts을 toQureyJson으로 풀어서 받는다.
  String sorts;
  int size;
  int page;
  double latitude;
  double longitude;
  TagSearchFromTextReqDto(this.searchText, this.sorts, this.size, this.page,
      this.latitude, this.longitude);
  factory TagSearchFromTextReqDto.onlyText(searchText) { return TagSearchFromTextReqDto(searchText,null,0,0,0,0); }

  factory TagSearchFromTextReqDto.fromJson(Map<String, dynamic> json) => _$TagSearchFromTextReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TagSearchFromTextReqDtoToJson(this);
}