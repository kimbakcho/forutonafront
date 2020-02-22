// To parse this JSON data, do
//
//     final fcubeSponsorExtender1 = fcubeSponsorExtender1FromJson(jsonString);

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/Common/FcubeSponsor.dart';
import 'package:forutonafront/Common/FcubeSponsorSearch.dart';
import 'package:forutonafront/Preference.dart';

class FcubeSponsorExtender1 extends FcubeSponsor {
  String cubeuuid;
  String uid;
  String comment;
  DateTime sendTime;
  String pointType;
  int pointValue;
  String nickName;
  String profilePicktureUrl;
  int userLevel;

  FcubeSponsorExtender1({
    this.cubeuuid,
    this.uid,
    this.comment,
    this.sendTime,
    this.pointType,
    this.pointValue,
    this.nickName,
    this.profilePicktureUrl,
    this.userLevel,
  });

  FcubeSponsorExtender1 copyWithExtender({
    String cubeuuid,
    String uid,
    String comment,
    DateTime sendTime,
    String pointType,
    int pointValue,
    String nickName,
    String profilePicktureUrl,
    int userLevel,
  }) =>
      FcubeSponsorExtender1(
        cubeuuid: cubeuuid ?? this.cubeuuid,
        uid: uid ?? this.uid,
        comment: comment ?? this.comment,
        sendTime: sendTime ?? this.sendTime,
        pointType: pointType ?? this.pointType,
        pointValue: pointValue ?? this.pointValue,
        nickName: nickName ?? this.nickName,
        profilePicktureUrl: profilePicktureUrl ?? this.profilePicktureUrl,
        userLevel: userLevel ?? this.userLevel,
      );

  factory FcubeSponsorExtender1.fromRawJson(String str) =>
      FcubeSponsorExtender1.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FcubeSponsorExtender1.fromJson(Map<String, dynamic> json) =>
      FcubeSponsorExtender1(
        cubeuuid: json["cubeuuid"] == null ? null : json["cubeuuid"],
        uid: json["uid"] == null ? null : json["uid"],
        comment: json["comment"] == null ? null : json["comment"],
        sendTime:
            json["sendTime"] == null ? null : DateTime.parse(json["sendTime"]),
        pointType: json["pointType"] == null ? null : json["pointType"],
        pointValue: json["pointValue"] == null ? null : json["pointValue"],
        nickName: json["nickName"] == null ? null : json["nickName"],
        profilePicktureUrl: json["profilePicktureUrl"] == null
            ? null
            : json["profilePicktureUrl"],
        userLevel: json["UserLevel"] == null ? null : json["UserLevel"],
      );

  Map<String, dynamic> toJson() => {
        "cubeuuid": cubeuuid == null ? null : cubeuuid,
        "uid": uid == null ? null : uid,
        "comment": comment == null ? null : comment,
        "sendTime": sendTime == null ? null : sendTime.toIso8601String(),
        "pointType": pointType == null ? null : pointType,
        "pointValue": pointValue == null ? null : pointValue,
        "nickName": nickName == null ? null : nickName,
        "profilePicktureUrl":
            profilePicktureUrl == null ? null : profilePicktureUrl,
        "UserLevel": userLevel == null ? null : userLevel,
      };

  static Future<List<FcubeSponsorExtender1>> getSponsorForCubeuuid(
      FcubeSponsorSearch search) async {
    Dio dio = new Dio();
    Uri url = Preference.httpurlbase(
        Preference.baseBackEndUrl, "/api/v1/Fcube/getSponsorForCubeuuid");
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken();
    Response response = await dio.get(url.toString(),
        queryParameters: search.toJson(),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer " + token.token
        }));
    return List<FcubeSponsorExtender1>.from(
        response.data.map((x) => FcubeSponsorExtender1.fromJson(x)));
  }
}
