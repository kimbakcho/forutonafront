import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/FluttertoastAdapter/FluttertoastAdapter.dart';
import 'package:forutonafront/Components/AddressInputSearchBar/AddressInputSearchBar.dart';

import 'package:mockito/mockito.dart';

class MockAddressInputSearchBarListener extends Mock
    implements AddressInputSearchBarListener {}

class MockFluttertoastAdapter extends Mock implements FluttertoastAdapter {}

void main() {
  AddressInputSearchBarViewModel viewModel;
  MockAddressInputSearchBarListener mockAddressInputSearchBarListener;
  MockFluttertoastAdapter fluttertoastAdapter;
  setUp(() {

  });

  test('옵져버로 실행', () async {
    //given
    mockAddressInputSearchBarListener = MockAddressInputSearchBarListener();
    fluttertoastAdapter = MockFluttertoastAdapter();
    viewModel = AddressInputSearchBarViewModel(
        listener: mockAddressInputSearchBarListener,
        fluttertoastAdapter: fluttertoastAdapter);
    String searchText = "신도림";
    //when
    viewModel.addressSearch(searchText);
    //then
    verify(mockAddressInputSearchBarListener.onAddressSearch(searchText));
  });

  test('1글자일때 토스트 띄움', () async {
    //given
    mockAddressInputSearchBarListener = MockAddressInputSearchBarListener();
    fluttertoastAdapter = MockFluttertoastAdapter();
    viewModel = AddressInputSearchBarViewModel(
        listener: mockAddressInputSearchBarListener,
        fluttertoastAdapter: fluttertoastAdapter);
    String searchText = "신";
    //when
    viewModel.addressSearch(searchText);
    //then
    verifyNever(mockAddressInputSearchBarListener.onAddressSearch(searchText));
    verify(fluttertoastAdapter.showToast(msg: anyNamed('msg')));
  });

  test('init Text', () async {
    //given
    mockAddressInputSearchBarListener = MockAddressInputSearchBarListener();
    fluttertoastAdapter = MockFluttertoastAdapter();
    viewModel = AddressInputSearchBarViewModel(
      initText: "TEST",
        listener: mockAddressInputSearchBarListener,
        fluttertoastAdapter: fluttertoastAdapter);
    //when

    //then
    expect(viewModel.textEditingController.text, "TEST");
  });
}
