
import 'package:forutonafront/Preference.dart';
import 'package:json_annotation/json_annotation.dart';
part 'FBallListUpReqDto.g.dart';

@JsonSerializable()
class FBallListUpReqDto {

  final double latitude;
  final double longitude;
  final int ballLimit;
  final int page;
  final int size;
  final String sort;

  @JsonKey(ignore: true)
  final findAddress;

  FBallListUpReqDto({this.latitude = 37.508797, this.longitude = 126.890605, this.ballLimit = 1000, this.page = 0,
      this.size = 20, this.sort = "Influence,DESC",this.findAddress = true});

  factory FBallListUpReqDto.fromJson(Map<String, dynamic> json) => _$FBallListUpReqDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FBallListUpReqDtoToJson(this);

  FBallListUpReqDto setLatLng(double lat,double lng){
    return new FBallListUpReqDto(
      latitude: lat,
      longitude: lng,
      sort: this.sort,
      size: this.size,
      page: this.page,
      ballLimit: this.ballLimit
    );
  }


}