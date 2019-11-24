import 'package:flutter/material.dart';
import 'package:forutonafront/Auth/UserInfoMain.dart';
import 'package:forutonafront/MakePage/Component/FcubeExtender1.dart';
import 'package:forutonafront/MakePage/Component/FcubeListUtil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:search_map_place/search_map_place.dart';

class GolobalStateContainer extends StatefulWidget {
  final Widget child;
  GolobalStateContainer({@required this.child});

  static _GolobalStateContainerState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedStateContainer)
            as _InheritedStateContainer)
        .data;
  }

  @override
  _GolobalStateContainerState createState() => _GolobalStateContainerState();
}

class _GolobalStateContainerState extends State<GolobalStateContainer> {
  GlobalState state = new GlobalState();

  @override
  void initState() {
    super.initState();
  }

  setfcubeListUtilisLoading(bool value) {
    setState(() {
      state.fcubeListUtil.isLoading = value;
    });
  }

  addfcubeListUtilcubeList(List<FcubeExtender1> value) {
    setState(() {
      state.fcubeListUtil.cubeList.addAll(value);
    });
  }

  addfcubeListUtilcube(FcubeExtender1 value) {
    setState(() {
      state.fcubeListUtil.cubeList.add(value);
    });
  }

  resetcubeListUtilcubeList() {
    setState(() {
      state.fcubeListUtil.cubeList.clear();
    });
  }

  updateCurrnetPosition(Position position) {
    state.currentposition = position;
    setState(() {});
  }

  updateCurrentAddress(Position position) async {
    //만약에 currentpostion이 null 일 때만 1번만 GeoGcoding을 사용한다 GoogleMapAPi 가격 상승에 따른
    //조치
    if (state.currentaddress == null) {
      var geolocation = Geolocator();
      String currentaddressstr = "";
      List<Placemark> currentaddress = await geolocation
          .placemarkFromCoordinates(position.latitude, position.longitude,
              localeIdentifier: "ko");
      if (currentaddress.length > 0) {
        currentaddressstr += currentaddress[0].administrativeArea +
            " " +
            currentaddress[0].thoroughfare;
      }
      state.currentaddress = currentaddressstr;
      setState(() {});
    }
  }

  //여기서 CurrentPosition을 업데이트 해준다.
  updateCubeListupdatedistancewithme(Position position) async {
    await state.fcubeListUtil.updatecubedistancewithme(position);

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
  final _GolobalStateContainerState data;
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

  GlobalState({
    this.userInfoMain,
  });

  factory GlobalState.loading() =>
      new GlobalState(userInfoMain: new UserInfoMain());
}
