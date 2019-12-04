import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:forutonafront/MakePage/Component/Fcube.dart';
import 'package:forutonafront/MakePage/Component/FcubeExtender1.dart';
import 'package:forutonafront/MakePage/Fcubecontent.dart';
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
    this.cubepassword = cube.cubepassword;
    this.haspassword = cube.haspassword;
    this.cubescope = cube.cubescope;
    this.influencelevel = cube.influencelevel;
    this.cubehits = cube.cubehits;
    this.cubelikes = cube.cubelikes;
    this.cubedislikes = cube.cubedislikes;
    this.joinplayer = cube.joinplayer;
    this.maximumplayers = cube.maximumplayers;
  }
  String nickname;
  String profilepicktureurl;
  DateTime positionupdatetime;
  double userlevel;
  FcubeQuest.fromFcubeExtender1(FcubeExtender1 extender1) {
    this.cubeuuid = extender1.cubeuuid;
    this.uid = extender1.uid;
    this.longitude = extender1.longitude;
    this.latitude = extender1.latitude;
    this.cubedispalyname = extender1.cubedispalyname;
    this.cubename = extender1.cubename;
    this.cubetype = extender1.cubetype;
    this.maketime = extender1.maketime;
    this.influence = extender1.influence;
    this.cubestate = extender1.cubestate;
    this.placeaddress = extender1.placeaddress;
    this.administrativearea = extender1.administrativearea;
    this.country = extender1.country;
    this.cubeimage = extender1.cubeimage;
    this.pointreward = extender1.pointreward;
    this.influencereward = extender1.influencereward;
    this.activationtime = extender1.activationtime;
    this.nickname = extender1.nickname;
    this.profilepicktureurl = extender1.profilepicktureurl;
    this.cubepassword = extender1.cubepassword;
    this.haspassword = extender1.haspassword;
    this.cubescope = extender1.cubescope;
    this.influencelevel = extender1.influencelevel;
    this.cubehits = extender1.cubehits;
    this.cubelikes = extender1.cubelikes;
    this.cubedislikes = extender1.cubedislikes;
    this.joinplayer = extender1.joinplayer;
    this.maximumplayers = extender1.maximumplayers;
    this.positionupdatetime = extender1.positionupdatetime;
    this.userlevel = extender1.userlevel;
  }

  StartCubeLocation startCubeLocation;
  FinishCubeLocation finishCubeLocation;
  List<MessageCubeLocation> messagecubeLocations;
  List<CheckinCubeLocation> checkincubeLocations;
  String description;
  String markdowndescription;
  String authmethod;
  String authPicturedescription;

  getFcubeQuestFromBackend() {}

  @override
  Future<int> makecube() async {
    int makecubereslut = await super.makecube();
    if (makecubereslut == 1) {
      List<Fcubecontent> cubecontents = List<Fcubecontent>();
      if (startCubeLocation != null) {
        cubecontents.add(Fcubecontent(
            contenttype: FcubecontentType.startCubeLocation,
            contentvalue: jsonEncode(startCubeLocation.toJson()),
            cubeuuid: this.cubeuuid));
      }
      if (finishCubeLocation != null) {
        cubecontents.add(Fcubecontent(
            contenttype: FcubecontentType.finishCubeLocation,
            contentvalue: jsonEncode(finishCubeLocation.toJson()),
            cubeuuid: this.cubeuuid));
      }
      if (messagecubeLocations != null) {
        Iterable<MessageCubeLocation> filter =
            messagecubeLocations.where((item) {
          return item.ismarkersetuponmap;
        });

        cubecontents.add(Fcubecontent(
            contenttype: FcubecontentType.messagecubeLocations,
            contentvalue:
                jsonEncode(List<dynamic>.from(filter.toList().map((x) => x))),
            cubeuuid: this.cubeuuid));
      }
      if (checkincubeLocations != null) {
        Iterable<CheckinCubeLocation> filter =
            checkincubeLocations.where((item) {
          return item.ismarkersetuponmap;
        });
        cubecontents.add(Fcubecontent(
            contenttype: FcubecontentType.checkincubeLocations,
            contentvalue:
                jsonEncode(List<dynamic>.from(filter.toList().map((x) => x))),
            cubeuuid: this.cubeuuid));
      }
      if (description != null) {
        cubecontents.add(Fcubecontent(
            contenttype: FcubecontentType.description,
            contentvalue: jsonEncode({"description": description}),
            cubeuuid: this.cubeuuid));
      }
      if (authmethod != null) {
        cubecontents.add(Fcubecontent(
            contenttype: FcubecontentType.authmethod,
            contentvalue: jsonEncode({"authmethod": authmethod}),
            cubeuuid: this.cubeuuid));
      }
      if (authPicturedescription != null) {
        cubecontents.add(Fcubecontent(
            contenttype: FcubecontentType.authPicturedescription,
            contentvalue:
                jsonEncode({"authPicturedescription": authPicturedescription}),
            cubeuuid: this.cubeuuid));
      }
      return await Fcubecontent.makecubecontents(cubecontents);
    }

    return 0;
  }
}
