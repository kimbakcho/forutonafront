import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/PlayPage/Fcubeplayercontent.dart';
import 'package:forutonafront/Preference.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class FcubeplayercontentExtender1 extends FcubePlayerContent {
  FcubeplayercontentExtender1({
    int idx,
    String cubeuuid,
    String uid,
    FcubeplayercontentType contenttype,
    String contentvalue,
    DateTime contentupdatetime,
  }) : super(
            idx: idx,
            cubeuuid: cubeuuid,
            uid: uid,
            contenttype: contenttype,
            contentvalue: contentvalue,
            contentupdatetime: contentupdatetime);

  FcubeplayercontentExtender1 copyWithFromFcubeplayercontent(
          {FcubePlayerContent content}) =>
      FcubeplayercontentExtender1(
        idx: content.idx ?? content.idx,
        cubeuuid: content.cubeuuid ?? content.cubeuuid,
        uid: content.uid ?? content.uid,
        contenttype: content.contenttype ?? content.contenttype,
        contentvalue: content.contentvalue ?? content.contentvalue,
        contentupdatetime:
            content.contentupdatetime ?? content.contentupdatetime,
      );

  FcubeplayercontentExtender1 copyWith({
    int idx,
    String cubeuuid,
    String uid,
    FcubeplayercontentType contenttype,
    String contentvalue,
    DateTime contentupdatetime,
  }) =>
      FcubeplayercontentExtender1(
        idx: idx ?? this.idx,
        cubeuuid: cubeuuid ?? this.cubeuuid,
        uid: uid ?? this.uid,
        contenttype: contenttype ?? this.contenttype,
        contentvalue: contentvalue ?? this.contentvalue,
        contentupdatetime: contentupdatetime ?? this.contentupdatetime,
      );

  factory FcubeplayercontentExtender1.fromJson(Map<String, dynamic> json) =>
      FcubeplayercontentExtender1(
        idx: json["idx"] == null ? null : json["idx"],
        cubeuuid: json["cubeuuid"] == null ? null : json["cubeuuid"],
        uid: json["Uid"] == null ? null : json["Uid"],
        contenttype: json["contenttype"] == null
            ? null
            : FcubeplayercontentType.fromJson(json["contenttype"]),
        contentvalue:
            json["contentvalue"] == null ? null : json["contentvalue"],
        contentupdatetime: json["contentupdatetime"] == null
            ? null
            : DateTime.parse(json["contentupdatetime"]),
      );

  Map<String, dynamic> toJson() => {
        "idx": idx == null ? null : idx,
        "cubeuuid": cubeuuid == null ? null : cubeuuid,
        "uid": uid == null ? null : uid,
        "contenttype": contenttype == null
            ? null
            : FcubeplayercontentType.toJson(this.contenttype),
        "contentvalue": contentvalue == null ? null : contentvalue,
        "contentupdatetime": contentupdatetime == null
            ? null
            : contentupdatetime.toIso8601String(),
      };

  static Future<Map<FcubeplayercontentType, FcubeplayercontentExtender1>>
      getFcubeplayercontent(FcubeplayercontentSelector selector) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken(refresh: true);
    var posturl = Preference.httpurlbase(
        Preference.baseBackEndUrl, "/api/v1/Fcube/getFcubeplayercontent");
    var response = await http
        .post(posturl, body: json.encode(selector.toJson()), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + token.token
    });

    var recvjson = jsonDecode(response.body);
    Map<FcubeplayercontentType, FcubeplayercontentExtender1> contents =
        Map<FcubeplayercontentType, FcubeplayercontentExtender1>();

    recvjson.forEach((v) {
      var tempitem = new FcubeplayercontentExtender1.fromJson(v);
      contents[tempitem.contenttype] = tempitem;
    });
    return contents;
  }

  static Future<List<FcubeplayercontentExtender1>>
      getFcubeplayercontentTypeList(FcubeplayercontentSelector selector) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken(refresh: true);
    var posturl = Preference.httpurlbase(
        Preference.baseBackEndUrl, "/api/v1/Fcube/getFcubeplayercontent");
    var response = await http
        .post(posturl, body: json.encode(selector.toJson()), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + token.token
    });

    return List<FcubeplayercontentExtender1>.from(json
        .decode(response.body)
        .map((x) => FcubeplayercontentExtender1.fromJson(x)));
  }

  Future<int> makeFcubeplayercontent() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken(refresh: true);
    var url = Preference.httpurlbase(
        Preference.baseBackEndUrl, "/api/v1/Fcube/makeFcubeplayercontent");
    var response =
        await http.post(url, body: jsonEncode(this.toJson()), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + token.token
    });
    return int.tryParse(response.body);
  }

  static Future<int> makeFcubeplayercontents(
      List<FcubeplayercontentExtender1> contents) async {
    int sendresult = 0;
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken(refresh: true);
    for (int i = 0; i < contents.length; i++) {
      try {
        var url = Preference.httpurlbase(
            Preference.baseBackEndUrl, "/api/v1/Fcube/makeFcubeplayercontent");
        var response = await http
            .post(url, body: jsonEncode(contents[i].toJson()), headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer " + token.token
        });
        sendresult += int.tryParse(response.body);
      } catch (ex) {}
    }
    if (sendresult == contents.length) {
      return 1;
    } else {
      return 0;
    }
  }

  Future<int> updateFcubeplayercontent() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken(refresh: true);
    var url = Preference.httpurlbase(
        Preference.baseBackEndUrl, "/api/v1/Fcube/updateFcubeplayercontent");
    var response =
        await http.post(url, body: jsonEncode(this.toJson()), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + token.token
    });
    return int.tryParse(response.body);
  }

  Future<int> deleteFcubeplayercontent() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken(refresh: true);
    var url = Preference.httpurlbase(
        Preference.baseBackEndUrl, "/api/v1/Fcube/deleteFcubeplayercontent");
    var response =
        await http.post(url, body: jsonEncode(this.toJson()), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + token.token
    });
    return int.tryParse(response.body);
  }

  static Future<String> uploadAuthimage(List<int> image) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken(refresh: true);
    var uploadurl = Preference.httpurlbase(
        Preference.baseBackEndUrl, '/api/v1/Fcube/uploadAuthForImage');
    var request = new http.MultipartRequest("POST", uploadurl);
    http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
        'CubeAuthRelationImage', image,
        filename: "CubeAuthRelationImage.png");
    request.files.add(multipartFile);
    request.headers.addAll({
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + token.token
    });
    request.fields.addAll({"uid": user.uid});
    StreamedResponse streamresponse = await request.send();
    Response response = await Response.fromStream(streamresponse);
    if (response.statusCode == 200) {
      var revlink = response.body;
      return revlink;
    } else {
      return "";
    }
  }

  static Future<int> deleteAuthimage(String urlpath) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken(refresh: true);
    var url = Preference.httpurloption(Preference.baseBackEndUrl,
        "/api/v1/Fcube/deleteAuthForImage", {"url": urlpath, "uid": user.uid});
    var response = await http.post(url,
        headers: {HttpHeaders.authorizationHeader: "Bearer " + token.token});
    return int.tryParse(response.body);
  }
}

class FcubeplayercontentSelector {
  String uid;
  String cubeuuid;
  List<FcubeplayercontentType> contenttypes;
  FcubeplayercontentSelector({this.uid, this.cubeuuid, this.contenttypes});
  factory FcubeplayercontentSelector.fromJson(Map<String, dynamic> json) =>
      FcubeplayercontentSelector(
        uid: json["uid"],
        cubeuuid: json["cubeuuid"],
        contenttypes: List<FcubeplayercontentType>.from(json["contenttypes"]
            .map((x) => FcubeplayercontentType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "cubeuuid": cubeuuid,
        "contenttypes": List<dynamic>.from(
            contenttypes.map((x) => FcubeplayercontentType.toJson(x))),
      };
}
