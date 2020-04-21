import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallType.dart';
import 'package:forutonafront/FBall/MarkerSupport/Style2/FBallResForMarkerStyle2Dto.dart';
import 'package:forutonafront/FBall/MarkerSupport/Style2/MakerSupportStyle2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ID001MainPageViewModel extends ChangeNotifier {
  final BuildContext _context;
  final FBallResDto fBallResDto;


  CameraPosition initialCameraPosition;
  Set<Marker> markers = Set<Marker>();

  GlobalKey makerAnimationKey = new GlobalKey();

  List<FBallResForMarkerStyle2Dto> ballList;

  ScrollController mainScrollController = new ScrollController();

  //볼에 레이더 애니메이션을 주기위한 Ticker
  Ticker _ticker;

  ID001MainPageViewModel(this._context, this.fBallResDto) {
    initialCameraPosition = CameraPosition(
        target: LatLng(fBallResDto.latitude, fBallResDto.longitude),
        zoom: 14.425);
    init();
  }

  init() async {
    this.ballList = new List<FBallResForMarkerStyle2Dto>();
    ballList.add(new FBallResForMarkerStyle2Dto(
        FBallType.IssueBall, LatLng(fBallResDto.latitude, fBallResDto.longitude), fBallResDto.ballUuid));
    Completer<Set<Marker>> _markerCompleter = Completer();
    MakerSupportStyle2(ballList, _markerCompleter).generate(_context);
    Set<Marker> markers = await _markerCompleter.future;
    this.markers.clear();
    this.markers.addAll(markers);
    _ticker = Ticker(onTickerDrawBall);
    //개발중에는 애니메이션 효과 줄시 너무 느리므로 끔.
//    _ticker.start();
    notifyListeners();
  }



  //여기서 선택된 볼의 애니메이션을 같이 그려준다.
  onTickerDrawBall(Duration duration) async {
    Completer<Set<Marker>> _markerCompleter = Completer();
    RenderRepaintBoundary ballAnimation =
    makerAnimationKey.currentContext.findRenderObject();
    var ballAnimationImage = await ballAnimation.toImage(pixelRatio: 1.0);
    ByteData byteData =
    await ballAnimationImage.toByteData(format: ui.ImageByteFormat.png);
    Uint8List uint8BallAnimation = byteData.buffer.asUint8List();
    MakerSupportStyle2(ballList, _markerCompleter).generate(_context);
    Set<Marker> markers = await _markerCompleter.future;
    this.markers.clear();
    this.markers.addAll(markers);
    this.markers.add(Marker(
        markerId: MarkerId("selectlader"),
        position: LatLng(fBallResDto.latitude, fBallResDto.longitude),
        anchor: Offset(0.5, 0.5),
        zIndex: 0,
        icon: BitmapDescriptor.fromBytes(uint8BallAnimation)));
    notifyListeners();
  }
  void onBackBtn() {}
}
