import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/Common/FcubereplySearch.dart';
import 'package:forutonafront/Preference.dart';
import 'package:http/http.dart' as http;

Fcubereply fcubereplyFromJson(String str) =>
    Fcubereply.fromJson(json.decode(str));

String fcubereplyToJson(Fcubereply data) => json.encode(data.toJson());

class Fcubereply {
  int commentno;
  String cubeuuid;
  String uid;
  int bgroup;
  int sorts;
  int depth;
  String commenttext;
  DateTime commenttime;

  Fcubereply({
    this.commentno,
    this.cubeuuid,
    this.uid,
    this.bgroup,
    this.sorts,
    this.depth,
    this.commenttext,
    this.commenttime,
  });

  factory Fcubereply.fromJson(Map<String, dynamic> json) => Fcubereply(
        commentno: json["commentno"],
        cubeuuid: json["cubeuuid"],
        uid: json["uid"],
        sorts: json["sorts"],
        bgroup: json["bgroup"],
        depth: json["depth"],
        commenttext: json["commenttext"],
        commenttime: DateTime.parse(json["commenttime"]),
      );

  Map<String, dynamic> toJson() => {
        "commentno": commentno,
        "cubeuuid": cubeuuid,
        "uid": uid,
        "bgroup": bgroup,
        "sorts": sorts,
        "depth": depth,
        "commenttext": commenttext,
        "commenttime": commenttime.toIso8601String(),
      };

  Future<Fcubereply> makereply() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    this.uid = user.uid;
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

  static Future<int> getReplyCount(FcubereplySearch serach) async {
    Dio dio = new Dio();
    Uri url = Preference.httpurlbase(
        Preference.baseBackEndUrl, "/api/v1/Fcube/getReplyCount");
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken();

    Response response = await dio.get(url.toString(),
        queryParameters: serach.toJson(),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer " + token.token
        }));
    return int.tryParse(response.data);
  }
}
