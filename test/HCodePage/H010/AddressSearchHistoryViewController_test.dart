import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/HCodePage/H010/AddressSearchHistoryView.dart';
import 'package:mockito/mockito.dart';

class MockAddressSearchHistoryViewModel extends Mock implements AddressSearchHistoryViewModel{}

void main () {

  AddressSearchHistoryViewController addressSearchHistoryViewController;
  MockAddressSearchHistoryViewModel mockAddressSearchHistoryViewModel;
  setUp((){
    mockAddressSearchHistoryViewModel = MockAddressSearchHistoryViewModel();
    addressSearchHistoryViewController = AddressSearchHistoryViewController();
    addressSearchHistoryViewController.addressSearchHistoryViewModel =  mockAddressSearchHistoryViewModel;
  });
  test('컨트롤러를 통해 ViewModel AdHistory 실행', () async {
    //given

    //when
    await addressSearchHistoryViewController.addHistory("test");
    //then
    verify(mockAddressSearchHistoryViewModel.addHistory("test"));
  });
}