// m 거리를 받아 알맞는 Text 변경 
class DistanceDisplayUtil {
  static String changeDisplayStr(double distance){
    if(distance< 1000){
      return distance.toStringAsFixed(0)+"m";
    }else if(  distance >= 1000 &&  distance < 1000000){
      return (distance/1000).toStringAsFixed(0)+"km";
    }else if( distance >= 1000000 ){
      return (distance/1000000).toStringAsFixed(0)+"Mm";
    }else {
      return "";
    }
  }
}