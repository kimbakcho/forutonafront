// To parse this JSON data, do
//
//     final fcubetagextender1 = fcubetagextender1FromJson(jsonString);

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/Common/FcubeDescription.dart';
import 'package:forutonafront/Common/FcubeTagSearch.dart';
import 'package:forutonafront/Common/Fcubetag.dart';
import 'package:forutonafront/MakePage/Component/Fcube.dart';
import 'package:forutonafront/MakePage/FcubeTypes.dart';
import 'package:forutonafront/Preference.dart';

class Fcubetagextender1 extends Fcubetag {
  String cubeuuid;
  String tagitem;
  String uid;
  double longitude;
  double latitude;
  String cubeName;
  FcubeType cubeType;
  DateTime makeTime;
  FcubeState cubeState;
  double influence;
  String placeAddress;
  dynamic administrativeArea;
  dynamic country;
  DateTime activationTime;
  int cubeHits;
  int cubeLikes;
  int cubeDisLikes;
  int commentCount;
  String contentValue;
  FcubeDescription description;
  double distancewithme;

  Fcubetagextender1({
    this.cubeuuid,
    this.tagitem,
    this.uid,
    this.longitude,
    this.latitude,
    this.cubeName,
    this.cubeType,
    this.makeTime,
    this.cubeState,
    this.influence,
    this.placeAddress,
    this.administrativeArea,
    this.country,
    this.activationTime,
    this.cubeHits,
    this.cubeLikes,
    this.cubeDisLikes,
    this.commentCount,
    this.contentValue,
  });

  Fcubetagextender1 copyWith({
    String cubeuuid,
    String tagitem,
    String uid,
    double longitude,
    double latitude,
    String cubeName,
    FcubeType cubeType,
    DateTime makeTime,
    FcubeState cubeState,
    double influence,
    String placeAddress,
    dynamic administrativeArea,
    dynamic country,
    DateTime activationTime,
    int cubeHits,
    int cubeLikes,
    int cubeDisLikes,
    int commentCount,
    String contentValue,
  }) =>
      Fcubetagextender1(
        cubeuuid: cubeuuid ?? this.cubeuuid,
        tagitem: tagitem ?? this.tagitem,
        uid: uid ?? this.uid,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
        cubeName: cubeName ?? this.cubeName,
        cubeType: cubeType ?? this.cubeType,
        makeTime: makeTime ?? this.makeTime,
        cubeState: cubeState ?? this.cubeState,
        influence: influence ?? this.influence,
        placeAddress: placeAddress ?? this.placeAddress,
        administrativeArea: administrativeArea ?? this.administrativeArea,
        country: country ?? this.country,
        activationTime: activationTime ?? this.activationTime,
        cubeHits: cubeHits ?? this.cubeHits,
        cubeLikes: cubeLikes ?? this.cubeLikes,
        cubeDisLikes: cubeDisLikes ?? this.cubeDisLikes,
        commentCount: commentCount ?? this.commentCount,
        contentValue: contentValue ?? this.contentValue,
      );

  factory Fcubetagextender1.fromRawJson(String str) =>
      Fcubetagextender1.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Fcubetagextender1.fromJson(Map<String, dynamic> json) =>
      Fcubetagextender1(
        cubeuuid: json["cubeuuid"] == null ? null : json["cubeuuid"],
        tagitem: json["tagitem"] == null ? null : json["tagitem"],
        uid: json["uid"] == null ? null : json["uid"],
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        cubeName: json["cubeName"] == null ? null : json["cubeName"],
        cubeType: json['cubeType'] == null
            ? null
            : FcubeType.fromJson(json['cubeType']),
        makeTime:
            json["makeTime"] == null ? null : DateTime.parse(json["makeTime"]),
        cubeState: json["cubeState"] == null
            ? null
            : FcubeState.fromJson(json['cubeState']),
        influence: json["influence"] == null ? null : json["influence"],
        placeAddress:
            json["placeAddress"] == null ? null : json["placeAddress"],
        administrativeArea: json["administrativeArea"],
        country: json["country"],
        activationTime: json["activationTime"] == null
            ? null
            : DateTime.parse(json["activationTime"]),
        cubeHits: json["cubeHits"] == null ? null : json["cubeHits"],
        cubeLikes: json["cubeLikes"] == null ? null : json["cubeLikes"],
        cubeDisLikes:
            json["cubeDisLikes"] == null ? null : json["cubeDisLikes"],
        commentCount:
            json["commentCount"] == null ? null : json["commentCount"],
        contentValue:
            json["contentValue"] == null ? null : json["contentValue"],
      );

  Map<String, dynamic> toJson() => {
        "cubeuuid": cubeuuid == null ? null : cubeuuid,
        "tagitem": tagitem == null ? null : tagitem,
        "uid": uid == null ? null : uid,
        "longitude": longitude == null ? null : longitude,
        "latitude": latitude == null ? null : latitude,
        "cubeName": cubeName == null ? null : cubeName,
        "cubeType": cubeType == null ? null : FcubeType.toJson(cubeType),
        "makeTime": makeTime == null ? null : makeTime.toIso8601String(),
        "cubeState": cubeState == null ? null : FcubeType.toJson(cubeState),
        "influence": influence == null ? null : influence,
        "placeAddress": placeAddress == null ? null : placeAddress,
        "administrativeArea": administrativeArea,
        "country": country,
        "activationTime":
            activationTime == null ? null : activationTime.toIso8601String(),
        "cubeHits": cubeHits == null ? null : cubeHits,
        "cubeLikes": cubeLikes == null ? null : cubeLikes,
        "cubeDisLikes": cubeDisLikes == null ? null : cubeDisLikes,
        "commentCount": commentCount == null ? null : commentCount,
        "contentValue": contentValue == null ? null : contentValue,
      };
  static Future<List<Fcubetagextender1>> getFcubetagSearch(
      FcubetagSearch search) async {
    Dio dio = new Dio();
    Uri url = Preference.httpurlbase(
        Preference.baseBackEndUrl, "/api/v1/Fcube/getFcubetagSearch");
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken(refresh: true);
    Response response = await dio.get(url.toString(),
        queryParameters: search.toJson(),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer " + token.token
        }));
    return List<Fcubetagextender1>.from(response.data.map((x) {
      Fcubetagextender1 temp = Fcubetagextender1.fromJson(x);
      temp.description = FcubeDescription.fromRawJson(temp.contentValue);

      return temp;
    }));
  }
}
