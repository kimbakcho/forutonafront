import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Common/Tag/Dto/TagFromBallReqDto.dart';
import 'package:forutonafront/Common/Tag/Dto/TagInsertReqDto.dart';
import 'package:forutonafront/Common/Tag/Repository/TagRepository.dart';
import 'package:forutonafront/Common/YoutubeUtil/YoutubeIdParser.dart';
import 'package:forutonafront/FBall/Dto/FBallDesImagesDto.dart';
import 'package:forutonafront/FBall/Dto/FBallInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'file:///C:/workproject/FlutterPro/forutonafront/lib/FBall/Data/Value/FBallType.dart';
import 'file:///C:/workproject/FlutterPro/forutonafront/lib/FBall/Data/Value/IssueBallDescription.dart';
import 'package:forutonafront/FBall/MarkerSupport/Style2/FBallResForMarkerStyle2Dto.dart';
import 'package:forutonafront/FBall/MarkerSupport/Style2/MakerSupportStyle2.dart';
import 'package:forutonafront/FBall/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Repository/FBallTypeRepository.dart';
import 'package:forutonafront/ICodePage/ID001/ID001MainPage.dart';
import 'package:forutonafront/ICodePage/IM001/IM001MainPageEnterMode.dart';
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

  final String address;
  String currentClipBoardData;
  String validYoutubeLink;
  GlobalKey makerAnimationKey = new GlobalKey();

  String topNameTitle = "이슈볼 만들기";

  //googleMap
  CameraPosition initCameraPosition;
  Completer<GoogleMapController> _googleMapController = Completer();

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

  //Loading
  bool _isLoading = false;
  getIsLoading() {
    return _isLoading;
  }

  _setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  IM001MainPageEnterMode mode;


  IM001MainPageViewModel(this._context, this._setUpPosition, this.address,
      this._ballUuid, this.mode) {
    _init();
  }

  _init() async {
    _setIsLoading(true);
    titleFocusNode.addListener(onTitleFocusNode);
    textContentFocusNode.addListener(ontextContentFocusNode);
    tagEditFocusNode.addListener(onTagEditFocusNode);
    textContentEditController.addListener(onTextContentEditController);
    titleEditController.addListener(onTitleEditController);
    KeyboardVisibility.onChange.listen((bool visible) {
      keyboardVisibility = visible;
    });
    initCameraPosition =
    new CameraPosition(target: _setUpPosition, zoom: 14.4746);
    if (mode == IM001MainPageEnterMode.Insert) {
      this.topNameTitle = "이슈볼 만들기";
      notifyListeners();
      _ballUuid = new Uuid().v4();
    } else if (mode == IM001MainPageEnterMode.Update) {
      await updateActionInit();
    }

    notifyListeners();
    copyClipBoard();
    _setIsLoading(false);
  }

  Future updateActionInit() async {
    this.topNameTitle = "이슈볼 수정하기";
    notifyListeners();
    var fBallTypeRepository = FBallTypeRepository.create(FBallType.IssueBall);
    FBallResDto preBallContent = await fBallTypeRepository
        .selectBall(FBallReqDto(FBallType.IssueBall, _ballUuid));
    titleEditController.text = preBallContent.ballName;
    var descriptionDto = IssueBallDescriptionDto.fromJson(
        json.decode(preBallContent.description));
    textContentEditController.text = descriptionDto.text;
    descriptionDto.desimages.forEach((element) {
      this
          .ballImageList
          .add(BallImageItemDto.fromFBallDesImagesDto((element)));
    });
    if(descriptionDto.youtubeVideoId != null){
      this.youtubeAttachVisibility = true;
      this.validYoutubeLink = "https://youtu.be/${descriptionDto.youtubeVideoId}";
    }

    TagRepository tagRepository = TagRepository();
    var tagResDtoWrap = await tagRepository.tagFromBallUuid(
        TagFromBallReqDto(preBallContent.ballUuid));
    if(tagResDtoWrap.tags.length != 0){
      this.tagBarVisibility = true;
    }
    tagResDtoWrap.tags.forEach((element) {
      addTagChips(element.tagItem);
    });
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

  @override
  void dispose() {
    super.dispose();
  }

  void onBackBtnTap() {
    Navigator.of(_context).pop();
  }

  isValidComplete() {
    if (titleEditController.text
        .trim()
        .length > 0 &&
        textContentEditController.text
            .trim()
            .length > 0) {
      return true;
    } else {
      return false;
    }
  }

  void onCompleteTap() async {
    _setIsLoading(true);

    var fillUrlBallImageList =
    await _ballImageListUpLoadAndFillUrls(this.ballImageList);

    IssueBallDescriptionDto issueBallDescriptionDto = IssueBallDescriptionDto();

    issueBallDescriptionDto.text = textContentEditController.text;
    for (int i = 0; i < fillUrlBallImageList.length; i++) {
      issueBallDescriptionDto.desimages
          .add(FBallDesImages.fromUrl(i, fillUrlBallImageList[i].imageUrl));
    }

    if (validYoutubeLink != null) {
      issueBallDescriptionDto.youtubeVideoId =
          YoutubeIdParser.getIdFromUrl(validYoutubeLink);
    }
    FBallInsertReqDto ballInsertReqDto = FBallInsertReqDto();
    ballInsertReqDto.ballType = FBallType.IssueBall;
    //JSON 으로 넣어 준 다음 다음에 다시 JSON 으로 파서 해서 사용
    ballInsertReqDto.description =
        json.encode(issueBallDescriptionDto.toJson());
    ballInsertReqDto.longitude = _setUpPosition.longitude;
    ballInsertReqDto.latitude = _setUpPosition.latitude;
    ballInsertReqDto.ballUuid = _ballUuid;
    ballInsertReqDto.ballName = titleEditController.text;
    ballInsertReqDto.placeAddress = address;
    List<TagInsertReqDto> tags = [];
    for (var chip in tagChips) {
      Text textWidget = chip.label as Text;
      tags.add(TagInsertReqDto(ballInsertReqDto.ballUuid, textWidget.data));
    }
    ballInsertReqDto.tags = tags;

    var fBallTypeRepository = FBallTypeRepository.create(FBallType.IssueBall);

    if (mode == IM001MainPageEnterMode.Insert) {
      var result = await fBallTypeRepository.insertBall(ballInsertReqDto);
      if (result == 1) {
        Navigator.of(_context).pushAndRemoveUntil(MaterialPageRoute(
          builder: (_)=>ID001MainPage(_ballUuid)
        ), ModalRoute.withName('/'));

      }
    } else if (mode == IM001MainPageEnterMode.Update) {
      await fBallTypeRepository.updateBall(ballInsertReqDto);
      FBallResDto fBallResDto = await fBallTypeRepository.selectBall(
          FBallReqDto(FBallType.IssueBall, _ballUuid));
      Navigator.of(_context).pop(mode);
    }

    _setIsLoading(false);
  }

  Future<List<BallImageItemDto>> _ballImageListUpLoadAndFillUrls(
      List<BallImageItemDto> refSrcList) async {
    List<Uint8List> images = [];
    List<BallImageItemDto> uploadListImageItemDto = [];
    for (var o in refSrcList) {
      if (o.imageByte != null) {
        var image = await decodeImageFromList(o.imageByte);
        var compressImage = await FlutterImageCompress.compressWithList(
          o.imageByte,
          minHeight: image.height.toInt(),
          minWidth: image.width.toInt(),
          quality: 70,
        );
        images.add(Uint8List.fromList(compressImage));
        uploadListImageItemDto.add(o);
      }
    }
    //이미지 업로드 해서 URL 가져옴
    var fBallImageUploadResDto = await _fBallRepository.ballImageUpload(images);
    for (int i = 0; i < fBallImageUploadResDto.urls.length; i++) {
      uploadListImageItemDto[i].imageUrl = fBallImageUploadResDto.urls[i];
    }
    return refSrcList;
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
    if (images != null) {
      for (var i in images) {
        ByteData imageData = await i.getByteData(quality: 88);
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
        MaterialLocalizations
            .of(_context)
            .modalBarrierDismissLabel,
        pageBuilder:
            (_context, Animation animation, Animation secondaryAnimation) {
          return Stack(children: <Widget>[
            Positioned(
                bottom: 76,
                left: 37,
                child: Container(
                    width: 180,
                    height: 70,
                    child: Row(children: <Widget>[
                      Container(
                          width: 88,
                          height: 70,
                          child: FlatButton(
                            onPressed: onCameraPick,
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
                                      color: Color(0xffc1549a), width: 1)))),
                      Container(
                          width: 88,
                          height: 70,
                          child: FlatButton(
                            onPressed: onImagePicker,
                            child: Text("사진 선택",
                                style: TextStyle(
                                  fontFamily: "Noto Sans CJK KR",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: Color(0xffc1549a),
                                )),
                          ))
                    ]),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.00),
                        border:
                        Border.all(color: Color(0xffC1549A), width: 1))))
          ]);
        });
    print(result);
  }

  void deleteBallImage(int index) {
    ballImageList.removeAt(index);
    notifyListeners();
  }

  Future<String> copyClipBoard() async {
    ClipboardData clipBoardData = await Clipboard.getData("text/plain");
    currentClipBoardData = clipBoardData.text.trim();
    return currentClipBoardData;
  }

  void youtubeAttachVisibilityToggle() {
    youtubeAttachVisibility = !youtubeAttachVisibility;
//    if (youtubeAttachVisibility == true) {
//
//    }

    notifyListeners();
    moveToBottomScroller();
  }

  void moveToBottomScroller() {
    Timer(
        Duration(milliseconds: 500),
            () =>
            mainScrollController.animateTo(
                mainScrollController.position.maxScrollExtent,
                duration: Duration(milliseconds: 200),
                curve: Curves.linear));
  }

  validYoutubeLinkCheck() async {
    await copyClipBoard();
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
    if(value.indexOf(",") == 0){
      tagEditController.clear();
      Fluttertoast.showToast(
          msg: "태그 내용을 입력해주세요.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
    }
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
    if (tagChips.length > 10) {
      Fluttertoast.showToast(
          msg: "태그는 최대 10개까지 입력가능합니다",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
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

  void onMapCreated(GoogleMapController controller) async {
    _googleMapController.complete(controller);
    GoogleMapController controllerTemp = await _googleMapController.future;
  }
}
