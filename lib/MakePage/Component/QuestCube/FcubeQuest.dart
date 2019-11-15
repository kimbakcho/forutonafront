import 'package:flutter/cupertino.dart';
import 'package:forutonafront/MakePage/Component/Fcube.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StartCubeLocation {
  double longitude;
  double latitude;
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

class CubeMessagebox {
  String title;
  String message;
  double longitude;
  double latitude;
  CubeMessagebox.fromJson(Map<String, dynamic> json) {
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

class CubeCheckin {
  double range;
  double longitude;
  double latitude;
  CubeCheckin.fromJson(Map<String, dynamic> json) {
    range = json['range'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
  List<CubeMessagebox> cubeMessageboxs;
  CubeCheckin cubeCheckin;
  String description;
  String markdowndescription;

  @override
  Future<int> makecube() async {
    int makecubereslut = await super.makecube();
    if (makecubereslut == 1) {


    }

    return 0;
  }
}
