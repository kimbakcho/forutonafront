import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/FluttertoastAdapter/FluttertoastAdapter.dart';
import 'package:forutonafront/Components/InputSearchBar/InputSearchBar.dart';


import 'package:mockito/mockito.dart';

class MockAddressInputSearchBarListener extends Mock
    implements InputSearchBarListener {}

class MockFluttertoastAdapter extends Mock implements FluttertoastAdapter {}

void main() {
  InputSearchBarViewModel viewModel;
  MockAddressInputSearchBarListener mockAddressInputSearchBarListener;
  MockFluttertoastAdapter fluttertoastAdapter;
  setUp(() {

  });

  test('옵져버로 실행', () async {
    //given
    mockAddressInputSearchBarListener = MockAddressInputSearchBarListener();
    fluttertoastAdapter = MockFluttertoastAdapter();
    viewModel = InputSearchBarViewModel(
        inputSearchBarListener: mockAddressInputSearchBarListener,
        fluttertoastAdapter: fluttertoastAdapter);
    String searchText = "신도림";
    //when
    viewModel.onSearch(searchText);
    //then
    verify(mockAddressInputSearchBarListener.onSearch(searchText));
  });

  test('1글자일때 토스트 띄움', () async {
    //given
    mockAddressInputSearchBarListener = MockAddressInputSearchBarListener();
    fluttertoastAdapter = MockFluttertoastAdapter();
    viewModel = InputSearchBarViewModel(
        inputSearchBarListener: mockAddressInputSearchBarListener,
        fluttertoastAdapter: fluttertoastAdapter);
    String searchText = "신";
    //when
    viewModel.onSearch(searchText);
    //then
    verifyNever(mockAddressInputSearchBarListener.onSearch(searchText));
    verify(fluttertoastAdapter.showToast(msg: anyNamed('msg')));
  });

  test('init Text', () async {
    //given
    mockAddressInputSearchBarListener = MockAddressInputSearchBarListener();
    fluttertoastAdapter = MockFluttertoastAdapter();
    viewModel = InputSearchBarViewModel(
      initText: "TEST",
        inputSearchBarListener: mockAddressInputSearchBarListener,
        fluttertoastAdapter: fluttertoastAdapter);
    //when

    //then
    expect(viewModel.textEditingController.text, "TEST");
  });
}
