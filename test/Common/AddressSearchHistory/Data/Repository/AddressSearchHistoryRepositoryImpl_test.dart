import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/AddressSearchHistory/Data/Repository/AddressSearchHistoryRepositoryImpl.dart';
import 'package:forutonafront/Common/AddressSearchHistory/Domain/Repository/AddressSearchHistoryRepository.dart';
import 'package:forutonafront/Common/AddressSearchHistory/Domain/Value/AddressSearchHistory.dart';
import 'package:forutonafront/Common/SharedPreferencesAdapter/SharedPreferencesAdapter.dart';

void main() {
  AddressSearchHistoryRepository addressSearchHistoryRepository;

  setUp(() {
    addressSearchHistoryRepository =
        AddressSearchHistoryRepositoryImpl(
            sharedPreferencesAdapter: MemorySharePreferencesAdapterImpl());
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
    List<AddressSearchHistory> histories = await addressSearchHistoryRepository.findByAll();

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
    List<AddressSearchHistory> histories = await addressSearchHistoryRepository.findByAll();

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
    List<AddressSearchHistory> histories = await addressSearchHistoryRepository.findByAll();

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
    List<AddressSearchHistory> histories = await addressSearchHistoryRepository.findByAll();
    expect(histories[0].searchText, "2");
    expect(histories[1].searchText, "1");

    expect(histories.length, 2);

  });
}