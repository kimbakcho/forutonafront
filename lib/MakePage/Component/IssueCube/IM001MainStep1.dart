import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Common/FcubeDescription.dart';
import 'package:forutonafront/Common/LoadingOverlay.dart';
import 'package:forutonafront/Common/YoutubeWidget2.dart';
import 'package:forutonafront/Common/marker_generator.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/MakePage/Component/Fcube.dart';
import 'package:forutonafront/MakePage/FcubeTypes.dart';
import 'package:forutonafront/MakePage/Fcubecontent.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/loading.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:youtube_parser/youtube_parser.dart';

class IM001MainController {
  FocusNode titlenodefocus;
  FocusNode contentnodefocus;
  bool imagepicktogle = false;
  ScrollController mainScrollController;
}

class IM001MainStep1 extends StatefulWidget {
  IM001MainStep1({this.selectfcube, Key key}) : super(key: key);
  final Fcube selectfcube;

  @override
  _IM001MainStep1State createState() {
    return _IM001MainStep1State(selectfcube: selectfcube);
  }
}

class _IM001MainStep1State extends State<IM001MainStep1> with AfterLayoutMixin {
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
  List<Uint8List> attachimglist = List<Uint8List>();
  IM001MainController im001mainController = IM001MainController();
  bool youtubetogle = false;
  bool tagtogle = false;
  String youtubeurl = "";
  Timer clipboardchecktimer;
  String oldclipboarddata = "";
  String currentclipboarddata = "";
  String videoId = "";

  List<Chip> chips = new List<Chip>();
  FocusNode tagnodefocus = FocusNode();
  ScrollController mainScrollController = ScrollController();

