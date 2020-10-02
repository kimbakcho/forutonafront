import 'package:flutter_test/flutter_test.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Components/TopNav/TopNavExpendGroup/H_I_001/GeoViewSearchManager.dart';

import 'package:mockito/mockito.dart';
class MockH001Listener extends Mock implements GeoViewSearchListener{}

void main() {
  GeoViewSearchManagerInputPort geoViewSearchManagerInputPort;
  setUp((){
    geoViewSearchManagerInputPort = GeoViewSearchManager();
  });

  test('should addListener', () async {
    //arrange
    MockH001Listener mockH001Listener = MockH001Listener();
    //act
    geoViewSearchManagerInputPort.subscribe(mockH001Listener);
    //assert
    expect(geoViewSearchManagerInputPort.getSubscribeSize(), 1);
  });

  test('should removeListener', () async {
    //arrange
    MockH001Listener mockH001Listener = MockH001Listener();
    geoViewSearchManagerInputPort.subscribe(mockH001Listener);
    //act
    geoViewSearchManagerInputPort.unSubscribe(mockH001Listener);
    //assert
    expect(geoViewSearchManagerInputPort.getSubscribeSize(), 0);
  });

  test('should search', () async {
    //arrange
    MockH001Listener mockH001Listener = MockH001Listener();
    geoViewSearchManagerInputPort.subscribe(mockH001Listener);
    Position position = Position(longitude: 127.1,latitude: 37.1);
    //act
    geoViewSearchManagerInputPort.search(position);
    //assert
    verify(mockH001Listener.search(position));
  });
}