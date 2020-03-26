// To parse this JSON data, do
//
//     final pleyerjoincube = pleyerjoincubeFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/Common/PlayerjoincubeSearch.dart';
import 'package:forutonafront/MakePage/FcubeTypes.dart';
import 'package:forutonafront/Preference.dart';
import 'package:great_circle_distance2/great_circle_distance2.dart';

class Pleyerjoincube {
  String cubeuuid;
  String makerUid;
  double longitude;
  double latitude;
  String cubeName;
  FcubeType cubeType;
  DateTime makeTime;
  String placeAddress;
  double naPoint;
  double youPoint;
  double pointReward;
  double influenceReward;
  DateTime activationTime;
  int cubeHits;
  int cubeLikes;
  int cubeDisLikes;
  int commentCount;
  String playerUid;
  DateTime startTime;
  String contentType;
  String contentValue;
  double makerLevel;
  String makerProfilePicktureUrl;
  String makerNickName;
  double userExp;
  double distancewithme;

  Pleyerjoincube(
      {this.cubeuuid,
      this.makerUid,
      this.longitude,
      this.latitude,
      this.cubeName,
      this.cubeType,
      this.makeTime,
      this.placeAddress,
      this.naPoint,
      this.youPoint,
      this.pointReward,
      this.influenceReward,
      this.activationTime,
      this.cubeHits,
      this.cubeLikes,
      this.cubeDisLikes,
      this.commentCount,
      this.playerUid,
      this.startTime,
      this.contentType,
      this.contentValue,
      this.makerLevel,
      this.makerProfilePicktureUrl,
      this.makerNickName,
      this.userExp});

  Pleyerjoincube copyWith(
          {String cubeuuid,
          String makerUid,
          double longitude,
          double latitude,
          String cubeName,
          FcubeType cubeType,
          DateTime makeTime,
          String placeAddress,
          double naPoint,
          double youPoint,
          double pointReward,
          double influenceReward,
          DateTime activationTime,
          int cubeHits,
          int cubeLikes,
          int cubeDisLikes,
          int commentCount,
          String playerUid,
          DateTime startTime,
          String contentType,
          String contentValue,
          double makerLevel,
          String makerProfilePicktureUrl,
          String makerNickName,
          double userExp}) =>
      Pleyerjoincube(
        cubeuuid: cubeuuid ?? this.cubeuuid,
        makerUid: makerUid ?? this.makerUid,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
        cubeName: cubeName ?? this.cubeName,
        cubeType: cubeType ?? this.cubeType,
        makeTime: makeTime ?? this.makeTime,
        placeAddress: placeAddress ?? this.placeAddress,
        naPoint: naPoint ?? this.naPoint,
        youPoint: youPoint ?? this.youPoint,
        pointReward: pointReward ?? this.pointReward,
        influenceReward: influenceReward ?? this.influenceReward,
        activationTime: activationTime ?? this.activationTime,
        cubeHits: cubeHits ?? this.cubeHits,
        cubeLikes: cubeLikes ?? this.cubeLikes,
        cubeDisLikes: cubeDisLikes ?? this.cubeDisLikes,
        commentCount: commentCount ?? this.commentCount,
        playerUid: playerUid ?? this.playerUid,
        startTime: startTime ?? this.startTime,
        contentType: contentType ?? this.contentType,
        contentValue: contentValue ?? this.contentValue,
        makerLevel: makerLevel ?? this.makerLevel,
        makerProfilePicktureUrl:
            makerProfilePicktureUrl ?? this.makerProfilePicktureUrl,
        makerNickName: makerNickName ?? this.makerNickName,
        userExp: userExp ?? this.userExp,
      );