  TextEditingController tagcontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    im001mainController.contentnodefocus = contentnodefocus;
    im001mainController.titlenodefocus = titlenodefocus;
    im001mainController.mainScrollController = mainScrollController;
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
    clipboardchecktimer = Timer.periodic(Duration(seconds: 2), (timer) async {
      ClipboardData clipboarddata = await Clipboard.getData("text/plain");
      currentclipboarddata = clipboarddata.text.trim();
      if (youtubetogle) {
        if (oldclipboarddata != currentclipboarddata) {
          oldclipboarddata = currentclipboarddata;
          setState(() {});
        }
      }
    });
  }

  @override
  void afterFirstLayout(BuildContext context) async {}

  bool isyoutubevideourl(String url) {
    if (url.indexOf("https://www.youtube.com/watch?v=") == 0) {
      return true;
    } else if (url.indexOf("https://youtu.be/") == 0) {
      return true;
    } else {
      return false;
    }
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
  void dispose() {
    super.dispose();
    clipboardchecktimer.cancel();
  }

  remoteRender() {
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
                    onPressed: () async {
                      isLoading = true;
                      setState(() {});

                      selectfcube.cubename = titleController.text;
                      selectfcube.cubestate = FcubeState.play;

                      if (await selectfcube.makecube() > 0) {}
                      List<Desimage> desimage = List<Desimage>();
                      for (int i = 0; i < attachimglist.length; i++) {
                        String uploadurl =
                            await FcubeDescription.cuberelationimageupload(
                                attachimglist[i]);
                        print(uploadurl);
                        desimage.add(Desimage(index: i, src: uploadurl));
                      }
                      List<String> tags = List<String>();
                      chips.forEach((item1) {
                        Text wtext = item1.label as Text;
                        tags.add(wtext.data);
                      });

                      FcubeDescription description = FcubeDescription(
                          desimages: desimage,
                          havemodify: false,
                          tags: tags,
                          text: contentController.text,
                          writetime: DateTime.now().toUtc(),
                          youtubeVideoid: videoId);
                      Fcubecontent content = Fcubecontent(
                          contenttype: FcubecontentType.description,
                          contentupdatetime: DateTime.now(),
                          contentvalue: description.toRawJson(),
                          cubeuuid: selectfcube.cubeuuid);
                      if (await content.makecubecontent() > 0) {
                        Navigator.of(context).popUntil((value) {
                          if (value.settings.name == "BCD001") {
                            return true;
                          } else {
                            return false;
                          }
                        });
                      }

                      isLoading = false;
                      setState(() {});
                    },
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
                  margin: EdgeInsets.only(
                      top: appbar.preferredSize.height, bottom: 58),
                  child: ListView(
                      controller: mainScrollController,
                      shrinkWrap: true,
                      children: <Widget>[
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
                                      color:
                                          Color(0xffffffff).withOpacity(0.70),
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
                                                  fontFamily:
                                                      "Noto Sans CJK KR",
                                                  fontSize: 14,
                                                  color: Color(0xff454f63),
                                                )),
                                          ])))
                            ])),
                        Container(
                          margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
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
                            counterText: "",
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
                                borderSide:
                                    BorderSide(color: Color(0xffE4E7E8))),
                          ),
                          controller: titleController,
                          onChanged: (value) {
                            setState(() {});
                          },
                          maxLength: 50,
                          maxLines: 1,
                        )),
                        Container(
                          margin: EdgeInsets.fromLTRB(16, 16, 0, 0),
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
                              counterText: "",
                              hintText: "어떤 이슈인가요?",
                              hintStyle: TextStyle(
                                fontFamily: "Noto Sans CJK KR",
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Color(0xffe4e7e8),
                              ),
                              contentPadding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffE4E7E8)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffE4E7E8)),
                              ),
                              border: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffE4E7E8))),
                            ),
                            controller: contentController,
                            focusNode: contentnodefocus,
                            minLines: null,
                            maxLines: null,
                            maxLength: 5000,
                          ),
                        ),
                        attachimglist.length != 0
                            ? ImageListPanel(
                                attachimglist: attachimglist,
                                remoterander: remoteRender)
                            : Container(),
                        youtubetogle ? youtubePanel() : Container(),
                        tagtogle
                            ? TagWidget(
                                tagnodefocus: tagnodefocus,
                                tagcontroller: tagcontroller,
                                chips: chips,
                                remoterander: remoteRender,
                              )
                            : Container()
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
                          decoration: BoxDecoration(
                            color: Color(0xffffffff).withOpacity(0.90),
                            border: Border.all(
                              width: 0.50,
                              color: Color(0xffe4e7e8).withOpacity(0.90),
                            ),
                          ),
                          child: Row(children: <Widget>[
                            SizedBox(
                              width: 16,
                            ),
                            PicktureAddButton(
                              attachimglist: attachimglist,
                              remoterander: remoteRender,
                              im001controller: im001mainController,
                            ),
                            Container(
                                margin: EdgeInsets.only(right: 16),
                                height: 42.00,
                                width: 42.00,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 3),
                                  child: Icon(
                                    ForutonaIcon.videoattach,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  shape: CircleBorder(),
                                  onPressed: () {
                                    titlenodefocus.unfocus();
                                    contentnodefocus.unfocus();
                                    youtubetogle = true;
                                    mainScrollController.animateTo(
                                        mainScrollController
                                                .position.maxScrollExtent +
                                            100,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.linear);
                                    setState(() {});
                                  },
                                ),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff8382F2),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0.00, 3.00),
                                        color:
                                            Color(0xff000000).withOpacity(0.16),
                                        blurRadius: 6,
                                      )
                                    ])),
                            Container(
                                margin: EdgeInsets.only(right: 16),
                                height: 42.00,
                                width: 42.00,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 3),
                                  child: Icon(
                                    ForutonaIcon.tagadd,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  shape: CircleBorder(),
                                  onPressed: () {
                                    tagtogle = !tagtogle;
                                    mainScrollController.animateTo(
                                        mainScrollController
                                                .position.maxScrollExtent +
                                            100,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.linear);
                                    setState(() {});
                                  },
                                ),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff88D4F1),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0.00, 3.00),
                                        color:
                                            Color(0xff000000).withOpacity(0.16),
                                        blurRadius: 6,
                                      )
                                    ]))
                          ]))),
              backgroundblock
                  ? Container(
                      color: Color(0xff454F63).withOpacity(0.5),
                    )
                  : Container(),
              im001mainController.imagepicktogle
                  ? Positioned(
                      child: GestureDetector(
                          onTap: () {
                            im001mainController.imagepicktogle =
                                !im001mainController.imagepicktogle;
                            setState(() {});
                          },
                          child: Container(
                              color: Color(0xff454F63).withOpacity(0.5),
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width)))
                  : Container(),
              im001mainController.imagepicktogle
                  ? Positioned(
                      bottom: 76,
                      left: 37,
                      height: 70,
                      width: 180,
                      child: Container(
                        height: 70.00,
                        width: 180.00,
                        child: Row(children: [
                          Container(
                            width: 88,
                            height: 70,
                            child: FlatButton(
                              onPressed: () async {
                                if (attachimglist.length < 20) {
                                  File imgfile = await ImagePicker.pickImage(
                                      source: ImageSource.camera);
                                  attachimglist
                                      .add(await imgfile.readAsBytes());
                                  im001mainController.imagepicktogle =
                                      !im001mainController.imagepicktogle;
                                  setState(() {});
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "이미지 20장을 모두 첨부하였습니다.",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIos: 1,
                                      backgroundColor: Color(0xff454F63),
                                      textColor: Colors.white,
                                      fontSize: 12.0);
                                }
                              },
                              child: Text("카메라",
                                  style: TextStyle(
                                    fontFamily: "Noto Sans CJK KR",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    color: Color(0xffc1549a),
                                  )),
                            ),
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        width: 1, color: Color(0xffC1549A)))),
                          ),
                          Container(
                            width: 88,
                            child: FlatButton(
                              onPressed: () async {
                                List<Asset> resultList =
                                    await MultiImagePicker.pickImages(
                                  maxImages: 20 - attachimglist.length,
                                  cupertinoOptions:
                                      CupertinoOptions(takePhotoIcon: "chat"),
                                  materialOptions: MaterialOptions(
                                    actionBarColor: "#abcdef",
                                    actionBarTitle: "이슈 큐브 이미지",
                                    allViewTitle: "이슈 큐브 이미지",
                                    useDetailsView: false,
                                    selectCircleStrokeColor: "#000000",
                                  ),
                                );
                                for (int i = 0; i < resultList.length; i++) {
                                  ByteData imgdata =
                                      await resultList[i].getByteData();
                                  attachimglist
                                      .add(imgdata.buffer.asUint8List());
                                }
                                im001mainController.imagepicktogle =
                                    !im001mainController.imagepicktogle;
                                setState(() {});
                              },
                              child: Text("사진 선택",
                                  style: TextStyle(
                                    fontFamily: "Noto Sans CJK KR",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    color: Color(0xffc1549a),
                                  )),
                            ),
                          )
                        ]),
                        decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          border: Border.all(
                            width: 1.00,
                            color: Color(0xffc1549a),
                          ),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0.00, 3.00),
                                color: Color(0xff000000).withOpacity(0.16),
                                blurRadius: 6)
                          ],
                          borderRadius: BorderRadius.circular(12.00),
                        ),
                      ))
                  : Container()
            ],
          ),
        ));
  }

  Container youtubePanel() {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text("YOUTUBE 동영상 첨부",
                  style: TextStyle(
                    fontFamily: "Noto Sans CJK KR",
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Color(0xff454f63),
                  )),
            ),
            Row(children: <Widget>[
              Expanded(
                  child: Container(
                margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: youtubeurl.length == 0
                    ? Text("동영상 링크를 복사해서 붙어넣기 하세요.",
                        style: TextStyle(
                          fontFamily: "Noto Sans CJK KR",
                          fontSize: 13,
                          color: Color(0xff78849e),
                        ))
                    : Text("$youtubeurl",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "Noto Sans CJK KR",
                          fontSize: 13,
                          color: Color(0xff78849e),
                        )),
              )),
              youtubeurl.length != 0
                  ? Container(
                      height: 27.00,
                      width: 61.00,
                      child: FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          youtubeurl = "";
                          videoId = "";
                          setState(() {});
                        },
                        child: Text("삭제",
                            style: TextStyle(
                              fontFamily: "Noto Sans CJK KR",
                              fontWeight: FontWeight.w700,
                              fontSize: 11,
                              color: Color(0xffffffff),
                            )),
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xffFF4F9A),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0.00, 3.00),
                            color: Color(0xff000000).withOpacity(0.16),
                            blurRadius: 6,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(13.00),
                      ))
                  : Container(
                      height: 27.00,
                      width: 61.00,
                      child: FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () async {
                          if (isyoutubevideourl(currentclipboarddata)) {
                            youtubeurl = currentclipboarddata;
                            isLoading = true;
                            setState(() {});
                            videoId = getIdFromUrl(youtubeurl);
                            isLoading = false;
                            setState(() {});
                          } else {
                            Fluttertoast.showToast(
                                msg: "유효한 유튜브 링크가 아닙니다.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIos: 1,
                                backgroundColor: Color(0xff454F63),
                                textColor: Colors.white,
                                fontSize: 12.0);
                          }
                        },
                        child: currentclipboarddata.length != 0
                            ? Text("붙혀넣기",
                                style: TextStyle(
                                  fontFamily: "Noto Sans CJK KR",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11,
                                  color: Color(0xffffffff),
                                ))
                            : Text("붙혀넣기",
                                style: TextStyle(
                                  fontFamily: "Noto Sans CJK KR",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11,
                                  color: Color(0xffcccccc),
                                )),
                      ),
                      decoration: BoxDecoration(
                        color: currentclipboarddata.length != 0
                            ? Color(0xff8382F2)
                            : Color(0xffE4E7E8),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0.00, 3.00),
                            color: Color(0xff000000).withOpacity(0.16),
                            blurRadius: 6,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(13.00),
                      ))
            ]),
            videoId.length != 0
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(bottom: 16),
                    child: YoutubeWidget2(
                      id: videoId,
                    ),
                  )
                : Container()
          ]),
    );
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

