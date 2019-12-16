import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/PlayPage/QuestCube/FcubeQuestSuccess.dart';
import 'package:forutonafront/Preference.dart';
import 'package:http/http.dart' as http;

class FcubeQuestSuccessExtender1 extends FcubeQuestSuccess {
  String nickname;
  String profilepicktureurl;
  double userlevel;
  String readuid;
  int confirm;
  FcubeQuestSuccessExtender1(
      {int reqno,
      String cubeuuid,
      String uid,
      String fromuid,
      String contenttype,
      String toplayercomment,
      String tomakercomment,
      double starpoint,
      String content,
      int readingcheck,
      int scuesscheck,
      DateTime reqtime,
      dynamic judgmenttime,
      this.nickname,
      this.profilepicktureurl,
      this.userlevel,
      this.readuid,
      this.confirm})
      : super(
          reqno: reqno,
          cubeuuid: cubeuuid,
          uid: uid,
          fromuid: fromuid,
          contenttype: contenttype,
          toplayercomment: toplayercomment,
          tomakercomment: tomakercomment,
          starpoint: starpoint,
          content: content,
          readingcheck: readingcheck,
          scuesscheck: scuesscheck,
          reqtime: reqtime,
          judgmenttime: judgmenttime,
        );
  FcubeQuestSuccessExtender1 copyWithFromFcubeQuestSuccess(
          {FcubeQuestSuccess item}) =>
      FcubeQuestSuccessExtender1(
        reqno: item.reqno ?? item.reqno,
        cubeuuid: item.cubeuuid ?? item.cubeuuid,
        fromuid: item.fromuid ?? item.fromuid,
        contenttype: item.contenttype ?? item.contenttype,
        toplayercomment: item.toplayercomment ?? item.toplayercomment,
        tomakercomment: item.tomakercomment ?? item.tomakercomment,
        starpoint: item.starpoint ?? item.starpoint,
        content: item.content ?? item.content,
        readingcheck: item.readingcheck ?? item.readingcheck,
        scuesscheck: item.scuesscheck ?? item.scuesscheck,
        reqtime: item.reqtime ?? item.reqtime,
        judgmenttime: item.judgmenttime ?? item.judgmenttime,
      );
  factory FcubeQuestSuccessExtender1.fromJson(Map<String, dynamic> json) =>
      FcubeQuestSuccessExtender1(
        reqno: json["reqno"] == null ? null : json["reqno"],
        cubeuuid: json["cubeuuid"] == null ? null : json["cubeuuid"],
        uid: json["uid"] == null ? null : json["uid"],
        fromuid: json["fromuid"] == null ? null : json["fromuid"],
        contenttype: json["contenttype"] == null ? null : json["contenttype"],
        toplayercomment:
            json["toplayercomment"] == null ? null : json["toplayercomment"],
        tomakercomment:
            json["tomakercomment"] == null ? null : json["tomakercomment"],
        starpoint: json["starpoint"] == null ? null : json["starpoint"],
        content: json["content"] == null ? null : json["content"],
        readingcheck:
            json["readingcheck"] == null ? null : json["readingcheck"],
        scuesscheck: json["scuesscheck"] == null ? null : json["scuesscheck"],
        reqtime:
            json["reqtime"] == null ? null : DateTime.parse(json["reqtime"]),
        judgmenttime: json["judgmenttime"],
        nickname: json["nickname"] == null ? null : json["nickname"],
        profilepicktureurl: json["profilepicktureurl"] == null
            ? null
            : json["profilepicktureurl"],
        userlevel: json["userlevel"] == null ? null : json["userlevel"],
        readuid: json["readuid"] == null ? null : json["readuid"],
        confirm: json["confirm"] == null ? null : json["confirm"],
      );

  factory FcubeQuestSuccessExtender1.fromRawJson(String str) =>
      FcubeQuestSuccessExtender1.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "reqno": reqno == null ? null : reqno,
        "cubeuuid": cubeuuid == null ? null : cubeuuid,
        "uid": uid == null ? null : uid,
        "fromuid": fromuid == null ? null : fromuid,
        "contenttype": contenttype == null ? null : contenttype,
        "toplayercomment": toplayercomment == null ? null : toplayercomment,
        "tomakercomment": tomakercomment == null ? null : tomakercomment,
        "starpoint": starpoint == null ? null : starpoint,
        "content": content == null ? null : content,
        "readingcheck": readingcheck == null ? null : readingcheck,
        "scuesscheck": scuesscheck == null ? null : scuesscheck,
        "reqtime": reqtime == null ? null : reqtime.toIso8601String(),
        "judgmenttime": judgmenttime,
        "nickname": nickname == null ? null : nickname,
        "profilepicktureurl":
            profilepicktureurl == null ? null : profilepicktureurl,
        "userlevel": userlevel == null ? null : userlevel,
        "readuid": readuid == null ? null : readuid,
        "confirm": confirm == null ? null : confirm,
      };

  static Future<List<FcubeQuestSuccessExtender1>> getQuestReqList(
      FcubeQuestSuccessExtender1 finditem) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken();
    var posturl = Preference.httpurlbase(
        Preference.baseBackEndUrl, "/api/v1/Fcube/getQuestReqList");
    var response =
        await http.post(posturl, body: finditem.toRawJson(), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + token.token
    });
    return List<FcubeQuestSuccessExtender1>.from(json
        .decode(response.body)
        .map((x) => FcubeQuestSuccessExtender1.fromJson(x)));
  }

  Future<int> updateQuestReq() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken();
    var posturl = Preference.httpurlbase(
        Preference.baseBackEndUrl, "/api/v1/Fcube/updateQuestReq");
    var response = await http.post(posturl, body: toRawJson(), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + token.token
    });
    return int.tryParse(response.body);
  }

  Future<int> updateQuesttoplayercomment() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken();
    var posturl = Preference.httpurlbase(
        Preference.baseBackEndUrl, "/api/v1/Fcube/updateQuesttoplayercomment");
    var response = await http.post(posturl, body: toRawJson(), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + token.token
    });
    return int.tryParse(response.body);
  }

  static Future<List<FcubeQuestSuccessExtender1>> getPlayerQuestSuccessList(
      FcubeQuestSuccessExtender1 finditem) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken();
    var posturl = Preference.httpurlbase(
        Preference.baseBackEndUrl, "/api/v1/Fcube/getPlayerQuestSuccessList");
    var response =
        await http.post(posturl, body: finditem.toRawJson(), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + token.token
    });
    return List<FcubeQuestSuccessExtender1>.from(json
        .decode(response.body)
        .map((x) => FcubeQuestSuccessExtender1.fromJson(x)));
  }
}
