import 'dart:async';
import 'dart:typed_data';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forutonafront/FBall/Dto/FBallType.dart';
import 'package:forutonafront/FBall/MarkerSupport/Style2/FBallResForMarkerStyle2Dto.dart';
import 'package:forutonafront/FBall/MarkerSupport/Style2/MakerSupportStyle2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import 'dart:ui' as ui;

class IM001MainPageViewModel extends ChangeNotifier {
  final BuildContext _context;
  final LatLng _setUpPosition;
  String _ballUuid;
  //볼에 레이더 애니메이션을 주기위한 Ticker
  Ticker _ticker;

  final String address;
  CameraPosition initCameraPosition;
  Set<Marker> markers = Set<Marker>();
  List<FBallResForMarkerStyle2Dto> ballList;
  GlobalKey makerAnimationKey = new GlobalKey();
  TextEditingController titleEditController = TextEditingController();
  FocusNode titleFocusNode = FocusNode();

  TextEditingController textContentEditController = TextEditingController();

  FocusNode textContentFocusNode = FocusNode();


  IM001MainPageViewModel(this._context, this._setUpPosition, this.address) {
    _ballUuid = new Uuid().v4();
    initCameraPosition =
        new CameraPosition(target: _setUpPosition, zoom: 14.4746);
    titleFocusNode.addListener(onTitleFocusNode);
    textContentFocusNode.addListener(ontextContentFocusNode);
    _init();
  }
  void ontextContentFocusNode() {
    notifyListeners();
  }

  _init() async {
    this.ballList = new List<FBallResForMarkerStyle2Dto>();
    ballList.add(new FBallResForMarkerStyle2Dto(
        FBallType.IssueBall, _setUpPosition, _ballUuid));
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

  onTitleFocusNode(){
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
    MakerSupportStyle2(ballList, _markerCompleter)
        .generate(_context);
    Set<Marker> markers = await _markerCompleter.future;
    this.markers.clear();
    this.markers.addAll(markers);
    this.markers.add(Marker(
        markerId: MarkerId("selectlader"),
        position: this._setUpPosition,
        anchor: Offset(0.5, 0.5),
        zIndex: 0,
        icon: BitmapDescriptor.fromBytes(uint8BallAnimation)));
    notifyListeners();
  }



  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void onBackBtnTap() {
    Navigator.of(_context).pop();
  }

  isValidComplete() {
    return true;
  }

  void onCompleteTap() {

  }



}
