class NomalValueDisplay {
  static String changeIntDisplaystr(num value){
    if(value < 1000){
      return value.toString();
    }else {
      return (value/1000).toStringAsFixed(1);
    }
  }
}