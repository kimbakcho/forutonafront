import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/MakePage/Component/Fcube.dart';
import 'package:forutonafront/Preference.dart';
import 'package:http/http.dart' as http;

class FcubeExtender1 extends Fcube {
  String nickname;
  String profilepicktureurl;

  FcubeExtender1.fromJson(Map<String, dynamic> json) {
    cubeuuid = json['cubeuuid'];
    uid = json['uid'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    cubename = json['cubename'];
    cubetype = json['cubetype'];
    maketime = json['maketime'];
    influence = json['influence'];
    cubestate = json['cubestate'];
    placeaddress = json['placeaddress'];
    administrativearea = json['administrativearea'];
    country = json['country'];
    nickname = json['nickname'];
    profilepicktureurl = json['profilepicktureurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cubeuuid'] = this.cubeuuid;
    data['uid'] = this.uid;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['cubename'] = this.cubename;
    data['cubetype'] = this.cubetype;
    data['maketime'] = this.maketime;
    data['influence'] = this.influence;
    data['cubestate'] = this.cubestate;
    data['placeaddress'] = this.placeaddress;
    data['administrativearea'] = this.administrativearea;
    data['country'] = this.country;
    data['nickname'] = this.nickname;
    data['profilepicktureurl'] = this.profilepicktureurl;
    return data;
  }

  static Future<List<FcubeExtender1>> getusercubes(
      {int offset, int limit}) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken();
    var url = Preference.httpurloption(Preference.baseBackEndUrl,
        "/api/v1/Fcube/getusercubes", {"offset": "$offset", "limit": "$limit"});
    var response = await http.get(url,
        headers: {HttpHeaders.authorizationHeader: "Bearer " + token.token});
    // print(response.body);
    var recvjson = jsonDecode(response.body);
    List<FcubeExtender1> list = new List<FcubeExtender1>();
    recvjson.forEach((v) {
      list.add(new FcubeExtender1.fromJson(v));
    });
    return list;
  }
}
