import 'dart:convert';

import 'package:forutonafront/Common/Fcubereply.dart';
import 'package:forutonafront/Preference.dart';
import 'package:http/http.dart' as http;

class FcubereplyExtender1 extends Fcubereply {
  String nickname;
  String profilepicktureurl;

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
        "profilepicktureurl": profilepicktureurl
      };

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