// To parse this JSON data, do
//
//     final fcubeSponsor = fcubeSponsorFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/Common/FcubeSponsorSearch.dart';
import 'package:forutonafront/Preference.dart';

class FcubeSponsor {
  int idx;
  String cubeuuid;
  String uid;
  String comment;
  DateTime sendTime;
  String pointType;
  int pointValue;

  FcubeSponsor({
    this.idx,
    this.cubeuuid,
    this.uid,
    this.comment,
    this.sendTime,
    this.pointType,
    this.pointValue,
  });

  FcubeSponsor copyWith({
    int idx,
    String cubeuuid,
    String uid,
    String comment,
    DateTime sendTime,
    String pointType,
    int pointValue,
  }) =>
      FcubeSponsor(
        idx: idx ?? this.idx,
        cubeuuid: cubeuuid ?? this.cubeuuid,
        uid: uid ?? this.uid,
        comment: comment ?? this.comment,
        sendTime: sendTime ?? this.sendTime,
        pointType: pointType ?? this.pointType,
        pointValue: pointValue ?? this.pointValue,
      );

  factory FcubeSponsor.fromRawJson(String str) =>
      FcubeSponsor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FcubeSponsor.fromJson(Map<String, dynamic> json) => FcubeSponsor(
        idx: json["idx"] == null ? null : json["idx"],
        cubeuuid: json["cubeuuid"] == null ? null : json["cubeuuid"],
        uid: json["uid"] == null ? null : json["uid"],
        comment: json["comment"] == null ? null : json["comment"],
        sendTime:
            json["sendTime"] == null ? null : DateTime.parse(json["sendTime"]),
        pointType: json["pointType"] == null ? null : json["pointType"],
        pointValue: json["pointValue"] == null ? null : json["pointValue"],
      );

  Map<String, dynamic> toJson() => {
        "idx": idx == null ? null : idx,
        "cubeuuid": cubeuuid == null ? null : cubeuuid,
        "uid": uid == null ? null : uid,
        "comment": comment == null ? null : comment,
        "sendTime": sendTime == null ? null : sendTime.toIso8601String(),
        "pointType": pointType == null ? null : pointType,
        "pointValue": pointValue == null ? null : pointValue,
      };
  static Future<int> getCubeSponsorSumPointValue(
      FcubeSponsorSearch search) async {
    Dio dio = new Dio();
    Uri url = Preference.httpurlbase(
        Preference.baseBackEndUrl, "/api/v1/Fcube/getCubeSponsorSumPointValue");
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken(refresh: true);
    Response response = await dio.get(url.toString(),
        queryParameters: search.toJson(),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer " + token.token
        }));
    return int.tryParse(response.data);
  }

  static Future<int> getCubeSponsorCount(FcubeSponsorSearch search) async {
    Dio dio = new Dio();
    Uri url = Preference.httpurlbase(
        Preference.baseBackEndUrl, "/api/v1/Fcube/getCubeSponsorCount");
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken(refresh: true);

    Response response = await dio.get(url.toString(),
        queryParameters: search.toJson(),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer " + token.token
        }));
    return int.tryParse(response.data);
  }
}
