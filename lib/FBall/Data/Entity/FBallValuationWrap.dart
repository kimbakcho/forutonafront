
import 'package:json_annotation/json_annotation.dart';

import 'FBallValuation.dart';

part 'FBallValuationWrap.g.dart';

@JsonSerializable()
class FBallValuationWrap {
  int count;
  List<FBallValuation>  contents = [];
  FBallValuationWrap();

  factory FBallValuationWrap.fromJson(Map<String, dynamic> json) =>
      _$FBallValuationWrapFromJson(json);

  Map<String, dynamic> toJson() => _$FBallValuationWrapToJson(this);

  hasFBallValuation(){
    if(count == 0){
      return false;
    }else {
      return true;
    }
  }
  getFBallValuation(){
    if(contents.length > 0){
      return contents[0];
    }else {
      return null;
    }
  }
}