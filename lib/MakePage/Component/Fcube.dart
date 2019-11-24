import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:forutonafront/MakePage/FcubeTypes.dart';
import 'package:forutonafront/Preference.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;

class CurrentSelectCubeLocation {
  Marker currentselectmaker;
  double longitude;
  double latitude;
  static String currentSelectCubeIconPath =
      "assets/MarkesImages/SelectMarker.png";
  CurrentSelectCubeLocation();
  CurrentSelectCubeLocation.fromJson(Map<String, dynamic> json) {
    longitude = json['longitude'];
    latitude = json['latitude'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    return data;
  }
}

class Fcube {
  String cubeuuid;
  String uid;
  double longitude;
  double latitude;
  String cubename;
  String cubedispalyname;
  FcubeType cubetype;
  String cubeimage;
  String maketime;
  double influence;
  FcubeState cubestate;
  String placeaddress;
  String administrativearea;
  String country;
  double pointreward;
  double influencereward;
  String activationtime;
  String cubepassword;
  int haspassword;
  int cubescope;
  double influencelevel;
  int cubehits;
  int cubelikes;
  int cubedislikes;
  int maximumplayers;

  CurrentSelectCubeLocation currentselectcube;

  Fcube(
      {this.cubeuuid,
      this.uid,
      this.longitude,
      this.latitude,
      this.cubename,
      this.cubedispalyname,
      this.cubetype,
      this.maketime,
      this.influence,
      this.cubestate,
      this.placeaddress,
      this.administrativearea,
      this.country,
      this.cubeimage,
      this.pointreward,
      this.influencereward,
      this.activationtime,
      this.haspassword,
      this.cubepassword,
      this.cubescope,
      this.influencelevel,
      this.cubehits,
      this.cubelikes,
      this.cubedislikes,
      this.maximumplayers});

  Fcube.fromJson(Map<String, dynamic> json) {
    cubeuuid = json['cubeuuid'];
    uid = json['uid'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    cubename = json['cubename'];
    cubetype = FcubeType.fromJson(json['cubetype']);
    maketime = json['maketime'];
    influence = json['influence'];
    cubestate = FcubeState.fromJson(json['cubestate']);
    placeaddress = json['placeaddress'];
    administrativearea = json['administrativearea'];
    country = json['country'];
    pointreward = json['pointreward'];
    influencereward = json['influencereward'];
    activationtime = json['activationtime'];
    cubepassword = json['cubepassword'];
    haspassword = json['haspassword'];
    cubescope = json['cubescope'];
    influencelevel = json['influencelevel'];
    cubehits = json['cubehits'];
    cubelikes = json['cubelikes'];
    cubedislikes = json['cubedislikes'];
    maximumplayers = json['maximumplayers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cubeuuid'] = this.cubeuuid;
    data['uid'] = this.uid;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['cubename'] = this.cubename;
    data['cubetype'] = FcubeType.toJson(this.cubetype);
    data['maketime'] = this.maketime;
    data['influence'] = this.influence;
    data['cubestate'] = FcubeState.toJson(this.cubestate);
    data['placeaddress'] = this.placeaddress;
    data['administrativearea'] = this.administrativearea;
    data['country'] = this.country;
    data['pointreward'] = this.pointreward;
    data['influencereward'] = this.influencereward;
    data['activationtime'] = this.activationtime;
    data['cubepassword'] = this.cubepassword;
    data['haspassword'] = this.haspassword;
    data['cubescope'] = this.cubescope;
    data['influencelevel'] = this.influencelevel;
    data['cubehits'] = this.cubehits;
    data['cubelikes'] = this.cubelikes;
    data['cubedislikes'] = this.cubedislikes;
    data['maximumplayers'] = this.maximumplayers;
    return data;
  }

  Future<int> makecube() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken();

    var url = Preference.httpurlbase(
        Preference.baseBackEndUrl, "/api/v1/Fcube/makecube");
    var response =
        await http.post(url, body: jsonEncode(this.toJson()), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + token.token
    });
    return int.tryParse(response.body);
  }

  Future<int> deletecube() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken();
    var url = Preference.httpurlbase(
        Preference.baseBackEndUrl, "/api/v1/Fcube/deletecube");
    var response =
        await http.post(url, body: jsonEncode(this.toJson()), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + token.token
    });
    return int.tryParse(response.body);
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

  Future<int> updateCubeState() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken();
    var url = Preference.httpurlbase(
        Preference.baseBackEndUrl, "/api/v1/Fcube/updateCubeState");
    var response =
        await http.post(url, body: jsonEncode(this.toJson()), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + token.token
    });
    return int.tryParse(response.body);
  }
}

class FcubeState {
  const FcubeState._(this.value);
  final int value;
  static const FcubeState startWait = FcubeState._(0);
  static const FcubeState play = FcubeState._(1);
  static const FcubeState finish = FcubeState._(2);

  static const List<FcubeState> values = <FcubeState>[startWait, play, finish];
  static const List<int> _names = <int>[0, 1, 2];
  static FcubeState fromJson(value) {
    return values[_names.indexOf(value)];
  }

  static int toJson(type) {
    return _names[type.value];
  }

  @override
  String toString() => "${_names[value]}";
}
