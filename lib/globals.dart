import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Auth/UserInfoMain.dart';
import 'package:forutonafront/MakePage/Component/FcubeExtender1.dart';
import 'package:forutonafront/MakePage/Component/FcubeListUtil.dart';
import 'package:forutonafront/Preference.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_circle_distance2/great_circle_distance2.dart';
import 'package:http/http.dart' as http;

class GlobalStateContainer extends StatefulWidget {
  final Widget child;
  GlobalStateContainer({@required this.child});

  static _GlobalStateContainerState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_InheritedStateContainer>()
        .data;
  }

  @override
  _GlobalStateContainerState createState() => _GlobalStateContainerState();
}

class _GlobalStateContainerState extends State<GlobalStateContainer> {
  GlobalState state = new GlobalState();

  @override
  void initState() {
    super.initState();
  }

  setfcubeListUtilisLoading(bool value) {
    state.fcubeListUtil.isLoading = value;
  }

  setfcubeplayerListUtilisLoading(bool value) {
    setState(() {
      state.fcubeplayerListUtil.isLoading = value;
    });
  }

  addfcubeListUtilcubeList(List<FcubeExtender1> value) {
    state.fcubeListUtil.cubeList.addAll(value);
  }

  addfcubeplayerListUtilcubeList(List<FcubeExtender1> value) {
    value.forEach((item) {
      item.distancewithme = GreatCircleDistance.fromDegrees(
              latitude1: item.latitude,
              longitude1: item.longitude,
              latitude2: state.currentposition.latitude,
              longitude2: state.currentposition.longitude)
          .haversineDistance();
    });
    state.fcubeplayerListUtil.cubeList.addAll(value);
  }

  addfcubeplayerListUtilcubeListwithReset(List<FcubeExtender1> value) {
    setState(() {
      //자신와의 거리순으로 정렬
      value.sort((a, b) {
        double adistance = GreatCircleDistance.fromDegrees(
                latitude1: a.latitude,
                longitude1: a.longitude,
                latitude2: state.currentposition.latitude,
                longitude2: state.currentposition.longitude)
            .haversineDistance();
        double bdistance = GreatCircleDistance.fromDegrees(
                latitude1: b.latitude,
                longitude1: b.longitude,
                latitude2: state.currentposition.latitude,
                longitude2: state.currentposition.longitude)
            .haversineDistance();
        return adistance.toInt() - bdistance.toInt();
      });
      value.forEach((item) {
        item.distancewithme = GreatCircleDistance.fromDegrees(
                latitude1: item.latitude,
                longitude1: item.longitude,
                latitude2: state.currentposition.latitude,
                longitude2: state.currentposition.longitude)
            .haversineDistance();
      });
      state.fcubeplayerListUtil.cubeList.clear();

      state.fcubeplayerListUtil.cubeList.addAll(value);
    });
  }

  addfcubeListUtilcube(FcubeExtender1 value) {
    setState(() {
      state.fcubeListUtil.cubeList.add(value);
    });
  }

  addfcubeplayerListUtilcube(FcubeExtender1 value) {
    setState(() {
      state.fcubeplayerListUtil.cubeList.add(value);
    });
  }

  resetcubeListUtilcubeList() {
    state.fcubeListUtil.cubeList.clear();
  }

  resetfcubeplayerListUtilcubeList() {
    setState(() {
      state.fcubeplayerListUtil.cubeList.clear();
    });
  }

  updateCurrnetPosition(Position position) async {
    state.currentposition = position;
    if (state.userInfoMain != null) {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      IdTokenResult token = await user.getIdToken(refresh: true);
      state.userInfoMain.latitude = position.latitude;
      state.userInfoMain.longitude = position.longitude;
      Uri url = Preference.httpurlbase(
          Preference.baseBackEndUrl, "/api/v1/Auth/updateCurrentPosition");
      http.post(url, body: json.encode(state.userInfoMain.toJson()), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + token.token
      });
    }
    setState(() {});
  }

  setmainInitialCameraPosition(CameraPosition postion) {
    state.mainInitialCameraPosition = postion;
    setState(() {});
  }

  updateCurrentAddress(Position position) async {
    //만약에 currentpostion이 null 일 때만 1번만 GeoGcoding을 사용한다 GoogleMapAPi 가격 상승에 따른
    //조치
    if (state.currentaddress == null) {
      var geolocation = Geolocator();
      String currentaddressstr = "";
      try {
        List<Placemark> currentaddress = await geolocation
            .placemarkFromCoordinates(position.latitude, position.longitude,
                localeIdentifier: "ko");
        if (currentaddress.length > 0) {
          currentaddressstr += currentaddress[0].administrativeArea +
              " " +
              currentaddress[0].thoroughfare;
        }
        state.currentaddress = currentaddressstr;
      } catch (ex) {
        print(ex);
      }
    }
  }

  //여기서 CurrentPosition을 업데이트 해준다.
  updateCubeListupdatedistancewithme(Position position) async {
    await state.fcubeListUtil.updatecubedistancewithme(position);
  }

  updatePlayViewCubeListupdatedistancewithme(Position position) async {
    await state.fcubeplayerListUtil.updatecubedistancewithme(position);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }
}

class _InheritedStateContainer extends InheritedWidget {
  final _GlobalStateContainerState data;
  _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedStateContainer old) {
    return true;
  }
}

class GlobalState {
  UserInfoMain userInfoMain;
  bool isnewuser = false;
  Position currentposition;
  String currentaddress;
  FcubeListUtil fcubeListUtil = FcubeListUtil();
  FcubeListUtil fcubeplayerListUtil = FcubeListUtil();
  CameraPosition mainInitialCameraPosition =
      new CameraPosition(target: LatLng(37.550991, 126.990861), zoom: 16);

  GlobalState({
    this.userInfoMain,
  });

  factory GlobalState.loading() =>
      new GlobalState(userInfoMain: new UserInfoMain());
}
