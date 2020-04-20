import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Common/Tag/Dto/TagInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallDesImagesDto.dart';
import 'package:forutonafront/FBall/Dto/FBallInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallType.dart';
import 'package:forutonafront/FBall/Dto/IssueBallDescriptionDto.dart';
import 'package:forutonafront/FBall/MarkerSupport/Style2/FBallResForMarkerStyle2Dto.dart';
import 'package:forutonafront/FBall/MarkerSupport/Style2/MakerSupportStyle2.dart';
import 'package:forutonafront/FBall/Repository/FBallRepository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:youtube_parser/youtube_parser.dart';

import 'BallImageItemDto.dart';

class IM001MainPageViewModel extends ChangeNotifier {
  final BuildContext _context;
  final LatLng _setUpPosition;
  String _ballUuid;
  Timer _clipBoardCheckTimer;

  //볼에 레이더 애니메이션을 주기위한 Ticker
  Ticker _ticker;

  final String address;
  String currentClipBoardData;
  String validYoutubeLink;
  GlobalKey makerAnimationKey = new GlobalKey();

  //googleMap
  CameraPosition initCameraPosition;
  Set<Marker> markers = Set<Marker>();

  //Focus
  FocusNode tagEditFocusNode = FocusNode();
  FocusNode titleFocusNode = FocusNode();
  FocusNode textContentFocusNode = FocusNode();

  //WidgetController
  TextEditingController textContentEditController = TextEditingController();
  TextEditingController titleEditController = TextEditingController();
  ScrollController mainScrollController = ScrollController();
  TextEditingController tagEditController = new TextEditingController();

  //WidgetList
  List<BallImageItemDto> ballImageList = [];
  List<Chip> tagChips = [];
  List<FBallResForMarkerStyle2Dto> ballList;

  //Flag
  bool keyboardVisibility = false;
  bool youtubeAttachVisibility = false;
  bool tagBarVisibility = false;

  //Repository
  FBallRepository _fBallRepository = FBallRepository();

  IM001MainPageViewModel(this._context, this._setUpPosition, this.address) {
    _ballUuid = new Uuid().v4();
    initCameraPosition =
        new CameraPosition(target: _setUpPosition, zoom: 14.4746);
    titleFocusNode.addListener(onTitleFocusNode);
    textContentFocusNode.addListener(ontextContentFocusNode);
    tagEditFocusNode.addListener(onTagEditFocusNode);
    textContentEditController.addListener(onTextContentEditController);
    titleEditController.addListener(onTitleEditController);
    KeyboardVisibility.onChange.listen((bool visible) {
      keyboardVisibility = visible;
    });
    _init();
  }

  _init() async {
    this.ballList = new List<FBallResForMarkerStyle2Dto>();
    ballList.add(new FBallResForMarkerStyle2Dto(
        FBallType.IssueBall, _setUpPosition, _ballUuid));
    Completer<Set<Marker>> _markerCompleter = Completer();
    MakerSupportStyle2(ballList, _markerCompleter).generate(_context);
    Set<Marker> markers = await _markerCompleter.future;
    this.markers.clear();
    this.markers.addAll(markers);
    _ticker = Ticker(onTickerDrawBall);
    //개발중에는 애니메이션 효과 줄시 너무 느리므로 끔.
//    _ticker.start();
    notifyListeners();
  }

  void ontextContentFocusNode() {
    notifyListeners();
  }

  void onTextContentEditController() {
    notifyListeners();
  }

  void onTitleEditController() {
    notifyListeners();
  }

  onTitleFocusNode() {
    notifyListeners();
  }

  //여기서 선택된 볼의 애니메이션을 같이 그려준다.
  onTickerDrawBall(Duration duration) async {
    Completer<Set<Marker>> _markerCompleter = Completer();
    RenderRepaintBoundary ballAnimation =
        makerAnimationKey.currentContext.findRenderObject();
    var ballAnimationImage = await ballAnimation.toImage(pixelRatio: 1.0);
    ByteData byteData =
        await ballAnimationImage.toByteData(format: ui.ImageByteFormat.png);
    Uint8List uint8BallAnimation = byteData.buffer.asUint8List();
    MakerSupportStyle2(ballList, _markerCompleter).generate(_context);
    Set<Marker> markers = await _markerCompleter.future;
    this.markers.clear();
    this.markers.addAll(markers);
    this.markers.add(Marker(
        markerId: MarkerId("selectlader"),
        position: this._setUpPosition,
        anchor: Offset(0.5, 0.5),
        zIndex: 0,
        icon: BitmapDescriptor.fromBytes(uint8BallAnimation)));

    notifyListeners();
  }

