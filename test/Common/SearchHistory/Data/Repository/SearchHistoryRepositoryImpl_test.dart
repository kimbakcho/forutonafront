import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/SearchHistory/Data/Repository/SearchHistoryRepositoryImpl.dart';
import 'package:forutonafront/Common/SearchHistory/Domain/Repository/SearchHistoryRepository.dart';
import 'package:forutonafront/Common/SearchHistory/Domain/Value/SearchHistory.dart';
import 'package:forutonafront/Common/SharedPreferencesAdapter/SharedPreferencesAdapter.dart';

void main() {
  SearchHistoryRepository addressSearchHistoryRepository;

  setUp(() {
    addressSearchHistoryRepository =
        SearchHistoryRepositoryImpl(
            sharedPreferencesAdapter: MemorySharePreferencesAdapterImpl(),
          searchHistoryDataSourceKey: SearchHistoryDataSourceKey.AddressSearchHistoryDataSource
        );
  });

  test('should save over 5 ', () async {
    //given

    //when
    await addressSearchHistoryRepository.save("1");
    await addressSearchHistoryRepository.save("2");
    await addressSearchHistoryRepository.save("3");
    await addressSearchHistoryRepository.save("4");
    await addressSearchHistoryRepository.save("5");
    await addressSearchHistoryRepository.save("6");
    //then
    List<SearchHistory> histories = await addressSearchHistoryRepository.findByAll();

    expect(histories[0].searchText, "6");
    expect(histories[1].searchText, "5");
    expect(histories[2].searchText, "4");
    expect(histories[3].searchText, "3");
    expect(histories[4].searchText, "2");
    expect(histories.length, 5);

  });

  test('should save 3 ', () async {
    //given

    //when
    await addressSearchHistoryRepository.save("1");
    await addressSearchHistoryRepository.save("2");
    await addressSearchHistoryRepository.save("3");


    //then
    List<SearchHistory> histories = await addressSearchHistoryRepository.findByAll();

    expect(histories[0].searchText, "3");
    expect(histories[1].searchText, "2");
    expect(histories[2].searchText, "1");
    expect(histories.length, 3);

  });


  test('should 같은 이름 저장 ', () async {
    //given
    await addressSearchHistoryRepository.save("1");
    await addressSearchHistoryRepository.save("2");
    await addressSearchHistoryRepository.save("3");

    //when
    await addressSearchHistoryRepository.save("1");


    //then
    List<SearchHistory> histories = await addressSearchHistoryRepository.findByAll();

    expect(histories[0].searchText, "1");
    expect(histories[1].searchText, "3");
    expect(histories[2].searchText, "2");
    expect(histories.length, 3);

  });

  test('delete test ', () async {
    //given
    await addressSearchHistoryRepository.save("1");
    await addressSearchHistoryRepository.save("2");
    await addressSearchHistoryRepository.save("3");
    //when
    await addressSearchHistoryRepository.delete("3");
    //then
    List<SearchHistory> histories = await addressSearchHistoryRepository.findByAll();
    expect(histories[0].searchText, "2");
    expect(histories[1].searchText, "1");

    expect(histories.length, 2);

  });

  test('should key String Data', () async {
    //given

    print(EnumToString.convertToString(SearchHistoryDataSourceKey.AddressSearchHistoryDataSource));
    //when

    //then
  });
}