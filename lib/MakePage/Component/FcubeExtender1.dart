import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/Common/FCubeGeoSearchUtil.dart';
import 'package:forutonafront/MakePage/Component/Fcube.dart';
import 'package:forutonafront/MakePage/FcubeTypes.dart';
import 'package:forutonafront/MakePage/Fcubecontent.dart';
import 'package:forutonafront/Preference.dart';
import 'package:http/http.dart' as http;

class FcubeExtender1 extends Fcube {
  String nickname;
  String profilepicktureurl;
  double distancewithme = 0;
  FcubecontentType contenttype;
  String contentvalue;
  DateTime positionupdatetime;
  double userlevel;
  String fcmtoken;

  FcubeExtender1();

  FcubeExtender1.fromJson(Map<String, dynamic> json) {
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
    nickname = json['nickname'];
    profilepicktureurl = json['profilepicktureurl'];
    activationtime = DateTime.parse(json['activationtime']);
    cubepassword = json['cubepassword'];
    haspassword = json['haspassword'];
    cubescope = json['cubescope'];
    influencelevel = json['influencelevel'];
    cubehits = json['cubehits'];
    cubelikes = json['cubelikes'];
    cubedislikes = json['cubedislikes'];
    joinplayer = json['joinplayer'];
    maximumplayers = json['maximumplayers'];
    starpoints = json['starpoints'];
    contenttype = json['contenttype'] == null
        ? null
        : FcubecontentType.fromJson(json['contenttype']);
    contentvalue = json['contentvalue'] == null ? null : json['contentvalue'];
    positionupdatetime = json['positionupdatetime'] != null
        ? DateTime.parse(json['positionupdatetime'])
        : null;
    userlevel = json['userlevel'];
    fcmtoken = json['fcmtoken'];
    makeexp = json['makeexp'];
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
    data['nickname'] = this.nickname;
    data['profilepicktureurl'] = this.profilepicktureurl;
    data['activationtime'] =
        activationtime != null ? activationtime.toIso8601String() : null;
    data['cubepassword'] = this.cubepassword;
    data['haspassword'] = this.haspassword;
    data['cubescope'] = this.cubescope;
    data['influencelevel'] = this.influencelevel;
    data['cubehits'] = this.cubehits;
    data['cubelikes'] = this.cubelikes;
    data['cubedislikes'] = this.cubedislikes;
    data['joinplayer'] = this.joinplayer;
    data['maximumplayers'] = this.maximumplayers;
    data['starpoints'] = this.starpoints;
    data['contenttype'] = this.contenttype == null
        ? null
        : FcubecontentType.toJson(this.contenttype);
    data['contentvalue'] = this.contentvalue == null ? null : this.contentvalue;
    data['positionupdatetime'] = positionupdatetime != null
        ? positionupdatetime.toIso8601String()
        : null;
    data['userlevel'] = this.userlevel;
    data['fcmtoken'] = this.fcmtoken;
    data['makeexp'] = this.makeexp;
    return data;
  }

  static Future<List<FcubeExtender1>> getusercubes(
      {int offset, int limit}) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken();
    var url = Preference.httpurloption(Preference.baseBackEndUrl,
        "/api/v1/Fcube/getusercubes", {"offset": "$offset", "limit": "$limit"});
    var response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: "Bearer " + token.token});
    // print(response.body);
    var recvjson = jsonDecode(response.body);
    List<FcubeExtender1> list = new List<FcubeExtender1>();
    recvjson.forEach((v) {
      list.add(new FcubeExtender1.fromJson(v));
    });
    return list;
  }

  static Future<FcubeExtender1> getFcubeExtender1(
      String uid, String cubeuuid) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken();
    var url = Preference.httpurloption(Preference.baseBackEndUrl,
        "/api/v1/Fcube/getFcubeExtender1", {"uid": uid, "cubeuuid": cubeuuid});
    var response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: "Bearer " + token.token});
    return FcubeExtender1.fromJson(json.decode(response.body));
  }

  static Future<List<FcubeExtender1>> findNearDistanceCube(
      FCubeGeoSearchUtil searchitem) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken();
    var url = Preference.httpurlbase(
        Preference.baseBackEndUrl, "/api/v1/Fcube/findNearDistanceCube");
    var response =
        await http.post(url, body: json.encode(searchitem.toJson()), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + token.token
    });
    return List<FcubeExtender1>.from(
        json.decode(response.body).map((x) => FcubeExtender1.fromJson(x)));
  }
}
