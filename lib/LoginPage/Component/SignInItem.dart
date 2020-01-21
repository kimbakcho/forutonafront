enum Signtype { Email, SNS }
enum SNSType { Facebook, Kakao, Naver }

class Signitem {
  bool forutonaAgree = false;
  bool privateaAgree = false;
  bool positionaAgree = false;
  bool marketingAgree = false;
  String emailID = "";
  String passWord = "";
  Signtype signtype = Signtype.Email;
  SNSType snstype = SNSType.Facebook;
}
