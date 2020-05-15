import 'package:forutonafront/Common/SmsReceiverUtil/SmsAuthReceiverMessageParser.dart';
import 'package:forutonafront/Common/SmsReceiverUtil/SmsAuthSupportLanguage.dart';
import 'package:sms_receiver/sms_receiver.dart';

class SmsAuthReceiverService {
  SmsReceiver _smsReceiver;
  SmsAuthSupportLanguage _smsAuthSupportLanguage;
  final Function(String) onReceiverMessage;

  SmsAuthReceiverService(this.onReceiverMessage,this._smsAuthSupportLanguage){
    _smsReceiver =new SmsReceiver(_onLocalReceiverMessage);

  }
  startListening(){
    _smsReceiver.startListening();
  }

  _onLocalReceiverMessage(String message){
    SmsAuthReceiverMessageParser authReceiverMessageParser = SmsAuthReceiverMessageParser.lang(_smsAuthSupportLanguage);
    this.onReceiverMessage(authReceiverMessageParser.parse(message));
  }
}