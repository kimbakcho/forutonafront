import 'package:forutonafront/Common/SmsReceiverUtil/SmsAuthReceiverMessageParser.dart';

class SmsAuthReceiverMessageParserKoKr implements SmsAuthReceiverMessageParser{
  @override
  String parse(String message) {
    var indexOf = message.indexOf("인증번호:",0);
    var indexOf2 = message.indexOf("]",indexOf);
    var substring = message.substring(indexOf+5,indexOf2);
    return substring;
  }

}