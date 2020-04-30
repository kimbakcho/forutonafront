// To parse this JSON data, do
//
//     final fcubeReview = fcubeReviewFromJson(jsonString);
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/Preference.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class FcubeReview {
  int idx;
  String cubeuuid;
  String uid;
  String tomakercomment;
  double starpoint;

  FcubeReview({
    this.idx,
    this.cubeuuid,
    this.uid,
    this.tomakercomment,
    this.starpoint,
  });

  FcubeReview copyWith({
    int idx,
    String cubeuuid,
    String uid,
    String tomakercomment,
    double starpoint,
  }) =>
      FcubeReview(
        idx: idx ?? this.idx,
        cubeuuid: cubeuuid ?? this.cubeuuid,
        uid: uid ?? this.uid,
        tomakercomment: tomakercomment ?? this.tomakercomment,
        starpoint: starpoint ?? this.starpoint,
      );

  factory FcubeReview.fromRawJson(String str) =>
      FcubeReview.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FcubeReview.fromJson(Map<String, dynamic> json) => FcubeReview(
        idx: json["idx"] == null ? null : json["idx"],
        cubeuuid: json["cubeuuid"] == null ? null : json["cubeuuid"],
        uid: json["uid"] == null ? null : json["uid"],
        tomakercomment:
            json["tomakercomment"] == null ? null : json["tomakercomment"],
        starpoint: json["starpoint"] == null ? null : json["starpoint"],
      );

  Map<String, dynamic> toJson() => {
        "idx": idx == null ? null : idx,
        "cubeuuid": cubeuuid == null ? null : cubeuuid,
        "uid": uid == null ? null : uid,
        "tomakercomment": tomakercomment == null ? null : tomakercomment,
        "starpoint": starpoint == null ? null : starpoint,
      };

  static Future<List<FcubeReview>> getFcubeReviews(
      String cubeuuid, String uid) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken(refresh: true);
    var geturl = Preference.httpurloption(Preference.baseBackEndUrl,
        "/api/v1/Fcube/getFcubeReview", {"cubeuuid": cubeuuid, "uid": uid});
    var response = await http.get(geturl, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + token.token
    });
    return List<FcubeReview>.from(
        json.decode(response.body).map((x) => FcubeReview.fromJson(x)));
  }

  Future<int> insertFcubeReview() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken(refresh: true);
    var posturl = Preference.httpurlbase(
        Preference.baseBackEndUrl, "/api/v1/Fcube/insertFcubeReview");
    var response = await http.post(posturl, body: toRawJson(), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + token.token
    });
    return int.tryParse(response.body);
  }

  Future<int> insertFcubeReviewExpPoint() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken(refresh: true);
    var posturl = Preference.httpurlbase(
        Preference.baseBackEndUrl, "/api/v1/Fcube/insertFcubeReviewExpPoint");
    var response = await http.post(posturl, body: toRawJson(), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + token.token
    });
    return int.tryParse(response.body);
  }
}
