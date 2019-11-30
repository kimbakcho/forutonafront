import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/Common/Fcubeplayer.dart';
import 'package:forutonafront/Preference.dart';

import 'package:http/http.dart' as http;

class FcubeplayerExtender1 extends Fcubeplayer {
  String nickname;
  String profilepicktureurl;
  double latitude;
  double longitude;

  FcubeplayerExtender1.fromFcubeplayer(Fcubeplayer fcubeplayer,
      {this.nickname, this.profilepicktureurl}) {
    idx = fcubeplayer.idx;
    cubeuuid = fcubeplayer.cubeuuid;
    uid = fcubeplayer.uid;
    haslike = fcubeplayer.haslike;
    hasdislike = fcubeplayer.hasdislike;
    hasgiveup = fcubeplayer.hasgiveup;
    hasexit = fcubeplayer.hasexit;
    starttime = fcubeplayer.starttime;
    playstate = fcubeplayer.playstate;
  }

  FcubeplayerExtender1.fromJson(Map<String, dynamic> json) {
    idx = json["idx"];
    cubeuuid = json["cubeuuid"];
    uid = json["uid"];
    nickname = json["nickname"];
    profilepicktureurl = json["profilepicktureurl"];
    haslike = json["haslike"];
    hasdislike = json["hasdislike"];
    hasgiveup = json["hasgiveup"];
    hasexit = json["hasexit"];
    latitude = json["latitude"];
    longitude = json["longitude"];
    starttime = DateTime.parse(json["starttime"]);
    playstate = FcubeplayerState.values[json["playstate"]];
  }
  Map<String, dynamic> toJson() => {
        "idx": idx,
        "cubeuuid": cubeuuid,
        "uid": uid,
        "nickname": nickname,
        "profilepicktureurl": profilepicktureurl,
        "haslike": haslike,
        "hasdislike": hasdislike,
        "hasgiveup": hasgiveup,
        "hasgiveup": hasgiveup,
        "latitude": latitude,
        "longitude": longitude,
        "starttime": starttime.toIso8601String(),
        "playstate": playstate,
      };

  static Future<List<FcubeplayerExtender1>> selectPlayers(
      Fcubeplayer player) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken();
    var queryParameters = {"cubeuuid": player.cubeuuid, "uid": player.uid};
    Uri uri = Preference.httpurloption(Preference.baseBackEndUrl,
        "/api/v1/Fcube/SelectPlayers", queryParameters);
    var response = await http.get(uri,
        headers: {HttpHeaders.authorizationHeader: "Bearer " + token.token});

    return List<FcubeplayerExtender1>.from(json
        .decode(response.body)
        .map((x) => FcubeplayerExtender1.fromJson(x)));
  }
}
