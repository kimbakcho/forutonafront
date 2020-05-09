import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:forutonafront/FBall/MarkerSupport/Style1/MarkerStyle1Util.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'FBallResForMarkerDto.dart';


/// This just adds overlay and builds [_MarkerHelper] on that overlay.
/// [_MarkerHelper] does all the heavy work of creating and getting bitmaps
/// 해당 객체는 BallList FBallResForMarkerDto 를 받고 결과로 GoogleMapMaker Completer 통해 리턴함
class MakerSupportStyle1 {
//  final Function(List<Uint8List>) callback;
  final List<FBallResForMarkerDto> ballList;
  final Completer completer;

  MakerSupportStyle1(this.ballList, this.completer);

  Future<void> generate(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => afterFirstLayout(context));
    return completer.future;
  }

  void afterFirstLayout(BuildContext context) {
    addOverlay(context);
  }

  void addOverlay(BuildContext context) {
    OverlayState overlayState = Overlay.of(context);

    OverlayEntry entry = OverlayEntry(
        builder: (context) {
          return _MarkerHelper(
            ballList: ballList,
            completer: completer,
          );
        },
        maintainState: true);

    overlayState.insert(entry);
  }
}

/// Maps are embeding GoogleMap library for Andorid/iOS  into flutter.
///
/// These native libraries accept BitmapDescriptor for marker, which means that for custom markers
/// you need to draw view to bitmap and then send that to BitmapDescriptor.
///
/// Because of that Flutter also cannot accept Widget for marker, but you need draw it to bitmap and
/// that's what this widget does:
///
/// 1) It draws marker widget to tree
/// 2) After painted access the repaint boundary with global key and converts it to uInt8List
/// 3) Returns set of Uint8List (bitmaps) through callback
class _MarkerHelper extends StatefulWidget {
  final List<FBallResForMarkerDto> ballList;

  final Completer completer;

  const _MarkerHelper({Key key, this.ballList, this.completer})
      : super(key: key);

  @override
  _MarkerHelperState createState() {
    return _MarkerHelperState();
  }
}

class _MarkerHelperState extends State<_MarkerHelper> with AfterLayoutMixin {
  List<GlobalKey> globalKeys = List<GlobalKey>();

  @override
  void afterFirstLayout(BuildContext context) async {
    List<Uint8List> bitMapFromWidget = await _getBitmaps(context);
    Set<Marker> markers = new Set<Marker>();
    for(int i=0;i<bitMapFromWidget.length;i++){
      markers.add(Marker(
        markerId: MarkerId(widget.ballList[i].ballUuid),
        icon: BitmapDescriptor.fromBytes(bitMapFromWidget[i]),
        anchor: widget.ballList[i].isSelectBall ? Offset(0.5,1) : Offset(0.5,0.5),
        zIndex: widget.ballList[i].isSelectBall ? 2 : 1 ,
        onTap: (){
          widget.ballList[i].onTopEvent(widget.ballList[i]);
        },
        position: LatLng(widget.ballList[i].latitude,widget.ballList[i].longitude),
      ));
    }
    widget.completer.complete(markers);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetBalls = [];
    for (var ball in widget.ballList) {
      widgetBalls.add(MarkerStyle1Util.ballWidgetSelect(
          ball.ballType, ball.isSelectBall));
    }

    return Transform.translate(
        offset: Offset(MediaQuery.of(context).size.width+100, 0),
        child: Material(
            type: MaterialType.transparency,
            child: Stack(
              children: widgetBalls.map((i) {
                final markerKey = GlobalKey();
                globalKeys.add(markerKey);
                return RepaintBoundary(
                  key: markerKey,
                  child: i,
                );
              }).toList(),
            )));
  }

  Future<List<Uint8List>> _getBitmaps(BuildContext context) async {
    var futures = globalKeys.map((key) => _getUint8List(key));
    return Future.wait(futures);
  }

  Future<Uint8List> _getUint8List(GlobalKey markerKey) async {
    RenderRepaintBoundary boundary =
        markerKey.currentContext.findRenderObject();
    var image = await boundary.toImage(pixelRatio: 1.0);
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData.buffer.asUint8List();
  }
}

/// AfterLayoutMixin
mixin AfterLayoutMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => afterFirstLayout(context));
  }

  void afterFirstLayout(BuildContext context);
}
