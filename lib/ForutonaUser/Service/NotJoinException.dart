class NotJoinException implements Exception {
  String cause;
  NotJoinException(this.cause);
}