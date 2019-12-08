import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/Preference.dart';
import 'package:http/http.dart' as http;

class FcubeQuestSuccess {
  int reqno;
  String cubeuuid;
  String uid;
  String fromuid;
  String content;
  int readingcheck;
  int scuesscheck;
  DateTime reqtime;
  dynamic judgmenttime;

  FcubeQuestSuccess({
    this.reqno,
    this.cubeuuid,
    this.uid,
    this.fromuid,
    this.content,
    this.readingcheck,
    this.scuesscheck,
    this.reqtime,
    this.judgmenttime,
  });

  FcubeQuestSuccess copyWith({
    int reqno,
    String cubeuuid,
    String uid,
    String fromuid,
    String content,
    int readingcheck,
    int scuesscheck,
    DateTime reqtime,
    dynamic judgmenttime,
  }) =>
      FcubeQuestSuccess(
        reqno: reqno ?? this.reqno,
        cubeuuid: cubeuuid ?? this.cubeuuid,
        uid: uid ?? this.uid,
        fromuid: fromuid ?? this.fromuid,
        content: content ?? this.content,
        readingcheck: readingcheck ?? this.readingcheck,
        scuesscheck: scuesscheck ?? this.scuesscheck,
        reqtime: reqtime ?? this.reqtime,
        judgmenttime: judgmenttime ?? this.judgmenttime,
      );

  factory FcubeQuestSuccess.fromRawJson(String str) =>
      FcubeQuestSuccess.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FcubeQuestSuccess.fromJson(Map<String, dynamic> json) =>
      FcubeQuestSuccess(
        reqno: json["reqno"] == null ? null : json["reqno"],
        cubeuuid: json["cubeuuid"] == null ? null : json["cubeuuid"],
        uid: json["uid"] == null ? null : json["uid"],
        fromuid: json["fromuid"] == null ? null : json["fromuid"],
        content: json["content"] == null ? null : json["content"],
        readingcheck:
            json["readingcheck"] == null ? null : json["readingcheck"],
        scuesscheck: json["scuesscheck"] == null ? null : json["scuesscheck"],
        reqtime:
            json["reqtime"] == null ? null : DateTime.parse(json["reqtime"]),
        judgmenttime: json["judgmenttime"],
      );

  Map<String, dynamic> toJson() => {
        "reqno": reqno == null ? null : reqno,
        "cubeuuid": cubeuuid == null ? null : cubeuuid,
        "uid": uid == null ? null : uid,
        "fromuid": fromuid == null ? null : fromuid,
        "content": content == null ? null : content,
        "readingcheck": readingcheck == null ? null : readingcheck,
        "scuesscheck": scuesscheck == null ? null : scuesscheck,
        "reqtime": reqtime == null ? null : reqtime.toIso8601String(),
        "judgmenttime": judgmenttime,
      };

  Future<int> requestFcubeQuestSuccess() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken();
    var posturl = Preference.httpurlbase(
        Preference.baseBackEndUrl, "/api/v1/Fcube/requestFcubeQuestSuccess");
    print(toRawJson());
    var response = await http.post(posturl, body: toRawJson(), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + token.token
    });
    return int.tryParse(response.body);
  }
}

class FcubeQuestAuthPicture {
  List<String> authpicture;
  String authtext;

  FcubeQuestAuthPicture({
    this.authpicture,
    this.authtext,
  });

  FcubeQuestAuthPicture copyWith({List<String> authpicture, String authtext}) =>
      FcubeQuestAuthPicture(
          authpicture: authpicture ?? this.authpicture,
          authtext: authtext ?? this.authtext);

  factory FcubeQuestAuthPicture.fromRawJson(String str) =>
      FcubeQuestAuthPicture.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FcubeQuestAuthPicture.fromJson(Map<String, dynamic> json) =>
      FcubeQuestAuthPicture(
        authpicture: json["authpicture"] == null
            ? null
            : List<String>.from(json["authpicture"].map((x) => x)),
        authtext: json["authtext"] == null ? null : json["authtext"],
      );

  Map<String, dynamic> toJson() => {
        "authpicture": authpicture == null
            ? null
            : List<dynamic>.from(authpicture.map((x) => x)),
        "authtext": authtext == null ? null : authtext,
      };
}