  @override
  void dispose() {
    _ticker.dispose();
    if (_clipBoardCheckTimer != null) {
      _clipBoardCheckTimer.cancel();
    }
    super.dispose();
  }

  void onBackBtnTap() {
    Navigator.of(_context).pop();
  }

  isValidComplete() {
    if (titleEditController.text.trim().length > 0 &&
        textContentEditController.text.trim().length > 0) {
      return true;
    } else {
      return false;
    }
  }

  void onCompleteTap() async {
    List<Uint8List> images = [];
    List<BallImageItemDto> uploadListImageItemDto = [];
    for (var o in ballImageList) {
      if(o.imageByte != null){
        images.add(o.imageByte);
        uploadListImageItemDto.add(o);
      }
    }
    //이미지 업로드 해서 URL 가져옴
    var fBallImageUploadResDto = await _fBallRepository.ballImageUpload(images);
    for(int i=0;i<fBallImageUploadResDto.urls.length;i++){
      uploadListImageItemDto[i].imageUrl = fBallImageUploadResDto.urls[i];
    }

    
    IssueBallDescriptionDto issueBallDescriptionDto = IssueBallDescriptionDto();
    issueBallDescriptionDto.text = textContentEditController.text;
    for(int i=0;i<ballImageList.length;i++){
      issueBallDescriptionDto.desimages.add(FBallDesImagesDto.fromUrl(i, ballImageList[i].imageUrl));
    }
    if(validYoutubeLink != null){
      issueBallDescriptionDto.youtubeVideoId = getIdFromUrl(validYoutubeLink);
    }


    FBallInsertReqDto ballInsertReqDto = FBallInsertReqDto();
    ballInsertReqDto.ballType = FBallType.IssueBall;
    //JSON 으로 넣어 준 다음 다음에 다시 JSON 으로 파서 해서 사용
    ballInsertReqDto.description = json.encode(issueBallDescriptionDto.toJson());
    ballInsertReqDto.longitude = _setUpPosition.longitude;
    ballInsertReqDto.latitude = _setUpPosition.latitude;
    ballInsertReqDto.ballUuid = Uuid().v4();
    ballInsertReqDto.ballName = titleEditController.text;
    ballInsertReqDto.placeAddress = address;
    List<TagInsertReqDto> tags =[];
    for( var chip in tagChips){
      Text textWidget = chip.label as Text;
      tags.add(TagInsertReqDto(ballInsertReqDto.ballUuid,textWidget.data));
    }
    ballInsertReqDto.tags = tags;

    var result = await _fBallRepository.insertBall(ballInsertReqDto);
    if(result == 1){
      Navigator.of(_context).popUntil(ModalRoute.withName('HCODE'));
    }

  }

  //이미지 추가를 눌렀을때
  onImagePicker() async {
    if (ballImageList.length == 20) {
      Fluttertoast.showToast(
          msg: "이미지 20장을 모두 첨부하였습니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
      Navigator.of(_context).pop();
      notifyListeners();
      return;
    }
    List<Asset> images = await MultiImagePicker.pickImages(
        maxImages: 20 - ballImageList.length,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "이슈 큐브 이미지",
          allViewTitle: "이슈 큐브 이미지",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ));
    if(images != null){
      for (var i in images) {
        ByteData imageData = await i.getByteData();

        BallImageItemDto itemDto = new BallImageItemDto();
        itemDto.imageByte = imageData.buffer.asUint8List();
        ballImageList.add(itemDto);
      }
    }
    Navigator.of(_context).pop();
    moveToBottomScroller();
    notifyListeners();
  }

