import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:forutonafront/Common/LoadingOverlay.dart';
import 'package:forutonafront/Common/marker_generator.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/MakePage/Component/Fcube.dart';
import 'package:forutonafront/MakePage/FcubeTypes.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/loading.dart';

class IM001MainStep1 extends StatefulWidget {
  IM001MainStep1({this.selectfcube, Key key}) : super(key: key);
  final Fcube selectfcube;

  @override
  _IM001MainStep1State createState() {
    return _IM001MainStep1State(selectfcube: selectfcube);
  }
}

class _IM001MainStep1State extends State<IM001MainStep1> {
  _IM001MainStep1State({this.selectfcube});
  Fcube selectfcube;
  bool iscomplete;
  CameraPosition _kInitialPosition;
  Map<FcubeType, Uint8List> markeritem = Map<FcubeType, Uint8List>();
  Set<Marker> markers;
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  bool isLoading = false;
  FocusNode titlenodefocus = FocusNode();
  FocusNode contentnodefocus = FocusNode();
  bool backgroundblock = false;
  bool iskeyboardshow = false;
  @override
  void initState() {
    super.initState();
    _kInitialPosition = CameraPosition(
      target: LatLng(selectfcube.latitude, selectfcube.longitude),
      zoom: 16.0,
    );
    markers = Set<Marker>();
    List<Widget> markerwidget = List<Widget>();
    markerwidget.add(getMakerWidget(FcubeType.questCube));
    markerwidget.add(getMakerWidget(FcubeType.issuecube));
    MarkerGenerator(markerwidget, (bitmaps) {
      bitmaps.asMap().forEach((i, bmp) {
        if (i == 0) {
          markeritem[FcubeType.questCube] = bmp;
        } else if (i == 1) {
          markeritem[FcubeType.issuecube] = bmp;
        }
      });
      initMakers();
    }).generate(context);
    titlenodefocus.addListener(() {
      setState(() {});
    });
    contentnodefocus.addListener(() {
      setState(() {});
    });
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        setState(() {
          this.iskeyboardshow = visible;
        });
      },
    );
  }

  initMakers() {
    markers.add(new Marker(
        anchor: Offset(0.5, 0.5),
        markerId: MarkerId(selectfcube.cubeuuid),
        icon: BitmapDescriptor.fromBytes(markeritem[selectfcube.cubetype]),
        position: LatLng(selectfcube.latitude, selectfcube.longitude)));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final GoogleMap googleMap = GoogleMap(
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
        new Factory<OneSequenceGestureRecognizer>(
          () => new EagerGestureRecognizer(),
        ),
      ].toSet(),
      initialCameraPosition: _kInitialPosition,
      markers: markers,
    );
    AppBar appbar = AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
            child: Row(children: <Widget>[
          Expanded(
              child: Container(
                  child: Text("이슈볼 만들기",
                      style: TextStyle(
                        fontFamily: "Noto Sans CJK KR",
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Color(0xff454f63),
                      )))),
          isVaildCheck()
              ? Container(
                  height: 36.00,
                  width: 78.00,
                  child: FlatButton(
                    onPressed: () {},
                    child: Text("완료",
                        style: TextStyle(
                          fontFamily: "Noto Sans CJK KR",
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color(0xff39f999),
                        )),
                  ),
                  decoration: BoxDecoration(
                      color: Color(0xff454f63),
                      border: Border.all(
                        width: 2.00,
                        color: Color(0xff39f999),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0.00, 3.00),
                          color: Color(0xff000000).withOpacity(0.16),
                          blurRadius: 6,
                        )
                      ],
                      borderRadius: BorderRadius.circular(30.00)),
                )
              : Container(
                  height: 36.00,
                  width: 78.00,
                  child: FlatButton(
                    onPressed: () {},
                    child: Text("완료",
                        style: TextStyle(
                          fontFamily: "Noto Sans CJK KR",
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color(0xff999999),
                        )),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xffe4e7e8),
                    border: Border.all(
                      width: 2.00,
                      color: Color(0xffcccccc),
                    ),
                    borderRadius: BorderRadius.circular(30.00),
                  ))
        ])));

    return LoadingOverlay(
        isLoading: isLoading,
        progressIndicator: Loading(
            indicator: BallScaleIndicator(),
            size: 100.0,
            color: Theme.of(context).accentColor),
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: appbar.preferredSize.height),
                  child: ListView(shrinkWrap: true, children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(bottom: 16),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Stack(children: <Widget>[
                          googleMap,
                          Positioned(
                              bottom: 0,
                              child: Container(
                                  alignment: Alignment.center,
                                  color: Color(0xffffffff).withOpacity(0.70),
                                  height: 46,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.location_on,
                                          color: Color(0xff78849E),
                                          size: 20,
                                        ),
                                        Text("${selectfcube.placeaddress}",
                                            style: TextStyle(
                                              fontFamily: "Noto Sans CJK KR",
                                              fontSize: 14,
                                              color: Color(0xff454f63),
                                            )),
                                      ])))
                        ])),
                    Container(
                      margin: EdgeInsets.fromLTRB(16, 0, 0, 8),
                      child: Text("제목",
                          style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: titlenodefocus.hasFocus
                                ? Color(0xff3497FD)
                                : Color(0xff454f63),
                          )),
                    ),
                    Container(
                        child: TextFormField(
                      focusNode: titlenodefocus,
                      decoration: InputDecoration(
                        hintText: "제목을 지어주세요!",
                        hintStyle: TextStyle(
                          fontFamily: "Noto Sans CJK KR",
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color(0xffe4e7e8),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffE4E7E8)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffE4E7E8)),
                        ),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffE4E7E8))),
                      ),
                      controller: titleController,
                      onChanged: (value) {
                        setState(() {});
                      },
                      maxLength: 50,
                      maxLines: 1,
                    )),
                    Container(
                      margin: EdgeInsets.fromLTRB(16, 0, 0, 8),
                      child: Text("내용",
                          style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: contentnodefocus.hasFocus
                                ? Color(0xff3497FD)
                                : Color(0xff454f63),
                          )),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          hintText: "어떤 이슈인가요?",
                          hintStyle: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Color(0xffe4e7e8),
                          ),
                          contentPadding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffE4E7E8)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffE4E7E8)),
                          ),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffE4E7E8))),
                        ),
                        controller: contentController,
                        focusNode: contentnodefocus,
                        minLines: null,
                        maxLines: null,
                        maxLength: 5000,
                      ),
                    )
                  ])),
              Positioned(
                  top: 0,
                  height: appbar.preferredSize.height +
                      MediaQuery.of(context).padding.top,
                  width: MediaQuery.of(context).size.width,
                  child: appbar),
              iskeyboardshow
                  ? Container()
                  : Positioned(
                      bottom: 0,
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                          margin: EdgeInsets.only(left: 16),
                          decoration: BoxDecoration(
                            color: Color(0xffffffff).withOpacity(0.90),
                            border: Border.all(
                              width: 0.50,
                              color: Color(0xffe4e7e8).withOpacity(0.90),
                            ),
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(right: 16),
                                  height: 42.00,
                                  width: 42.00,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffee9acf),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0.00, 3.00),
                                          color: Color(0xff000000)
                                              .withOpacity(0.16),
                                          blurRadius: 6,
                                        )
                                      ])),
                              Container(
                                  margin: EdgeInsets.only(right: 16),
                                  height: 42.00,
                                  width: 42.00,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xff8382F2),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0.00, 3.00),
                                          color: Color(0xff000000)
                                              .withOpacity(0.16),
                                          blurRadius: 6,
                                        )
                                      ])),
                              Container(
                                  margin: EdgeInsets.only(right: 16),
                                  height: 42.00,
                                  width: 42.00,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xff88D4F1),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0.00, 3.00),
                                          color: Color(0xff000000)
                                              .withOpacity(0.16),
                                          blurRadius: 6,
                                        )
                                      ]))
                            ],
                          ))),
              backgroundblock
                  ? Container(
                      color: Color(0xff454F63).withOpacity(0.5),
                    )
                  : Container(),
            ],
          ),
        ));
  }

  isVaildCheck() {
    if (this.titleController.text.length > 0 &&
        this.contentController.text.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  Widget getMakerWidget(FcubeType cubetype) {
    if (cubetype == FcubeType.questCube) {
      return Container(
          alignment: Alignment.center,
          child: Container(
            height: 35.00,
            width: 35.00,
            decoration: BoxDecoration(
              color: Color(0xff4f72ff),
              shape: BoxShape.circle,
            ),
            child: Icon(
              ForutonaIcon.quest,
              size: 20,
              color: Colors.white,
            ),
          ),
          height: 92.00,
          width: 92.00,
          decoration: BoxDecoration(
            color: Color(0xff39f999).withOpacity(0.17),
            boxShadow: [
              BoxShadow(
                offset: Offset(0.00, 4.00),
                color: Color(0xff321636).withOpacity(0.04),
                blurRadius: 12,
              ),
            ],
            shape: BoxShape.circle,
          ));
    } else if (cubetype == FcubeType.issuecube) {
      return Container(
          alignment: Alignment.center,
          child: Container(
            height: 35.00,
            width: 35.00,
            padding: EdgeInsets.only(left: 3),
            decoration: BoxDecoration(
              color: Color(0xffdc3e57),
              shape: BoxShape.circle,
            ),
            child: Icon(
              ForutonaIcon.issue,
              size: 20,
              color: Colors.white,
            ),
          ),
          height: 92.00,
          width: 92.00,
          decoration: BoxDecoration(
            color: Color(0xff39f999).withOpacity(0.17),
            boxShadow: [
              BoxShadow(
                offset: Offset(0.00, 4.00),
                color: Color(0xff321636).withOpacity(0.04),
                blurRadius: 12,
              ),
            ],
            shape: BoxShape.circle,
          ));
    } else {
      return Container();
    }
  }
}
