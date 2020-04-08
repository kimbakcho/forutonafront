
import 'package:intl/intl.dart';

class TimeDisplayUtil {
  /*
  현재 시간을 기준으로 남는 시간을 수치 표현 방식으로 변환 해줌
   */
  static String getRemainingToStrFromNow(DateTime destTime){
    DateTime now = DateTime.now();
    var difference = now.difference(destTime);
    if(!difference.isNegative){
      if(difference.inSeconds.abs() < 10){
        return "Just now";
      }else if(difference.inSeconds.abs() < 60){
        return difference.inSeconds.abs().toString()+"sec ago";
      }else if(difference.inMinutes.abs() < 60 ){
        return difference.inMinutes.abs().toString()+"min ago";
      }else if(difference.inHours.abs() < 24) {
        return difference.inHours.abs().toString()+"hour ago";
      }else if(difference.inDays.abs() < 2) {
        return difference.inDays.abs().toString()+"day ago";
      }else if(difference.inDays.abs() < 7) {
        return difference.inDays.abs().toString()+"days ago";
      }else {
        return DateFormat("yy.MM.dd").format(destTime);
      }
    }else {
      if(difference.inSeconds.abs() < 10){
        return "Soon";
      }else if(difference.inSeconds.abs() < 60){
        return difference.inSeconds.abs().toString()+"sec left";
      }else if(difference.inMinutes.abs() < 60 ){
        return difference.inMinutes.abs().toString()+"min left";
      }else if(difference.inHours.abs() < 24) {
        return difference.inHours.abs().toString()+"hour left";
      }else if(difference.inDays.abs() < 2) {
        return difference.inDays.abs().toString()+"day left";
      }else {
        return difference.inDays.abs().toString() + "days left";
      }
    }
  }

}