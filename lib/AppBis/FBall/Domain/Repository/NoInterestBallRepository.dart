
abstract class NoInterestBallRepository {
  save(String ballUuid,String uid);
  Future<List<String>> findByAll(String uid);
  Future<bool>  existsByBallUuid(String ballUuid,String uid);
  deleteByBallUuid(String s,String uid);
}