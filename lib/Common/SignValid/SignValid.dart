

abstract class SignValid {
  bool? hasValidTry;
  Future<void>  valid(String validText);
  bool hasError();
  String errorText();
}