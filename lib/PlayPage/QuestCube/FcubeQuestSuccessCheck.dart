import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/Preference.dart';
import 'package:http/http.dart' as http;

class FcubeQuestSuccessCheck {
  int idx;
  String cubeuuid;
  String uid;
  String fromuid;
  String readuid;
  int confirm;

  FcubeQuestSuccessCheck(
      {this.idx,
      this.cubeuuid,
      this.uid,
      this.fromuid,
      this.readuid,
      this.confirm});

  FcubeQuestSuccessCheck copyWith(
          {int idx,
          String cubeuuid,
          String uid,
          String fromuid,
          String readuid,
          int confirm,
          String tomakercomment,
          double starpoint}) =>
      FcubeQuestSuccessCheck(
          idx: idx ?? this.idx,
          cubeuuid: cubeuuid ?? this.cubeuuid,
          uid: uid ?? this.uid,
          fromuid: fromuid ?? this.fromuid,
          readuid: readuid ?? this.readuid,
          confirm: confirm ?? this.confirm);

  factory FcubeQuestSuccessCheck.fromRawJson(String str) =>
      FcubeQuestSuccessCheck.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FcubeQuestSuccessCheck.fromJson(Map<String, dynamic> json) =>
      FcubeQuestSuccessCheck(
        idx: json["idx"] == null ? null : json["idx"],
        cubeuuid: json["cubeuuid"] == null ? null : json["cubeuuid"],
        uid: json["uid"] == null ? null : json["uid"],
        fromuid: json["fromuid"] == null ? null : json["fromuid"],
        readuid: json["readuid"] == null ? null : json["readuid"],
        confirm: json["confirm"] == null ? null : json["confirm"],
      );

  Map<String, dynamic> toJson() => {
        "idx": idx == null ? null : idx,
        "cubeuuid": cubeuuid == null ? null : cubeuuid,
        "uid": uid == null ? null : uid,
        "fromuid": fromuid == null ? null : fromuid,
        "readuid": readuid == null ? null : readuid,
        "confirm": confirm == null ? null : confirm
      };
  Future<int> insertFcubeQuestSuccessCheck() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken();
    var url = Preference.httpurlbase(Preference.baseBackEndUrl,
        "/api/v1/Fcube/insertFcubeQuestSuccessCheck");
    var response = await http.post(url, body: toRawJson(), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + token.token
    });
    return int.tryParse(response.body);
  }

  Future<int> updatetoMakerComment() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken();
    var url = Preference.httpurlbase(
        Preference.baseBackEndUrl, "/api/v1/Fcube/updatetoMakerComment");
    var response = await http.post(url, body: toRawJson(), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + token.token
    });
    return int.tryParse(response.body);
  }
}
