import 'package:forutonafront/Common/AddressSearchHistory/Domain/Value/AddressSearchHistory.dart';

abstract class AddressSearchHistoryRepository {
  Future<AddressSearchHistory> save(String search);
  Future<void> delete(String search);
  Future<List<AddressSearchHistory>> findByAll();
}