  onCameraPick() async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    Uint8List imageData = await image.readAsBytes();
    BallImageItemDto itemDto = new BallImageItemDto();
    itemDto.imageByte = imageData.buffer.asUint8List();
    ballImageList.add(itemDto);
    Navigator.of(_context).pop();
    moveToBottomScroller();
    notifyListeners();
  }

  void onShowSelectPictureDialog() async {
    var result = await showGeneralDialog(
        context: _context,
        barrierDismissible: true,
        transitionDuration: Duration(milliseconds: 300),
        //This is time
        barrierColor: Colors.black.withOpacity(0.3),
        barrierLabel:
            MaterialLocalizations.of(_context).modalBarrierDismissLabel,
        pageBuilder:
            (_context, Animation animation, Animation secondaryAnimation) {
          return Stack(children: <Widget>[
            Positioned(
                top: 494.h,
                left: 37.w,
                child: Container(
                    width: 180.w,
                    height: 70.h,
                    child: Row(children: <Widget>[
                      Container(
                          width: 88.w,
                          height: 70.h,
                          child: FlatButton(
                            onPressed: onCameraPick,
                            child: Text("카메라",
                                style: TextStyle(
                                  fontFamily: "Noto Sans CJK KR",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13.sp,
                                  color: Color(0xffc1549a),
                                )),
                          ),
                          decoration: BoxDecoration(
                              border: Border(
                                  right: BorderSide(
                                      color: Color(0xffc1549a), width: 1.w)))),
                      Container(
                          width: 88.w,
                          height: 70.h,
                          child: FlatButton(
                            onPressed: onImagePicker,
                            child: Text("사진 선택",
                                style: TextStyle(
                                  fontFamily: "Noto Sans CJK KR",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13.sp,
                                  color: Color(0xffc1549a),
                                )),
                          ))
                    ]),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.00),
                        border:
                            Border.all(color: Color(0xffC1549A), width: 1.w))))
          ]);
        });
    print(result);
  }

  void deleteBallImage(int index) {
    ballImageList.removeAt(index);
    notifyListeners();
  }

  void youtubeAttachVisibilityToggle() {
    youtubeAttachVisibility = !youtubeAttachVisibility;
    if (youtubeAttachVisibility == true) {
      if (_clipBoardCheckTimer != null) {
        _clipBoardCheckTimer.cancel();
      }
      _clipBoardCheckTimer =
          Timer.periodic(Duration(seconds: 2), (timer) async {
        ClipboardData clipBoardData = await Clipboard.getData("text/plain");
        currentClipBoardData = clipBoardData.text.trim();
        notifyListeners();
      });
    } else {
      if (_clipBoardCheckTimer != null) {
        currentClipBoardData = null;
        _clipBoardCheckTimer.cancel();
      }
    }

    notifyListeners();
    moveToBottomScroller();
  }

  void moveToBottomScroller() {
    Timer(
        Duration(milliseconds: 500),
        () => mainScrollController.animateTo(
            mainScrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 200),
            curve: Curves.linear));
  }

  validYoutubeLinkCheck(String currentClipBoardData) {
    String idFromUrl = getIdFromUrl(currentClipBoardData);
    if (idFromUrl == null) {
      Fluttertoast.showToast(
          msg: "유효한 유튜브 링크가 아닙니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
    } else {
      validYoutubeLink = currentClipBoardData;
    }
    notifyListeners();
  }

  void deleteYoutubeLink() {
    validYoutubeLink = null;
    notifyListeners();
  }

  void onTagEditFocusNode() {
    notifyListeners();
  }

  void onTagTextChanged(String value) {
    if (value.indexOf(",") > 0) {
      value = value.substring(0, value.length - 1);
      addTagChips(value);
      tagEditController.clear();
      moveToBottomScroller();
      notifyListeners();
    }
  }

  void onTagFieldSubmitted(String value) {
    addTagChips(value);
    tagEditController.clear();
    moveToBottomScroller();
    notifyListeners();
  }

  void addTagChips(String value) {
    if (tagChips.length == 10) {
      Fluttertoast.showToast(
          msg: "이미지 20장을 모두 첨부하였습니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
      Navigator.of(_context).pop();
      notifyListeners();
      return;
    }
    int index = tagChips.indexWhere((item) {
      Text itemText = item.label as Text;
      if (itemText.data == value) {
        return true;
      } else {
        return false;
      }
    });
    if (index >= 0) {
      return;
    }
    tagChips.add(Chip(
        backgroundColor: Color(0xffCCCCCC),
        label: Text(value),
        onDeleted: () {
          tagChips.removeWhere((item) {
            Text itemText = item.label as Text;
            if (itemText.data == value) {
              return true;
            } else {
              return false;
            }
          });
          notifyListeners();
        }));
  }

  void tagBarToggle() {
    tagBarVisibility = !tagBarVisibility;
    if (tagBarVisibility) {
      moveToBottomScroller();
    }
    notifyListeners();
  }
}
