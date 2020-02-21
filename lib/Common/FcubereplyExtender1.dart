import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/Common/Fcubereply.dart';
import 'package:forutonafront/Common/FcubereplySearch.dart';
import 'package:forutonafront/Preference.dart';
import 'package:http/http.dart' as http;

class FcubereplyExtender1 extends Fcubereply {
  String nickname;
  String profilepicktureurl;
  String fcmtoken;
  int bgroupcount;
  FcubereplyExtender1();

  FcubereplyExtender1.fromJson(Map<String, dynamic> json) {
    commentno = json["commentno"];
    cubeuuid = json["cubeuuid"];
    uid = json["Uid"];
    bgroup = json["bgroup"];
    sorts = json["sorts"];
    depth = json["depth"];
    commenttext = json["commenttext"];
    commenttime = DateTime.parse(json["commenttime"]);
    nickname = json["nickname"];
    profilepicktureurl = json["profilepicktureurl"];
    fcmtoken = json["fcmtoken"];
    bgroupcount = json["bgroupcount"];
  }

  FcubereplyExtender1.fromFcubereply(Fcubereply fcubereply,
      {this.nickname, this.profilepicktureurl}) {
    commentno = fcubereply.commentno;
    cubeuuid = fcubereply.cubeuuid;
    uid = fcubereply.uid;
    sorts = fcubereply.sorts;
    bgroup = fcubereply.bgroup;
    depth = fcubereply.depth;
    commenttext = fcubereply.commenttext;
    commenttime = fcubereply.commenttime;
  }

  Map<String, dynamic> toJson() => {
        "commentno": commentno,
        "cubeuuid": cubeuuid,
        "uid": uid,
        "bgroup": bgroup,
        "sorts": sorts,
        "depth": depth,
        "commenttext": commenttext,
        "nickname": nickname,
        "profilepicktureurl": profilepicktureurl,
        "fcmtoken": fcmtoken,
        "bgroupcount": bgroupcount
      };

  static Future<List<FcubereplyExtender1>> selectReplyForCubeGroup(
      FcubereplySearch search) async {
    Dio dio = new Dio();
    Uri url = Preference.httpurlbase(
        Preference.baseBackEndUrl, "/api/v1/Fcube/SelectReplyForCubeGroup");
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken();
    Response response = await dio.get(url.toString(),
        queryParameters: search.toJson(),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer " + token.token
        }));
    return List<FcubereplyExtender1>.from(
        response.data.map((x) => FcubereplyExtender1.fromJson(x)));
  }

  static Future<List<FcubereplyExtender1>> selectReplyForCube(
      String cubeuuid, int offset, int limit) async {
    var queryParameters = {
      "cubeuuid": cubeuuid,
      "offset": offset.toString(),
      "limit": limit.toString(),
    };
    Uri url = Preference.httpurloption(Preference.baseBackEndUrl,
        "/api/v1/Fcube/SelectReplyForCube", queryParameters);
    var response = await http.get(url);
    var recvjson = json.decode(response.body);
    List<FcubereplyExtender1> list = new List<FcubereplyExtender1>();
    recvjson.forEach((v) {
      list.add(new FcubereplyExtender1.fromJson(v));
    });
    return list;
  }

  static Future<List<FcubereplyExtender1>> selectReplyForCubeWithBgroup(
      FcubereplySearch search) async {
    Dio dio = new Dio();
    Uri url = Preference.httpurlbase(Preference.baseBackEndUrl,
        "/api/v1/Fcube/SelectReplyForCubeWithBgroup");
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken();
    Response response = await dio.get(url.toString(),
        queryParameters: search.toJson(),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer " + token.token
        }));
    return List<FcubereplyExtender1>.from(
        response.data.map((x) => FcubereplyExtender1.fromJson(x)));
  }
}
