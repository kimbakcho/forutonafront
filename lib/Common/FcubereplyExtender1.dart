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

  FcubereplyExtender1.fromJson(Map<String, dynamic> json) {
    commntno = json["commntno"];
    cubeuuid = json["cubeuuid"];
    uid = json["Uid"];
    bgroup = json["bgroup"];
    sorts = json["sorts"];
    depth = json["depth"];
    commnttext = json["commnttext"];
    commnttime = DateTime.parse(json["commnttime"]);
    nickname = json["nickname"];
    profilepicktureurl = json["profilepicktureurl"];
    fcmtoken = json["fcmtoken"];
    bgroupcount = json["bgroupcount"];
  }

  FcubereplyExtender1.fromFcubereply(Fcubereply fcubereply,
      {this.nickname, this.profilepicktureurl}) {
    commntno = fcubereply.commntno;
    cubeuuid = fcubereply.cubeuuid;
    uid = fcubereply.uid;
    sorts = fcubereply.sorts;
    bgroup = fcubereply.bgroup;
    depth = fcubereply.depth;
    commnttext = fcubereply.commnttext;
    commnttime = fcubereply.commnttime;
  }

  Map<String, dynamic> toJson() => {
        "commntno": commntno,
        "cubeuuid": cubeuuid,
        "uid": uid,
        "bgroup": bgroup,
        "sorts": sorts,
        "depth": depth,
        "commnttext": commnttext,
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

  static Future<List<FcubereplyExtender1>> selectStep1ForReply(
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
}
