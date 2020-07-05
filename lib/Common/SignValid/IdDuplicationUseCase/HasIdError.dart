import 'package:forutonafront/Common/SignValid/IdDuplicationUseCase/DuplicationErrorLogin.dart';

class HasIdError implements DuplicationErrorLogin{
  @override
  bool valid(int idCount) {
    return idCount > 0 ? false:true;
  }

  @override
  String errorMessage = "이미 가입한 ID가 있습니다/";
}