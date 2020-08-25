import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'FBallResForMarkerStyle2Dto.dart';
import 'dart:ui' as ui;

import 'MarkerStyle2Util.dart';



/// This just adds overlay and builds [_MarkerHelper] on that overlay.
/// [_MarkerHelper] does all the heavy work of creating and getting bitmaps
/// 해당 객체는 BallList FBallResForMarkerDto 를 받고 결과로 GoogleMapMaker Completer 통해 리턴함
class MakerSupportStyle2 {
//  final Function(List<Uint8List>) callback;
  final List<FBallResForMarkerStyle2Dto> ballList;
  final Completer completer;

  MakerSupportStyle2(this.ballList, this.completer,);

  Future<void> generate(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => afterFirstLayout(context));
    return completer.future;
  }

  MarkerHelper helper;

  void afterFirstLayout(BuildContext context) {
    addOverlay(context);
  }

  void addOverlay(BuildContext context) {
    print("context");
    print(context);
    OverlayState overlayState = Overlay.of(context);
    helper = MarkerHelper(
      ballList: ballList,
      completer: completer,
    );
    OverlayEntry entry = OverlayEntry(
        builder: (context) {
          return helper;
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
class MarkerHelper extends StatefulWidget {
  final List<FBallResForMarkerStyle2Dto> ballList;

  final Completer completer;

  final RenderRepaintBoundary widgetAnimation;

  final LatLng widgetAnimationLatlng;


  const MarkerHelper({Key key, this.ballList, this.completer,this.widgetAnimation,this.widgetAnimationLatlng})
      : super(key: key);


  @override
  _MarkerHelperState createState() {
    return _MarkerHelperState();
  }
}

class _MarkerHelperState extends State<MarkerHelper> with AfterLayoutMixin {
  List<GlobalKey> globalKeys = List<GlobalKey>();
  @override
  void dispose() {

    super.dispose();
    print("MarkerHelperStateDisPose");
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    List<Uint8List> bitMapFromWidget = await _getBitmaps(context);
    Set<Marker> markers = new Set<Marker>();
    int ballMarkerLength =  bitMapFromWidget.length;
    for(int i=0;i<ballMarkerLength;i++){
      markers.add(Marker(
        markerId: MarkerId(widget.ballList[i].ballUuid),
        anchor: Offset(0.5,0.5),
        icon: BitmapDescriptor.fromBytes(bitMapFromWidget[i]),
        position: widget.ballList[i].target,
        zIndex: 1
      ));
    }
    widget.completer.complete(markers);

  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetBalls = [];
    for (var ball in widget.ballList) {
      widgetBalls.add(MarkerStyle1Uti2.ballWidgetSelect(
          ball.ballType));
    }

    return Transform.translate(
        offset: Offset(MediaQuery.of(context).size.width, 0),
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
            ))
    );
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
