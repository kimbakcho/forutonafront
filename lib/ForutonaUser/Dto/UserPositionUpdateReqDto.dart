import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'UserPositionUpdateReqDto.g.dart';

@JsonSerializable()
class UserPositionUpdateReqDto {
  double lat;
  double lng;

  UserPositionUpdateReqDto({@required this.lat,@required this.lng}):assert(lat!=null),assert(lng!=null);
  factory UserPositionUpdateReqDto.fromJson(Map<String, dynamic> json) => _$UserPositionUpdateReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserPositionUpdateReqDtoToJson(this);
}