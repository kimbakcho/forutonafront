import 'package:flutter/services.dart';

class FireBaseValidErrorUtil {

  String getErrorText(PlatformException e) {
    if (e.code == "ERROR_INVALID_EMAIL") {
      return "*이메일 형식이 맞지 않습니다.";
    }else if(e.code == "ERROR_WRONG_PASSWORD"){
      return "패스워드가 틀렸습니다.";
    } else if(e.code == "ERROR_USER_NOT_FOUND"){
      return "유저를 찾을수가 없습니다.";
    } else if (e.code == "error") {
      if (e.message == "Given String is empty or null") {
        return "*이메일 형식이 맞지 않습니다.";
      }else if (e.message == "The email address is badly formatted.") {
        return "아이디가 이메일 형식이 아닙니다";
      } else if (e.message ==
          "There is no user record corresponding to this identifier. The user may have been deleted.") {
        return "아이디가 없거나 패스워드가 틀렸습니다.";
      } else if (e.message ==
          "The password is invalid or the user does not have a password.") {
        return "아이디가 없거나 패스워드가 틀렸습니다.";
      } else if (e.message.indexOf("A network error") >= 0) {
        return "네트워크 접속에 실패했습니다. 네트워크 연결 상태를 확인해주세요.";
      } else {
        return e.message;
      }
  } else {
    return e.message;
    }
  }
}
