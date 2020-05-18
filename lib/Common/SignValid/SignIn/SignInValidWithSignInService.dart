abstract class SignInValidWithSignInService {
  Future<void> signInValidWithSignIn(String email,String pw);
  bool hasSignInError();
  String signInErrorText();
}