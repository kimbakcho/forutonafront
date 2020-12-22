import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Page/HCodePage/H010/SearchHistoryView.dart';
import 'package:mockito/mockito.dart';


class MockAddressSearchHistoryViewModel extends Mock implements SearchHistoryViewModel{}

void main () {

  SearchHistoryViewController searchHistoryViewController;
  MockAddressSearchHistoryViewModel searchHistoryViewModel;
  setUp((){
    searchHistoryViewController = SearchHistoryViewController();

    searchHistoryViewModel = MockAddressSearchHistoryViewModel();

  });
  test('컨트롤러를 통해 ViewModel AdHistory 실행', () async {
    //given
    searchHistoryViewController.addressSearchHistoryViewModel = searchHistoryViewModel;
    //when
    await searchHistoryViewController.addHistory("test");
    //then
    verify(searchHistoryViewModel.addHistory("test"));
  });
}