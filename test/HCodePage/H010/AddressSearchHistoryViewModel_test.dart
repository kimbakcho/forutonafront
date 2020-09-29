import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/AddressSearchHistory/Domain/UseCase/AddressSearchHistoryUseCaseInputPort.dart';
import 'package:forutonafront/HCodePage/H010/AddressSearchHistoryView.dart';
import 'package:mockito/mockito.dart';


class MockAddressSearchHistoryUseCaseInputPort extends Mock implements AddressSearchHistoryUseCaseInputPort{}
void main(){

  AddressSearchHistoryViewModel addressSearchHistoryViewModel;

  MockAddressSearchHistoryUseCaseInputPort mockAddressSearchHistoryUseCaseInputPort;

  setUp((){

  });

  test('생성시 컨트롤러에 model 할당', () async {
    //given

    //when
    AddressSearchHistoryViewController addressSearchHistoryViewController = AddressSearchHistoryViewController();
    mockAddressSearchHistoryUseCaseInputPort = MockAddressSearchHistoryUseCaseInputPort();
    addressSearchHistoryViewModel = AddressSearchHistoryViewModel(
        addressSearchHistoryViewController: addressSearchHistoryViewController,
        addressSearchHistoryUseCaseInputPort: mockAddressSearchHistoryUseCaseInputPort
    );

    //then
    expect(addressSearchHistoryViewController.addressSearchHistoryViewModel, addressSearchHistoryViewModel);
  });


}