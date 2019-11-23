import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/Preference.dart';
import 'package:http/http.dart' as http;

Fcubereply fcubereplyFromJson(String str) =>
    Fcubereply.fromJson(json.decode(str));

String fcubereplyToJson(Fcubereply data) => json.encode(data.toJson());

class Fcubereply {
  int commntno;
  String cubeuuid;
  String uid;
  int bgroup;
  int sorts;
  int depth;
  String commnttext;
  DateTime commnttime;

  Fcubereply({
    this.commntno,
    this.cubeuuid,
    this.uid,
    this.bgroup,
    this.sorts,
    this.depth,
    this.commnttext,
    this.commnttime,
  });

  factory Fcubereply.fromJson(Map<String, dynamic> json) => Fcubereply(
        commntno: json["commntno"],
        cubeuuid: json["cubeuuid"],
        uid: json["uid"],
        sorts: json["sorts"],
        bgroup: json["bgroup"],
        depth: json["depth"],
        commnttext: json["commnttext"],
        commnttime: DateTime.parse(json["commnttime"]),
      );

  Map<String, dynamic> toJson() => {
        "commntno": commntno,
        "cubeuuid": cubeuuid,
        "uid": uid,
        "bgroup": bgroup,
        "sorts": sorts,
        "depth": depth,
        "commnttext": commnttext,
        "commnttime": commnttime.toIso8601String(),
      };

  Future<Fcubereply> makereply() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken();
    Uri url = Preference.httpurlbase(
        Preference.baseBackEndUrl, "/api/v1/Fcube/InsertCubeReply");
    var response = await http.post(url,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer " + token.token,
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: json.encode(this.toJson()));

    return Fcubereply.fromJson(json.decode(response.body));
  }
}
