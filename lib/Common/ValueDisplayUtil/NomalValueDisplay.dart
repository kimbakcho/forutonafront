class NomalValueDisplay {
  static String changeIntDisplaystr(num value){
    if(value < 1000){
      return value.toStringAsFixed(0);
    }else {
      return (value/1000).toStringAsFixed(1)+"k";
    }
  }
}