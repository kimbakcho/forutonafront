import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:forutonafront/MakePage/Component/Fcube.dart';
import 'package:forutonafront/MakePage/Component/Fcubecontent.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StartCubeLocation {
  double longitude;
  double latitude;
  Marker startmaker;
  static String cubeimagepath = "assets/MarkesImages/startCube.png";
  StartCubeLocation();
  StartCubeLocation.fromJson(Map<String, dynamic> json) {
    longitude = json['longitude'];
    latitude = json['latitude'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    return data;
  }
}

class FinishCubeLocation {
  double longitude;
  double latitude;
  Marker finishmaker;
  static String cubeimagepath = "assets/MarkesImages/finishCube.png";
  FinishCubeLocation();
  FinishCubeLocation.fromJson(Map<String, dynamic> json) {
    longitude = json['longitude'];
    latitude = json['latitude'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    return data;
  }
}

class MessageCubeLocation {
  String title;
  String message;
  double longitude;
  double latitude;
  Marker messagemaker;
  static String cubeimagepath = "assets/MarkesImages/MessageCube.png";
  bool ismarkersetuponmap = false;
  MessageCubeLocation();
  MessageCubeLocation.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    message = json['message'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['message'] = this.message;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    return data;
  }
}

class CheckinCubeLocation {
  String title;
  String message;
  double range;
  double longitude;
  double latitude;
  Marker checkincubemaker;
  bool ismarkersetuponmap = false;
  static String cubeimagepath = "assets/MarkesImages/CheckInCube.png";
  CheckinCubeLocation();
  CheckinCubeLocation.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    message = json['message'];
    range = json['range'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['message'] = this.message;
    data['range'] = this.range;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    return data;
  }
}

class FcubeQuest extends Fcube {
  FcubeQuest({@required Fcube cube}) {
    this.cubeuuid = cube.cubeuuid;
    this.uid = cube.uid;
    this.longitude = cube.longitude;
    this.latitude = cube.latitude;
    this.cubedispalyname = cube.cubedispalyname;
    this.cubename = cube.cubename;
    this.cubetype = cube.cubetype;
    this.maketime = cube.maketime;
    this.influence = cube.influence;
    this.cubestate = cube.cubestate;
    this.placeaddress = cube.placeaddress;
    this.administrativearea = cube.administrativearea;
    this.country = cube.country;
    this.cubeimage = cube.cubeimage;
    this.pointreward = cube.pointreward;
    this.influencereward = cube.influencereward;
    this.activationtime = cube.activationtime;
  }
  StartCubeLocation startCubeLocation;
  FinishCubeLocation finishCubeLocation;
  List<MessageCubeLocation> messagecubeLocations;
  List<CheckinCubeLocation> checkincubeLocations;
  String description;
  String markdowndescription;
  String authmethod;
  String authPicturedescription;

  @override
  Future<int> makecube() async {
    int makecubereslut = await super.makecube();
    if (makecubereslut == 1) {
      List<Fcubecontent> cubecontents = List<Fcubecontent>();
      if (startCubeLocation != null) {
        cubecontents.add(Fcubecontent(
            contenttype: "startCubeLocation",
            contentvalue: jsonEncode(startCubeLocation.toJson()),
            cubeuuid: this.cubeuuid));
      }
      if (finishCubeLocation != null) {
        cubecontents.add(Fcubecontent(
            contenttype: "finishCubeLocation",
            contentvalue: jsonEncode(finishCubeLocation.toJson()),
            cubeuuid: this.cubeuuid));
      }
      if (messagecubeLocations != null) {
        Iterable<MessageCubeLocation> filter =
            messagecubeLocations.where((item) {
          return item.ismarkersetuponmap;
        });

        cubecontents.add(Fcubecontent(
            contenttype: "messagecubeLocations",
            contentvalue:
                jsonEncode(List<dynamic>.from(filter.toList().map((x) => x))),
            cubeuuid: this.cubeuuid));
      }
      if (checkincubeLocations != null) {
        Iterable<MessageCubeLocation> filter =
            messagecubeLocations.where((item) {
          return item.ismarkersetuponmap;
        });
        cubecontents.add(Fcubecontent(
            contenttype: "checkincubeLocations",
            contentvalue:
                jsonEncode(List<dynamic>.from(filter.toList().map((x) => x))),
            cubeuuid: this.cubeuuid));
      }
      if (description != null) {
        cubecontents.add(Fcubecontent(
            contenttype: "description",
            contentvalue: jsonEncode({"description": description}),
            cubeuuid: this.cubeuuid));
      }
      if (authmethod != null) {
        cubecontents.add(Fcubecontent(
            contenttype: "authmethod",
            contentvalue: jsonEncode({"authmethod": authmethod}),
            cubeuuid: this.cubeuuid));
      }
      if (authPicturedescription != null) {
        cubecontents.add(Fcubecontent(
            contenttype: "authPicturedescription",
            contentvalue:
                jsonEncode({"authPicturedescription": authPicturedescription}),
            cubeuuid: this.cubeuuid));
      }
      return  await Fcubecontent.makecubecontents(cubecontents);
    }

    return 0;
  }
}
