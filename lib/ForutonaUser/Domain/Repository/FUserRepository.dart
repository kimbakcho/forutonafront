import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/ForutonaUser/Data/Entity/FUserInfoSimple1.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserReqDto.dart';

abstract class FUserRepository {
  Future<FUserInfoSimple1> getUserInfoSimple1({@required FUserReqDto reqDto });
}