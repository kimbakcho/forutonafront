import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Page/HCodePage/H007/H007BackButton.dart';

import 'package:forutonafront/Page/HCodePage/H007/H007MainPageViewModel.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'H007AddressWidget.dart';
import 'H007BallSearchBtn.dart';
import 'H007MyLocationMoveBtn.dart';
import 'MapCenterExpendCircle.dart';

// ignore: must_be_immutable
class H007MainPage extends StatefulWidget {
  final Position initPosition;
  String address;
  H007Listener h007listener;

  H007MainPage({this.initPosition, this.address,this.h007listener});

  @override
  _H007MainPageState createState() => _H007MainPageState(initPosition, address);
}

class _H007MainPageState extends State<H007MainPage>
    with WidgetsBindingObserver {
  Position initPosition;
  String address;

  UniqueKey googleMapKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    googleMapKey = UniqueKey();
    setState(() {});
  }

  _H007MainPageState(this.initPosition, this.address);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => H007MainPageViewModel(
            geoLocationUtilUseCaseInputPort: sl(),
            h007listener: widget.h007listener,
            context: context,
            address: address,
            initPosition: initPosition),
        child: Consumer<H007MainPageViewModel>(builder: (_, model, child) {
          return Scaffold(
              body: Stack(children: <Widget>[
            GoogleMap(
              key: googleMapKey,
              initialCameraPosition: model.initCameraPosition,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              onMapCreated: model.onMapCreate,
              onCameraMove: model.onCameraMove,
              onCameraIdle: model.onMapIdle,
              zoomControlsEnabled: false,
            ),
            Positioned(
                top: MediaQuery.of(context).padding.top + 16,
                left: 16,
                child: H007BackButton()),
            Positioned(
                top: MediaQuery.of(context).padding.top + 16,
                left: 68,
                child: H007AddressWidget(
                  address: model.address,
                  placeListFromSearchTextWidgetListener: model,
                  key: Key(model.address),
                )),
            Positioned(
              top: MediaQuery.of(context).padding.top + 16,
              right: 16,
              child:
                  model.cameraMoveFlag ? H007MyLocationMoveBtn(
                    onGoMyLocation: model.onMyLocation,

                  ) : Container(),
            ),
            IgnorePointer(
              child: MapCenterExpendCircle(),
            ),
            Positioned(
              bottom: 24,
              left: 16,
              child: H007BallSearchBtn(
                onSearch: model.onSearch,
              ),
            ),
            Center(child: H007CenterPoint())
          ]));
        }));
  }
}

class H007CenterPoint extends StatelessWidget {
  const H007CenterPoint({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
        child: Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xff454F63),
      ),
    ));
  }
}

abstract class H007Listener {
  onH007SearchPosition(Position position,BuildContext context);
}