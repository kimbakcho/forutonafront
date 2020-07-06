
import 'package:forutonafront/ForutonaUser/Data/Value/UserPolicy.dart';
import 'package:json_annotation/json_annotation.dart';

part 'UserPolicyResDto.g.dart';

@JsonSerializable()
class UserPolicyResDto {
  String policyName;
  String policyContent;
  String lang;
  DateTime writeDateTime;


  UserPolicyResDto();

  factory UserPolicyResDto.fromUserPolicy(UserPolicy item){
    UserPolicyResDto resDto = UserPolicyResDto();
    resDto.policyName = item.policyName;
    resDto.policyContent = item.policyContent;
    resDto.lang = item.lang;
    resDto.writeDateTime = item.writeDateTime;
    return resDto;
  }
  factory UserPolicyResDto.fromJson(Map<String, dynamic> json) => _$UserPolicyResDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserPolicyResDtoToJson(this);
}