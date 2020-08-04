import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WidgetToImage extends StatelessWidget {
  final Widget widget;
  final GlobalKey key;

  WidgetToImage({this.widget}):key = GlobalKey();

  Future<Uint8List> toBytes() async {
    await Future.delayed(Duration.zero);
    RenderRepaintBoundary boundary = key.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData.buffer.asUint8List();
  }

  Future<BitmapDescriptor> toBitmapDescriptor() async {
    return BitmapDescriptor.fromBytes(await toBytes());
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
        offset: Offset(MediaQuery.of(context).size.width + 100, 0),
        child: RepaintBoundary(
          key: key,
          child: widget,
        ));
  }
}
