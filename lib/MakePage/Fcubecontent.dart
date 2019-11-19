import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/Preference.dart';
import 'package:http/http.dart' as http;

class FcubeContentSelector {
  String uid;
  String cubeuuid;
  List<FcubecontentType> contenttypes;
  FcubeContentSelector({this.uid, this.cubeuuid, this.contenttypes});
  factory FcubeContentSelector.fromJson(Map<String, dynamic> json) =>
      FcubeContentSelector(
        uid: json["uid"],
        cubeuuid: json["cubeuuid"],
        contenttypes: List<FcubecontentType>.from(
            json["contenttypes"].map((x) => FcubecontentType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "cubeuuid": cubeuuid,
        "contenttypes": List<dynamic>.from(
            contenttypes.map((x) => FcubecontentType.toJson(x))),
      };
}

class Fcubecontent {
  int idx;
  String cubeuuid;
  FcubecontentType contenttype;
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
    contenttype = FcubecontentType.fromJson(json['contenttype']);
    contentvalue = json['contentvalue'];
    contentupdatetime = json['contentupdatetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idx'] = this.idx;
    data['cubeuuid'] = this.cubeuuid;
    data['contenttype'] = FcubecontentType.toJson(this.contenttype);
    data['contentvalue'] = this.contentvalue;
    data['contentupdatetime'] = this.contentupdatetime;
    return data;
  }

  static Future<Map<FcubecontentType, Fcubecontent>> getFcubecontent(
      FcubeContentSelector selector) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken();
    var posturl = Preference.httpurlbase(
        Preference.baseBackEndUrl, "/api/v1/Fcube/getFcubecontent");
    var response =
        await http.post(posturl, body: jsonEncode(selector.toJson()), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + token.token
    });
    
    var recvjson = jsonDecode(response.body);
    Map<FcubecontentType, Fcubecontent> contents =
        Map<FcubecontentType, Fcubecontent>();

    recvjson.forEach((v) {
      var tempitem = new Fcubecontent.fromJson(v);
      contents[tempitem.contenttype] = tempitem;
    });
    return contents;
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
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken();
    for (int i = 0; i < contents.length; i++) {
      try {
        var url = Preference.httpurlbase(
            Preference.baseBackEndUrl, "/api/v1/Fcube/makecubecontent");
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
}

class FcubecontentType {
  const FcubecontentType._(this.value);
  final int value;
  static const FcubecontentType startCubeLocation = FcubecontentType._(0);
  static const FcubecontentType finishCubeLocation = FcubecontentType._(1);
  static const FcubecontentType messagecubeLocations = FcubecontentType._(2);
  static const FcubecontentType checkincubeLocations = FcubecontentType._(3);
  static const FcubecontentType description = FcubecontentType._(4);
  static const FcubecontentType authmethod = FcubecontentType._(5);
  static const FcubecontentType authPicturedescription = FcubecontentType._(6);

  static const List<FcubecontentType> values = <FcubecontentType>[
    startCubeLocation,
    finishCubeLocation,
    messagecubeLocations,
    checkincubeLocations,
    description,
    authmethod,
    authPicturedescription
  ];

  static const List<String> _names = <String>[
    'startCubeLocation',
    'finishCubeLocation',
    'messagecubeLocations',
    'checkincubeLocations',
    'description',
    'authmethod',
    'authPicturedescription'
  ];

  static FcubecontentType fromJson(value) {
    return values[_names.indexOf(value)];
  }

  static String toJson(type) {
    return _names[type.value];
  }

  @override
  String toString() => _names[value];
}
