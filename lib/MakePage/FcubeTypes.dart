import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;

class FcubeTypeObj {
  String name;
  FcubeType type;
  String picture;
  String description;

  FcubeTypeObj({this.name, this.type, this.picture, this.description});
}

class FcubeTypeMakerImage {
  Map<FcubeType, BitmapDescriptor> nomalimage =
      Map<FcubeType, BitmapDescriptor>();
  Map<FcubeType, BitmapDescriptor> bigimage =
      Map<FcubeType, BitmapDescriptor>();
  Map<FcubeType, Image> iconImage = Map<FcubeType, Image>();
  int nomal = 100;
  int big = 150;
  int iconimagesize = 80;
  FcubeTypeMakerImage({this.nomal, this.big, this.iconimagesize});
  Future<void> initImage() async {
    nomalimage[FcubeType.messageCube] =
        await getMarkerImage("assets/MarkesImages/MessageCube.png", nomal);
    nomalimage[FcubeType.questCube] =
        await getMarkerImage("assets/MarkesImages/QuestCube.png", nomal);
    nomalimage[FcubeType.checkincube] =
        await getMarkerImage("assets/MarkesImages/CheckInCube.png", nomal);
    nomalimage[FcubeType.finishcube] =
        await getMarkerImage("assets/MarkesImages/finishCube.png", nomal);
    nomalimage[FcubeType.startcube] =
        await getMarkerImage("assets/MarkesImages/startCube.png", nomal);
    nomalimage[FcubeType.currentselectcube] =
        await getMarkerImage("assets/MarkesImages/SelectMarker.png", nomal);
    nomalimage[FcubeType.issuecube] =
        await getMarkerImage("assets/MarkesImages/TempCube.png", nomal);

    bigimage[FcubeType.messageCube] =
        await getMarkerImage("assets/MarkesImages/MessageCube.png", big);
    bigimage[FcubeType.questCube] =
        await getMarkerImage("assets/MarkesImages/QuestCube.png", big);
    bigimage[FcubeType.checkincube] =
        await getMarkerImage("assets/MarkesImages/CheckInCube.png", big);
    bigimage[FcubeType.finishcube] =
        await getMarkerImage("assets/MarkesImages/finishCube.png", big);
    bigimage[FcubeType.startcube] =
        await getMarkerImage("assets/MarkesImages/startCube.png", big);
    bigimage[FcubeType.currentselectcube] =
        await getMarkerImage("assets/MarkesImages/SelectMarker.png", big);
    bigimage[FcubeType.issuecube] =
        await getMarkerImage("assets/MarkesImages/TempCube.png", big);

    iconImage[FcubeType.messageCube] = Image(
        image: AssetImage("assets/MarkesImages/MessageCube.png"),
        width: iconimagesize.toDouble(),
        height: iconimagesize.toDouble());

    iconImage[FcubeType.questCube] = Image(
        image: AssetImage("assets/MarkesImages/QuestCube.png"),
        width: iconimagesize.toDouble(),
        height: iconimagesize.toDouble());

    iconImage[FcubeType.checkincube] = Image(
        image: AssetImage("assets/MarkesImages/CheckInCube.png"),
        width: iconimagesize.toDouble(),
        height: iconimagesize.toDouble());

    iconImage[FcubeType.finishcube] = Image(
        image: AssetImage("assets/MarkesImages/finishCube.png"),
        width: iconimagesize.toDouble(),
        height: iconimagesize.toDouble());

    iconImage[FcubeType.startcube] = Image(
        image: AssetImage("assets/MarkesImages/startCube.png"),
        width: iconimagesize.toDouble(),
        height: iconimagesize.toDouble());

    iconImage[FcubeType.currentselectcube] = Image(
        image: AssetImage("assets/MarkesImages/SelectMarker.png"),
        width: iconimagesize.toDouble(),
        height: iconimagesize.toDouble());
    iconImage[FcubeType.issuecube] = Image(
        image: AssetImage("assets/MarkesImages/TempCube.png"),
        width: iconimagesize.toDouble(),
        height: iconimagesize.toDouble());
  }

  static Future<Uint8List> _getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  static Future<BitmapDescriptor> getMarkerImage(String path, int widt) async {
    return BitmapDescriptor.fromBytes(await _getBytesFromAsset(path, widt));
  }
}

class FcubeType {
  const FcubeType._(this.value);

  final int value;
  static const FcubeType messageCube = FcubeType._(0);
  static const FcubeType questCube = FcubeType._(1);
  static const FcubeType startcube = FcubeType._(2);
  static const FcubeType finishcube = FcubeType._(3);
  static const FcubeType checkincube = FcubeType._(4);
  static const FcubeType currentselectcube = FcubeType._(5);
  static const FcubeType issuecube = FcubeType._(6);

  static const List<FcubeType> values = <FcubeType>[
    messageCube,
    questCube,
    startcube,
    finishcube,
    checkincube,
    currentselectcube,
    issuecube
  ];

  static const List<String> _names = <String>[
    'messagecube',
    'questCube',
    'startcube',
    'finishcube',
    'checkincube',
    'currentselectcube',
    'issuecube'
  ];

  static FcubeType fromJson(value) {
    return values[_names.indexOf(value)];
  }

  static String toJson(type) {
    return _names[type.value];
  }

  @override
  String toString() => _names[value];
}
