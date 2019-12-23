import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:forutonafront/Preference.dart';

Fcubeplayer fcubeplayerFromJson(String str) =>
    Fcubeplayer.fromJson(json.decode(str));

String fcubeplayerToJson(Fcubeplayer data) => json.encode(data.toJson());

enum FcubeplayerState { wait, playing ,finish }

class Fcubeplayer {
  int idx;
  String cubeuuid;
  String uid;
  int haslike;
  int hasdislike;
  int hasgiveup;
  int hasexit;
  DateTime starttime;
  FcubeplayerState playstate;

  Fcubeplayer(
      {this.idx,
      this.cubeuuid,
      this.uid,
      this.haslike,
      this.hasdislike,
      this.hasgiveup,
      this.hasexit,
      this.starttime,
      this.playstate});

  factory Fcubeplayer.fromJson(Map<String, dynamic> json) => Fcubeplayer(
        idx: json["idx"],
        cubeuuid: json["cubeuuid"],
        uid: json["Uid"],
        haslike: json["haslike"],
        hasdislike: json["hasdislike"],
        hasgiveup: json["hasgiveup"],
        hasexit: json["hasexit"],
        starttime: DateTime.parse(json["starttime"]),
        playstate: json["playstate"],
      );

  Map<String, dynamic> toJson() => {
        "idx": idx,
        "cubeuuid": cubeuuid,
        "uid": uid,
        "haslike": haslike,
        "hasdislike": hasdislike,
        "hasgiveup": hasgiveup,
        "hasexit": hasexit,
        "starttime": starttime == null ? null : starttime.toIso8601String(),
        "playstate": playstate.index,
      };

  Future<int> insertFcubePlayer() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken();
    var url = Preference.httpurlbase(
        Preference.baseBackEndUrl, "/api/v1/Fcube/insertFcubePlayer");
    var response =
        await http.post(url, body: json.encode(this.toJson()), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + token.token
    });
    return int.tryParse(response.body);
  }

  
}
