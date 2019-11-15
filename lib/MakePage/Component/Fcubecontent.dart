import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/Preference.dart';
import 'package:http/http.dart' as http;

class Fcubecontent {
  int idx;
  String cubeuuid;
  String contenttype;
  String contentvalue;
  String contentupdatetime;

  Fcubecontent(
      {this.idx,
      this.cubeuuid,
      this.contenttype,
      this.contentvalue,
      this.contentupdatetime});

  Fcubecontent.fromJson(Map<String, dynamic> json) {
    idx = json['idx'];
    cubeuuid = json['cubeuuid'];
    contenttype = json['contenttype'];
    contentvalue = json['contentvalue'];
    contentupdatetime = json['contentupdatetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idx'] = this.idx;
    data['cubeuuid'] = this.cubeuuid;
    data['contenttype'] = this.contenttype;
    data['contentvalue'] = this.contentvalue;
    data['contentupdatetime'] = this.contentupdatetime;
    return data;
  }

  Future<int> makecubecontent() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken();
    var url = Preference.httpurlbase(
        Preference.baseBackEndUrl, "/api/v1/Fcube/makecubecontent");
    var response =
        await http.post(url, body: jsonEncode(this.toJson()), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + token.token
    });
    return int.tryParse(response.body);
  }

  static Future<int> makecubecontents(List<Fcubecontent> contents) async {
    int sendresult = 0;
    for (int i = 0; i < contents.length; i++) {
      try {
        sendresult += await contents[i].makecubecontent();
      } catch (ex) {}
      if (sendresult == contents.length) {
        return 1;
      } else {
        return 0;
      }
    }
    return 0;
  }
}
