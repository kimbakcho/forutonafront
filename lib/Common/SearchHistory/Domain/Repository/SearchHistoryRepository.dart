
import 'package:forutonafront/Common/SearchHistory/Domain/Value/SearchHistory.dart';


enum SearchHistoryDataSourceKey {
  AddressSearchHistoryDataSource,
  KPartSearchHistoryDataSource
}

abstract class SearchHistoryRepository {
  Future<SearchHistory> save(String search);
  Future<void> delete(String search);
  Future<List<SearchHistory>> findByAll();
}