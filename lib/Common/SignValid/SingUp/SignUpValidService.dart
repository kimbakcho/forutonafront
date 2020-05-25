abstract class SignUpValidService {
  Future<void> emailIdValid(String email);
  bool hasEmailError();
  String emailErrorText();
  void pwValid(String pw);
  bool hasPwError();
  String pwErrorText();
  void pwCheckValid(String pw,String pwCheck);
  bool hasPwCheckError();
  String pwCheckErrorText();
  Future<void> nickNameValid(String nickName);
  bool hasNickNameError();
  String nickNameErrorText();
  Future<void> currentPwValid(String pw);
  bool hasCurrentPwError();
  String currentPwErrorText();
}