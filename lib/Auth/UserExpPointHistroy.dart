import 'dart:convert';

import 'package:forutonafront/Preference.dart';
import 'package:http/http.dart' as http;

class UserExpPointHistroy {
  int idx;
  String uid;
  String fromuid;
  String cubeuuid;
  int points;
  String explains;
  DateTime gettime;
  int deleteaction;

  UserExpPointHistroy({
    this.idx,
    this.uid,
    this.fromuid,
    this.cubeuuid,
    this.points,
    this.explains,
    this.gettime,
    this.deleteaction,
  });

  UserExpPointHistroy copyWith({
    int idx,
    String uid,
    String fromuid,
    String cubeuuid,
    int points,
    String explains,
    DateTime gettime,
    int deleteaction,
  }) =>
      UserExpPointHistroy(
        idx: idx ?? this.idx,
        uid: uid ?? this.uid,
        fromuid: fromuid ?? this.fromuid,
        cubeuuid: cubeuuid ?? this.cubeuuid,
        points: points ?? this.points,
        explains: explains ?? this.explains,
        gettime: gettime ?? this.gettime,
        deleteaction: deleteaction ?? this.deleteaction,
      );

  factory UserExpPointHistroy.fromRawJson(String str) =>
      UserExpPointHistroy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserExpPointHistroy.fromJson(Map<String, dynamic> json) =>
      UserExpPointHistroy(
        idx: json["idx"] == null ? null : json["idx"],
        uid: json["uid"] == null ? null : json["uid"],
        fromuid: json["fromuid"] == null ? null : json["fromuid"],
        cubeuuid: json["cubeuuid"] == null ? null : json["cubeuuid"],
        points: json["points"] == null ? null : json["points"],
        explains: json["explains"] == null ? null : json["explains"],
        gettime:
            json["gettime"] == null ? null : DateTime.parse(json["gettime"]),
        deleteaction:
            json["deleteaction"] == null ? null : json["deleteaction"],
      );

  Map<String, dynamic> toJson() => {
        "idx": idx == null ? null : idx,
        "uid": uid == null ? null : uid,
        "fromuid": fromuid == null ? null : fromuid,
        "cubeuuid": cubeuuid == null ? null : cubeuuid,
        "points": points == null ? null : points,
        "explains": explains == null ? null : explains,
        "gettime": gettime == null ? null : gettime.toIso8601String(),
        "deleteaction": deleteaction == null ? null : deleteaction,
      };

  // 나중에 구현
  // static Future<List<UserExpPointHistroy>> getUserExpPointHistroy(
  //     UserExpPointHistroy finditem) async {
  //   FirebaseUser user = await FirebaseAuth.instance.currentUser();
  //   IdTokenResult token = await user.getIdToken();
  //   var geturl = Preference.httpurloption(Preference.baseBackEndUrl,
  //       "/api/v1/Fcube/getFcubeReview", finditem.toJson());
  // }

  static Future<double> getCubeuuidGetPoint(
      String cubeuuid, String explains) async {
    var geturl = Preference.httpurloption(
        Preference.baseBackEndUrl,
        "/api/v1/Fcube/getCubeuuidGetPoint",
        {"cubeuuid": cubeuuid, 'explains': explains});
    var response = await http.get(geturl);
    return double.tryParse(response.body);
  }
}
