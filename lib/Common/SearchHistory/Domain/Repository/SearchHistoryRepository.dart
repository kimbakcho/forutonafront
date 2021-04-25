
import 'package:forutonafront/Common/SearchHistory/Domain/Value/SearchHistory.dart';


enum SearchHistoryDataSourceKey {
  AddressSearchHistoryDataSource,
  KPartSearchHistoryDataSource
}

abstract class SearchHistoryRepository {
  Future<SearchHistory> save(String search,String uid);
  Future<void> delete(String search,String uid);
  Future<List<SearchHistory>> findByAll(String uid);
}