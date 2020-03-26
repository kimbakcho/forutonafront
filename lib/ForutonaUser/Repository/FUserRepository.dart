import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/Auth/UserInfoMain.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoDto.dart';

class FUserRepository {
  Future<FUserInfoDto> getForutonaUserBasic() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    var idToken = await firebaseUser.getIdToken();
    FDio dio = FDio(idToken.token);
    var response = await dio.get("/v1/ForutonaUser/Basic/",
        queryParameters: FUserReqDto(firebaseUser.uid).toJson());

    return FUserInfoDto.fromJson(response.data);
  }
}
