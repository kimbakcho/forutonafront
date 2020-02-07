import 'package:after_init/after_init.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/PlayPage/D001EagerGestureRecognizer.dart';
import 'package:forutonafront/globals.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class D001PlayPageView extends StatefulWidget {
  D001PlayPageView({Key key}) : super(key: key);

  @override
  _D001PlayPageViewState createState() => _D001PlayPageViewState();
}

class _D001PlayPageViewState extends State<D001PlayPageView>
    with AfterInitMixin {
  CameraPosition _kInitialPosition;
  Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;
  D001EagerGestureRecognizer d001eagerGestureRecognizer;

  Color backgroundColor = Color(0x00000000);
  @override
  void initState() {
    super.initState();
    d001eagerGestureRecognizer = new D001EagerGestureRecognizer(
        duration: Duration(seconds: 1), onLongPress: ongoogleMapBlocklongPress);
    gestureRecognizers = Set()
      ..add(Factory<D001EagerGestureRecognizer>(
          () => d001eagerGestureRecognizer));
  }

  @override
  void didInitState() {
    Position currentposition =
        GlobalStateContainer.of(context).state.currentposition;
    _kInitialPosition = CameraPosition(
        target: LatLng(currentposition.latitude, currentposition.longitude),
        zoom: 16);
  }

  ongoogleMapBlocklongPress() {
    
  }

  @override
  Widget build(BuildContext context) {
    final GoogleMap googleMap = GoogleMap(
      gestureRecognizers: gestureRecognizers,
      initialCameraPosition: _kInitialPosition,
    );
    return Scaffold(
      body: Container(
        child: SlidingUpPanel(
          panel: Container(
            child: Text("123"),
          ),
          body: Stack(
            children: <Widget>[googleMap],
          ),
        ),
      ),
    );
  }
}
