

import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoResDto.dart';

class FUserRepository {

  Future<FUserInfoResDto> getForutonaGetMe() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    var idToken = await firebaseUser.getIdToken();
    FDio dio = FDio(idToken.token);
    var response = await dio.get("/v1/ForutonaUser/Me",
        queryParameters: FUserReqDto(firebaseUser.uid).toJson());

    return FUserInfoResDto.fromJson(response.data);
  }
}
