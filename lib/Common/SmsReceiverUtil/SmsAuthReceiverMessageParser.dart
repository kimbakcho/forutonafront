import 'package:forutonafront/Common/SmsReceiverUtil/SmsAuthReceiverMessageParserKoKr.dart';
import 'package:forutonafront/Common/SmsReceiverUtil/SmsAuthSupportLanguage.dart';

abstract class SmsAuthReceiverMessageParser {
  String parse(String message);

  factory SmsAuthReceiverMessageParser.lang(SmsAuthSupportLanguage lang){
    if(lang == SmsAuthSupportLanguage.KoKr){
      return SmsAuthReceiverMessageParserKoKr();
    }else {
      return SmsAuthReceiverMessageParserKoKr();
    }
  }
}