class TagWidget extends StatelessWidget {
  const TagWidget(
      {Key key,
      @required this.tagnodefocus,
      @required this.tagcontroller,
      @required this.chips,
      @required this.remoterander})
      : super(key: key);

  final FocusNode tagnodefocus;
  final TextEditingController tagcontroller;
  final List<Chip> chips;
  final Function remoterander;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Text("#태그",
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: tagnodefocus.hasFocus
                      ? Color(0xff3497fd)
                      : Color(0xff454f63),
                ))),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: TextFormField(
              focusNode: tagnodefocus,
              controller: tagcontroller,
              onChanged: (value) {
                if (value.indexOf(",") > 0) {
                  addchip(chips, value.replaceAll(",", ""));
                  tagcontroller.clear();
                  remoterander();
                }
              },
              onFieldSubmitted: (value) {
                addchip(chips, value);
                tagcontroller.clear();
                remoterander();
              },
              decoration: InputDecoration(
                  labelStyle: TextStyle(
                    fontFamily: "Noto Sans CJK KR",
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Color(0xff3497fd),
                  ),
                  hintText: "태그를 입력해 주세요(000, 로 구분합니다.)",
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
                      borderSide: BorderSide(color: Color(0xffE4E7E8))))),
        ),
        Container(
            margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Wrap(
              spacing: 10,
              children: chips,
            ))
      ],
    );
  }

  addchip(List<Chip> chips, String value) {
    int index = chips.indexWhere((item) {
      Text itemtext = item.label as Text;
      if (itemtext.data == value) {
        return true;
      } else {
        return false;
      }
    });
    if (index >= 0) {
      return;
    }

    chips.add(Chip(
      label: Text(value),
      padding: EdgeInsets.fromLTRB(14, 0, 14, 0),
      onDeleted: () {
        chips.removeWhere((item) {
          Text itemtext = item.label as Text;
          if (itemtext.data == value) {
            return true;
          } else {
            return false;
          }
        });
        remoterander();
      },
      deleteIcon: Container(
        height: 14.00,
        width: 14.00,
        child: Icon(
          Icons.close,
          color: Color(0xffFF4F9A),
          size: 10,
        ),
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          border: Border.all(
            width: 1.00,
            color: Color(0xffff4f9a),
          ),
          shape: BoxShape.circle,
        ),
      ),
    ));
  }
}

