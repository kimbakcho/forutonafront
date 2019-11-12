import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/Preference.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;

class Fcube {
  String cubeuuid;
  String uid;
  double longitude;
  double latitude;
  String cubename;
  String cubetype;
  String maketime;
  double influence;
  int cubestate;
  String placeaddress;
  String administrativearea;
  String country;

  Fcube(
      {this.cubeuuid,
      this.uid,
      this.longitude,
      this.latitude,
      this.cubename,
      this.cubetype,
      this.maketime,
      this.influence,
      this.cubestate,
      this.placeaddress,
      this.administrativearea,
      this.country});

  Fcube.fromJson(Map<String, dynamic> json) {
    cubeuuid = json['cubeuuid'];
    uid = json['uid'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    cubename = json['cubename'];
    cubetype = json['cubetype'];
    maketime = json['maketime'];
    influence = json['influence'];
    cubestate = json['cubestate'];
    placeaddress = json['placeaddress'];
    administrativearea = json['administrativearea'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cubeuuid'] = this.cubeuuid;
    data['uid'] = this.uid;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['cubename'] = this.cubename;
    data['cubetype'] = this.cubetype;
    data['maketime'] = this.maketime;
    data['influence'] = this.influence;
    data['cubestate'] = this.cubestate;
    data['placeaddress'] = this.placeaddress;
    data['administrativearea'] = this.administrativearea;
    data['country'] = this.country;
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
}
