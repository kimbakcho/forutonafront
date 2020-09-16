import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/HCodePage/H001/H001Manager.dart';
import 'package:mockito/mockito.dart';
class MockH001Listener extends Mock implements H001Listener{}
void main() {
  H001Manager h001manager;
  setUp((){
    h001manager = H001Manager();
  });

  test('should addListener', () async {
    //arrange
    MockH001Listener mockH001Listener = MockH001Listener();
    //act
    h001manager.subscribe(mockH001Listener);
    //assert
    expect(h001manager.getSubscribeSize(), 1);
  });

  test('should removeListener', () async {
    //arrange
    MockH001Listener mockH001Listener = MockH001Listener();
    h001manager.subscribe(mockH001Listener);
    //act
    h001manager.unSubscribe(mockH001Listener);
    //assert
    expect(h001manager.getSubscribeSize(), 0);
  });

  test('should search', () async {
    //arrange
    MockH001Listener mockH001Listener = MockH001Listener();
    h001manager.subscribe(mockH001Listener);
    Position position = Position(longitude: 127.1,latitude: 37.1);
    //act
    h001manager.search(position);
    //assert
    verify(mockH001Listener.search(position));
  });
}