
abstract class NoInterestBallRepository {
  save(String ballUuid);
  Future<List<String>> findByAll();
  Future<bool>  existsByBallUuid(String ballUuid);
  deleteByBallUuid(String s);
}