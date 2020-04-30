import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePageView extends StatefulWidget {
  HomePageView({Key key}) : super(key: key);

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  static const MethodChannel platform =
      MethodChannel('com.wing.forutonafront/service');
  FirebaseUser user;
  IdTokenResult token;
  @override
  void initState() {
    super.initState();
    inits();
  }

  inits() async {
    user = await FirebaseAuth.instance.currentUser();
    token = await user.getIdToken(refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          RaisedButton(
              onPressed: () async {
                await platform.invokeMethod<void>('connectservice');
                print('Connected to service');
              },
              child: Text("connect")),
          RaisedButton(
              onPressed: () async {
                List<String> args = List<String>();
                args.add(user.uid);
                args.add(token.token);
                await platform.invokeMethod<void>('startLocationManager', args);
                print('startLocationManager');
              },
              child: Text("startLocationManager")),
          RaisedButton(
              onPressed: () async {
                await platform.invokeMethod<void>('stopLocationManager');
                print('stopLocationManager');
              },
              child: Text("stopLocationManager")),
          RaisedButton(
              onPressed: () async {
                await platform.invokeMethod<void>('stopService');
                print('stopService');
              },
              child: Text("stopservice")),
          // RaisedButton(
          //   onPressed: () async {
          //     var image = await ImagePicker.pickImage(
          //         source: ImageSource.gallery, maxHeight: 150, maxWidth: 150);
          //     print(image.path);
          //   },
          //   child: Text("test"),
          // )
        ],
      ),
    );
  }
}
