import 'package:forutonafront/Common/SmsReceiverUtil/SmsAuthReceiverMessageParserKoKr.dart';
import 'package:forutonafront/Common/SmsReceiverUtil/SmsAuthSupportLanguage.dart';

class SmsAuthReceiverMessageParser {
  String parse(String message){ return ""; }

  factory SmsAuthReceiverMessageParser.lang(SmsAuthSupportLanguage lang){
    if(lang == SmsAuthSupportLanguage.KoKr){
      return SmsAuthReceiverMessageParserKoKr();
    }else {
      return null;
    }
  }
}