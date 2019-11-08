import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/Preference.dart';
import 'package:http/http.dart' as http;

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

  Future<int> makebox() async {
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

  static Future<List<Fcube>> getusercubes({int offset, int limit}) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken();
    var url = Preference.httpurloption(Preference.baseBackEndUrl,
        "/api/v1/Fcube/getusercubes", {"offset": "$offset", "limit": "$limit"});
    var response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: "Bearer " + token.token});
    var recvjson = jsonDecode(response.body);
    List<Fcube> list = new List<Fcube>();
    recvjson.forEach((v) {
      list.add(new Fcube.fromJson(v));
    });
    return list;
  }
}