class ImageListPanel extends StatelessWidget {
  const ImageListPanel(
      {Key key, @required this.attachimglist, this.remoterander})
      : super(key: key);
  final Function remoterander;
  final List<Uint8List> attachimglist;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                      child: Text("이미지",
                          style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Color(0xff454f63),
                          )))),
              Text("${attachimglist.length}/20",
                  style: TextStyle(
                    fontFamily: "Noto Sans CJK KR",
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: attachimglist.length == 20
                        ? Color(0xffFF4F9A)
                        : Color(0xffB1B1B1),
                  ))
            ],
          ),
          Container(
              height: 66,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: attachimglist.length,
                  itemBuilder: (context, index) {
                    return Container(
                        width: 79,
                        height: 66,
                        child: Stack(children: <Widget>[
                          Positioned(
                              bottom: 0,
                              left: 0,
                              child: Container(
                                  height: 62.00,
                                  width: 75.00,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            MemoryImage(attachimglist[index]),
                                        fit: BoxFit.fitWidth),
                                    borderRadius: BorderRadius.circular(12.00),
                                  ))),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              height: 14.00,
                              width: 14.00,
                              child: FlatButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  attachimglist.removeAt(index);
                                  remoterander();
                                },
                                child: Icon(
                                  Icons.close,
                                  size: 8,
                                  color: Color(0xffFF4F9A),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                                border: Border.all(
                                  width: 1.00,
                                  color: Color(0xffff4f9a),
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                          )
                        ]));
                  }))
        ]));
  }
}

class PicktureAddButton extends StatelessWidget {
  const PicktureAddButton(
      {Key key,
      @required this.attachimglist,
      this.remoterander,
      this.im001controller})
      : super(key: key);
  final Function remoterander;
  final List<Uint8List> attachimglist;
  final IM001MainController im001controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FlatButton(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 3),
          child: Icon(
            ForutonaIcon.camera,
            color: Colors.white,
            size: 18,
          ),
          shape: CircleBorder(),
          onPressed: () async {
            im001controller.titlenodefocus.unfocus();
            im001controller.contentnodefocus.unfocus();
            im001controller.imagepicktogle = !im001controller.imagepicktogle;
            im001controller.mainScrollController.animateTo(
                im001controller.mainScrollController.position.maxScrollExtent +
                    100,
                duration: Duration(milliseconds: 500),
                curve: Curves.linear);
            remoterander();
          },
        ),
        margin: EdgeInsets.only(right: 16),
        height: 42.00,
        width: 42.00,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffee9acf),
            boxShadow: [
              BoxShadow(
                offset: Offset(0.00, 3.00),
                color: Color(0xff000000).withOpacity(0.16),
                blurRadius: 6,
              )
            ]));
  }
}
