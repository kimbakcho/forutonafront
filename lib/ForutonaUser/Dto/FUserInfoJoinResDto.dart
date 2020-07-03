
import 'package:forutonafront/ForutonaUser/Data/Value/FUserInfoJoin.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FUserInfoJoinResDto.g.dart';

@JsonSerializable()

class FUserInfoJoinResDto {
  String customToken;
  bool joinComplete;

  FUserInfoJoinResDto();

  factory FUserInfoJoinResDto.fromFUserInfoJoin(FUserInfoJoin fUserInfoJoin){
    FUserInfoJoinResDto resDto = FUserInfoJoinResDto();
    resDto.customToken = fUserInfoJoin.customToken;
    resDto.joinComplete = fUserInfoJoin.joinComplete;
    return resDto;
  }


  factory FUserInfoJoinResDto.fromJson(Map<String, dynamic> json) => _$FUserInfoJoinResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FUserInfoJoinResDtoToJson(this);

}