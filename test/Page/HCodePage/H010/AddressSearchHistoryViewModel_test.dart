import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/SearchHistory/Domain/UseCase/SearchHistoryUseCaseInputPort.dart';

import 'package:forutonafront/Page/HCodePage/H010/SearchHistoryView.dart';
import 'package:mockito/mockito.dart';


class MockAddressSearchHistoryUseCaseInputPort extends Mock implements SearchHistoryUseCaseInputPort{}
void main(){

  SearchHistoryViewModel addressSearchHistoryViewModel;

  MockAddressSearchHistoryUseCaseInputPort mockAddressSearchHistoryUseCaseInputPort;

  setUp((){

  });

  test('생성시 컨트롤러에 model 할당', () async {
    //given

    //when
    SearchHistoryViewController addressSearchHistoryViewController = SearchHistoryViewController();
    mockAddressSearchHistoryUseCaseInputPort = MockAddressSearchHistoryUseCaseInputPort();
    addressSearchHistoryViewModel = SearchHistoryViewModel(
        searchHistoryViewController: addressSearchHistoryViewController,
        searchHistoryUseCaseInputPort: mockAddressSearchHistoryUseCaseInputPort
    );

    //then
    expect(addressSearchHistoryViewController.addressSearchHistoryViewModel, addressSearchHistoryViewModel);
  });


}