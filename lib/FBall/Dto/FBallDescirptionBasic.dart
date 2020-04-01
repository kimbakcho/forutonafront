
import 'package:forutonafront/FBall/Dto/FBallDesImagesDto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'FBallDescirptionBasic.g.dart';

@JsonSerializable()
class FBallDescirptionBasic {

  String text;
  List<FBallDesImagesDto> desimages;

  FBallDescirptionBasic();
  factory FBallDescirptionBasic.fromJson(Map<String, dynamic> json) => _$FBallDescirptionBasicFromJson(json);
  Map<String, dynamic> toJson() => _$FBallDescirptionBasicToJson(this);


}