import 'dart:convert';
import 'dart:io';

import 'package:forutonafront/Common/Fcubeplayer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/Common/FcubeplayerSearch.dart';
import 'package:forutonafront/MakePage/FcubeTypes.dart';
import 'package:forutonafront/Preference.dart';
import 'package:http/http.dart' as http;

class FcubeplayerExtender2 extends Fcubeplayer {
  double latitude;
  double longitude;
  String cubename;
  FcubeType cubetype;
  String makeruid;
  String makernickname;
  String makerprofilepicktureurl;

  FcubeplayerExtender2(
      {int idx,
      String cubeuuid,
      String uid,
      int haslike,
      int hasdislike,
      int hasgiveup,
      int hasexit,
      DateTime starttime,
      FcubeplayerState playstate,
      this.cubename,
      this.cubetype,
      this.makeruid,
      this.makernickname,
      this.makerprofilepicktureurl,
      this.latitude,
      this.longitude})
      : super(
            idx: idx,
            cubeuuid: cubeuuid,
            haslike: haslike,
            hasdislike: hasdislike,
            hasgiveup: hasgiveup,
            hasexit: hasexit,
            starttime: starttime,
            playstate: playstate);

  factory FcubeplayerExtender2.fromRawJson(String str) =>
      FcubeplayerExtender2.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FcubeplayerExtender2.fromJson(Map<String, dynamic> json) =>
      FcubeplayerExtender2(
        cubeuuid: json["cubeuuid"] == null ? null : json["cubeuuid"],
        uid: json["uid"] == null ? null : json["uid"],
        haslike: json["haslike"],
        hasdislike: json["hasdislike"],
        hasgiveup: json["hasgiveup"],
        hasexit: json["hasexit"],
        starttime: json["starttime"] == null
            ? null
            : DateTime.parse(json["starttime"]),
        playstate: FcubeplayerState.values[json["playstate"]],
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        makeruid: json["makeruid"] == null ? null : json["makeruid"],
        cubename: json["cubename"] == null ? null : json["cubename"],
        cubetype: FcubeType.fromJson(json['cubetype']),
        makernickname:
            json["makernickname"] == null ? null : json["makernickname"],
        makerprofilepicktureurl: json["makerprofilepicktureurl"] == null
            ? null
            : json["makerprofilepicktureurl"],
      );

  Map<String, dynamic> toJson() => {
        "cubeuuid": cubeuuid == null ? null : cubeuuid,
        "uid": uid == null ? null : uid,
        "haslike": haslike,
        "hasdislike": hasdislike,
        "hasgiveup": hasgiveup,
        "hasexit": hasexit,
        "starttime": starttime == null ? null : starttime.toIso8601String(),
        "playstate": playstate == null ? null : playstate,
        "longitude": longitude == null ? null : longitude,
        "latitude": latitude == null ? null : latitude,
        "cubename": cubename == null ? null : cubename,
        'cubetype': FcubeType.toJson(this.cubetype),
        "makeruid": makeruid == null ? null : makeruid,
        "makernickname": makernickname == null ? null : makernickname,
        "makerprofilepicktureurl":
            makerprofilepicktureurl == null ? null : makerprofilepicktureurl,
      };

  static Future<List<FcubeplayerExtender2>> getPlayerJoinList(
      FcubeplayerSearch item) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken();
    var geturl = Preference.httpurloption(
        Preference.baseBackEndUrl, "/api/v1/Fcube/getPlayerJoinList", {
      "uid": item.uid,
      "offset": item.offset.toString(),
      "limit": item.limit.toString()
    });
    var response = await http.get(geturl, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + token.token
    });
    return List<FcubeplayerExtender2>.from(json
        .decode(response.body)
        .map((x) => FcubeplayerExtender2.fromJson(x)));
  }
}