  factory Pleyerjoincube.fromRawJson(String str) =>
      Pleyerjoincube.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pleyerjoincube.fromJson(Map<String, dynamic> json) => Pleyerjoincube(
        cubeuuid: json["cubeuuid"] == null ? null : json["cubeuuid"],
        makerUid: json["makerUid"] == null ? null : json["makerUid"],
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        cubeName: json["cubeName"] == null ? null : json["cubeName"],
        cubeType: FcubeType.fromJson(json['cubeType']) == null
            ? null
            : FcubeType.fromJson(json['cubeType']),
        makeTime:
            json["makeTime"] == null ? null : DateTime.parse(json["makeTime"]),
        placeAddress:
            json["placeAddress"] == null ? null : json["placeAddress"],
        naPoint: json["naPoint"] == null ? null : json["naPoint"],
        youPoint: json["youPoint"] == null ? null : json["youPoint"],
        pointReward: json["pointReward"] == null ? null : json["pointReward"],
        influenceReward:
            json["influenceReward"] == null ? null : json["influenceReward"],
        activationTime: json["activationTime"] == null
            ? null
            : DateTime.parse(json["activationTime"]),
        cubeHits: json["cubeHits"] == null ? null : json["cubeHits"],
        cubeLikes: json["cubeLikes"] == null ? null : json["cubeLikes"],
        cubeDisLikes:
            json["cubeDisLikes"] == null ? null : json["cubeDisLikes"],
        commentCount:
            json["commentCount"] == null ? null : json["commentCount"],
        playerUid: json["playerUid"] == null ? null : json["playerUid"],
        startTime: json["startTime"] == null
            ? null
            : DateTime.parse(json["startTime"]),
        contentType: json["contentType"] == null ? null : json["contentType"],
        contentValue:
            json["contentValue"] == null ? null : json["contentValue"],
        makerLevel: json["makerLevel"] == null ? null : json["makerLevel"],
        makerProfilePicktureUrl: json["makerProfilePicktureUrl"] == null
            ? null
            : json["makerProfilePicktureUrl"],
        makerNickName:
            json["makerNickName"] == null ? null : json["makerNickName"],
        userExp: json["userExp"] == null ? null : json["userExp"],
      );

  Map<String, dynamic> toJson() => {
        "cubeuuid": cubeuuid == null ? null : cubeuuid,
        "makerUid": makerUid == null ? null : makerUid,
        "longitude": longitude == null ? null : longitude,
        "latitude": latitude == null ? null : latitude,
        "cubeName": cubeName == null ? null : cubeName,
        "cubeType": FcubeType.toJson(this.cubeType) == null
            ? null
            : FcubeType.toJson(this.cubeType),
        "makeTime": makeTime == null ? null : makeTime.toIso8601String(),
        "placeAddress": placeAddress == null ? null : placeAddress,
        "naPoint": naPoint == null ? null : naPoint,
        "youPoint": youPoint == null ? null : youPoint,
        "pointReward": pointReward == null ? null : pointReward,
        "influenceReward": influenceReward == null ? null : influenceReward,
        "activationTime":
            activationTime == null ? null : activationTime.toIso8601String(),
        "cubeHits": cubeHits == null ? null : cubeHits,
        "cubeLikes": cubeLikes == null ? null : cubeLikes,
        "cubeDisLikes": cubeDisLikes == null ? null : cubeDisLikes,
        "commentCount": commentCount == null ? null : commentCount,
        "playerUid": playerUid == null ? null : playerUid,
        "startTime": startTime == null ? null : startTime.toIso8601String(),
        "contentType": contentType == null ? null : contentType,
        "contentValue": contentValue == null ? null : contentValue,
        "makerLevel": makerLevel == null ? null : makerLevel,
        "makerProfilePicktureUrl":
            makerProfilePicktureUrl == null ? null : makerProfilePicktureUrl,
        "makerNickName": makerNickName == null ? null : makerNickName,
        "userExp": userExp == null ? null : userExp,
      };

  static Future<List<Pleyerjoincube>> getPlayerJoinCubeList(
      PlayerjoincubeSearch searchitem,
      double latitude,
      double longitude) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken();
    Dio dio = new Dio();

    Uri url = Preference.httpurloption(
        Preference.baseBackEndUrl, "/api/v1/Fcube/getPlayerJoinCubeList");
    Response response = await dio.get(url.toString(),
        queryParameters: searchitem.toJson(),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer " + token.token
        }));
    var reslut = List<Pleyerjoincube>.from(
        response.data.map((x) => Pleyerjoincube.fromJson(x)));

    reslut.forEach((item) {
      item.distancewithme = GreatCircleDistance.fromDegrees(
              latitude1: item.latitude,
              longitude1: item.longitude,
              latitude2: latitude,
              longitude2: longitude)
          .haversineDistance();
    });
    return reslut;
  }

  Duration remindActiveTimetoDuration() {
    DateTime activationtime = this.activationTime.add(Duration(hours: 9));

    Duration avtibetime = activationtime
        .difference(DateTime.now().toUtc().add(Duration(hours: 9)));
    return avtibetime;
  }
}
