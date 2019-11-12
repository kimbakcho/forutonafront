import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:forutonafront/MakePage/Component/Fcube.dart';

class FcubeQuest extends Fcube {
  FcubeQuest({@required Fcube cube}) {
    this.cubeuuid = cube.cubeuuid;
    this.uid = cube.uid;
    this.longitude = cube.longitude;
    this.latitude = cube.latitude;
    this.cubename = cube.cubename;
    this.cubetype = cube.cubetype;
    this.maketime = cube.maketime;
    this.influence = cube.influence;
    this.cubestate = cube.cubestate;
    this.placeaddress = cube.placeaddress;
    this.administrativearea = cube.administrativearea;
    this.country = cube.country;
  }

  @override
  Future<int> makecube() async {
    // TODO: implement makecube

    return 1;
  }
}
