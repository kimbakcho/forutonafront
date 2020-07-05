import 'package:forutonafront/Common/SignValid/IdDuplicationUseCase/DuplicationErrorLogin.dart';

class DontHaveIdError implements DuplicationErrorLogin{
  @override
  bool valid(int idCount) {
    return idCount == 0 ? false:true;
  }

  @override
  String errorMessage = "가입한 아이디가 없습니다.";
}