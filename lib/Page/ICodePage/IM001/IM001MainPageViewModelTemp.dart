import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Common/MarkerSupport/Style2/FBallResForMarkerStyle2Dto.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallImageListUpLoadUseCase/BallImageListUpLoadUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/InsertBall/InsertBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/selectBall/SelectBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallDesImagesDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/Common/YoutubeParser/youtubeParser.dart';
import 'package:forutonafront/Page/ICodePage/ID001/ID001MainPage2.dart';
import 'package:forutonafront/Page/ICodePage/IM001/IM001MainPageEnterMode.dart';
import 'package:forutonafront/AppBis/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCaseOutputPort.dart';
import 'package:forutonafront/AppBis/Tag/Dto/FBallTagResDto.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:uuid/uuid.dart';

import 'Component/BallImageEdit/BallImageItem.dart';



class IM001MainPageViewModelTemp extends ChangeNotifier
    implements
        InsertBallUseCaseOutputPort,
        SelectBallUseCaseOutputPort,
        TagFromBallUuidUseCaseOutputPort {
  final BuildContext? context;
  final LatLng? setUpPosition;

  final SelectBallUseCaseInputPort? _selectBallUseCaseInputPort;

  final BallImageListUpLoadUseCaseInputPort?
      _ballImageListUpLoadUseCaseInputPort;

  String? ballUuid;

  final String? address;

  bool _isDispose = false;

  String? currentClipBoardData;
  String? validYoutubeLink;
  GlobalKey makerAnimationKey = new GlobalKey();

  String topNameTitle = "이슈볼 만들기";

  FBallResDto? _issueBall;

  //googleMap
  CameraPosition? initCameraPosition;
  Completer<GoogleMapController> _googleMapController = Completer();

  //Focus
  FocusNode tagEditFocusNode = FocusNode();
  FocusNode titleFocusNode = FocusNode();
  FocusNode textContentFocusNode = FocusNode();

  //WidgetController
  TextEditingController textContentEditController = TextEditingController();
  TextEditingController titleEditController = TextEditingController();
  ScrollController mainScrollController = ScrollController();
  TextEditingController tagEditController = TextEditingController();

  //WidgetList
  List<BallImageItem> ballImageList = [];
  List<Chip> tagChips = [];
  List<FBallResForMarkerStyle2Dto>? ballList;

  //Flag
  bool keyboardVisibility = false;
  bool youtubeAttachVisibility = false;
  bool tagBarVisibility = false;

  //Loading
  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  IM001MainPageEnterMode? mode;

  IM001MainPageViewModelTemp(
      {this.context,
      this.setUpPosition,
      this.address,
      this.ballUuid,
      this.mode,
      required
          SelectBallUseCaseInputPort selectBallUseCaseInputPort,
      required
          BallImageListUpLoadUseCaseInputPort
              ballImageListUpLoadUseCaseInputPort})
      : _selectBallUseCaseInputPort = selectBallUseCaseInputPort,
        _ballImageListUpLoadUseCaseInputPort =
            ballImageListUpLoadUseCaseInputPort {
    _init();
  }

  _init() async {
    titleFocusNode.addListener(onTitleFocusNode);
    textContentFocusNode.addListener(onTextContentFocusNode);
    tagEditFocusNode.addListener(onTagEditFocusNode);
    textContentEditController.addListener(onTextContentEditController);
    titleEditController.addListener(onTitleEditController);
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardVisibilityController.onChange.listen((bool visible) {
      keyboardVisibility = visible;
    });
    initCameraPosition =
        new CameraPosition(target: setUpPosition!, zoom: 14.4746);
    if (mode == IM001MainPageEnterMode.Insert) {
      insertInit();
    } else if (mode == IM001MainPageEnterMode.Update) {
      await updateActionInit();
    }

    notifyListeners();
    copyClipBoard();
  }

  void insertInit() {
//    _issueBall = IssueBall();

    _issueBall!.longitude = setUpPosition!.longitude;
    _issueBall!.latitude = setUpPosition!.latitude;
    _issueBall!.placeAddress = address;
    _issueBall!.ballDeleteFlag = false;
    this.topNameTitle = "이슈볼 만들기";
    notifyListeners();
    _issueBall!.ballUuid = Uuid().v4();
    ballUuid = _issueBall!.ballUuid;
  }

  Future updateActionInit() async {
    this.topNameTitle = "이슈볼 수정하기";
    notifyListeners();
    isLoading = true;
    await _selectBallUseCaseInputPort!.selectBall(ballUuid!, outputPort: this);

    isLoading = false;
  }

  @override
  onTagFromBallUuid(List<FBallTagResDto> ballTags) {}

  @override
  void onSelectBall(FBallResDto fBallResDto) async {
//    _issueBall = IssueBall.fromFBallResDto(fBallResDto);
//    if (_issueBall.hasYoutubeVideo()) {
//      this.youtubeAttachVisibility = true;
//      this.validYoutubeLink =
//          "https://youtu.be/${_issueBall.getDisplayYoutubeVideoId()}";
//    }
//    var tagDTOs = await _tagFromBallUuidUseCaseInputPort.getTagFromBallUuid(
//        reqDto: TagFromBallReqDto(ballUuid: _issueBall.ballUuid));
//    var tags = tagDTOs.map((x) => FBallTag.fromFBallTagResDto(x)).toList();
//    _issueBall.tags = tags;
//    if (_issueBall.hasTags()) {
//      this.tagBarVisibility = true;
//    }
//    _issueBall.tags.forEach((element) {
//      addTagChips(element.tagItem);
//    });
    titleEditController.text = _issueBall!.ballName!;
//    textContentEditController.text = _issueBall.getDisplayDescriptionText();
//    ballImageList = _issueBall
//        .getDesImages()
//        .map((x) => BallImageItem.fromFBallDesImagesDto(x))
//        .toList();
  }

  void onTextContentFocusNode() {
    notifyListeners();
  }

  void onTextContentEditController() {
//    _issueBall.setDescriptionText(textContentEditController.text);
    notifyListeners();
  }

  void onTitleEditController() {
    _issueBall!.ballName = titleEditController.text;
    notifyListeners();
  }

  onTitleFocusNode() {
    notifyListeners();
  }

  @override
  void dispose() {
    _isDispose = true;
    super.dispose();
  }

  void onBackBtnTap() {
    Navigator.of(context!).pop();
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
    isLoading = true;
    await fBallImageUpload();
//    _issueBall.setDesImages(imageList);
    if (mode == IM001MainPageEnterMode.Insert) {
//      await _insertBallUseCaseInputPort.insertBall(
//          FBallInsertReqDto.fromIssueBall(_issueBall),
//          outputPort: this);
    } else if (mode == IM001MainPageEnterMode.Update) {}
    isLoading = false;
  }

  Future<List<FBallDesImages>> fBallImageUpload() async {
    List<FBallDesImages> imageList = [];
    // List<BallImageItem> fillUrlBallImageList =
    //     await _ballImageListUpLoadUseCaseInputPort
    //         .ballImageListUpLoadAndFillUrls(this.ballImageList);
    // for (var index = 0; index < fillUrlBallImageList.length; index++) {
    //   imageList.add(FBallDesImages.fromBallImageItemDto(
    //       index, fillUrlBallImageList[index]));
    // }
    return imageList;
  }

  @override
  void onInsertBall(FBallResDto resDto) {
    Navigator.of(context!).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (_) => ID001MainPage2(ballUuid: _issueBall!.ballUuid)),
        ModalRoute.withName('/'));
  }

  bool hasYoutubeLink() => validYoutubeLink != null;

//이미지 추가를 눌렀을때
  onImagePicker() async {
    if (ballImageList.length == 20) {
      Fluttertoast.showToast(
          msg: "이미지 20장을 모두 첨부하였습니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
      Navigator.of(context!).pop();
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
        // BallImageItem itemDto = new BallImageItem();
        // itemDto.imageByte = imageData.buffer.asUint8List();
        // ballImageList.add(itemDto);
      }
    }
    Navigator.of(context!).pop();
    moveToBottomScroller();
    notifyListeners();
  }

  onCameraPick() async {
    PickedFile? image = await ImagePicker.platform.pickImage(source: ImageSource.camera);
    Uint8List imageData = await image!.readAsBytes();
    // BallImageItem itemDto = new BallImageItem();
    // itemDto.imageByte = imageData.buffer.asUint8List();
    // ballImageList.add(itemDto);
    Navigator.of(context!).pop();
    moveToBottomScroller();
    notifyListeners();
  }

  void onShowSelectPictureDialog() async {
    var result = await showGeneralDialog(
        context: context!,
        barrierDismissible: true,
        transitionDuration: Duration(milliseconds: 300),
        //This is time
        barrierColor: Colors.black.withOpacity(0.3),
        barrierLabel:
            MaterialLocalizations.of(context!).modalBarrierDismissLabel,
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
                                style: GoogleFonts.notoSans(
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

  Future<String?> copyClipBoard() async {
    ClipboardData? clipBoardData = await Clipboard.getData("text/plain");
    currentClipBoardData = clipBoardData!.text!.trim();
    return currentClipBoardData;
  }

  void youtubeAttachVisibilityToggle() {
    youtubeAttachVisibility = !youtubeAttachVisibility;
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

  validYoutubeLinkCheck() async {
    await copyClipBoard();
    String? idFromUrl = getIdFromUrl(currentClipBoardData!);
    if (idFromUrl == null) {
      Fluttertoast.showToast(
          msg: "유효한 유튜브 링크가 아닙니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
    } else {
      this.validYoutubeLink = currentClipBoardData;
//      _issueBall
//          .setYoutubeVideoId(YoutubeIdParser.getIdFromUrl(validYoutubeLink));
    }
    notifyListeners();
  }

  void deleteYoutubeLink() {
    this.validYoutubeLink = null;
//    _issueBall.setYoutubeVideoId(null);
    notifyListeners();
  }

  void onTagEditFocusNode() {
    notifyListeners();
  }

  void onTagTextChanged(String value) {
    checkFirstCommaAndWarning(value);

    checkSpecialCharactersAndRemoveSpecialCharacters(value);

    checkSpaceCharactersAndRemoveSpaceCharacters(value);

    checkTextSizeOverFlow(value);

    checkCommaAndInsert(value);
  }

  void checkCommaAndInsert(String value) {
    if (value.indexOf(",") > 0) {
      value = value.substring(0, value.length - 1);
//      _issueBall.tags
//          .add(FBallTag(ballUuid: _issueBall.ballUuid, tagItem: value));
      addTagChips(value);
      tagEditController.clear();
      moveToBottomScroller();
      notifyListeners();
    }
  }

  void checkSpecialCharactersAndRemoveSpecialCharacters(String value) {
    RegExp specialCharactersReg = new RegExp(r'^(?=.*?[!@#\$&*~])');
    bool hasSpecialCharacters =
        specialCharactersReg.hasMatch(value) ? true : false;
    if (hasSpecialCharacters) {
      tagEditController.text = removeTagLastCharacter();
      Fluttertoast.showToast(
          msg: "태그에 특수문자는 사용할 수 없습니다",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
    }
  }

  void checkSpaceCharactersAndRemoveSpaceCharacters(String value) {
    RegExp spaceCharactersReg = new RegExp(r'^\s');
    bool hasSpaceCharacters = spaceCharactersReg.hasMatch(value) ? true : false;
    if (hasSpaceCharacters) {
      tagEditController.text = removeTagLastCharacter();
      Fluttertoast.showToast(
          msg: "태그에 띄어쓰기는 사용할 수 없습니다",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
    }
  }

  String removeTagLastCharacter() =>
      tagEditController.text.substring(0, tagEditController.text.length - 1);

  void checkTextSizeOverFlow(String value) {
    if (value.length >= 10) {
      Fluttertoast.showToast(
          msg: "태그는 최대 10글자만 입력가능합니다",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
    }
  }

  void checkFirstCommaAndWarning(String value) {
    if (value.indexOf(",") == 0) {
      tagEditController.clear();
      Fluttertoast.showToast(
          msg: "태그 내용을 입력해주세요.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
    }
  }

  void onTagFieldSubmitted(String value) {
//    _issueBall.tags
//        .add(FBallTag(ballUuid: _issueBall.ballUuid, tagItem: value));
    addTagChips(value);
    tagEditController.clear();
    moveToBottomScroller();
    notifyListeners();
  }

  void addTagChips(String value) {
    if (isTagChipLimitOver()) {
      Fluttertoast.showToast(
          msg: "태그는 최대 10개까지 입력가능합니다",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
      notifyListeners();
      return;
    }
    if (hasSameChips(value)) {
      return;
    }
    addChipWidget(value);
  }

  bool isTagChipLimitOver() => tagChips.length >= 10;

  void addChipWidget(String value) {
    print("addChipWidget");
    print(value);
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
//          _issueBall.tags.removeWhere((tagItem) {
//            if (tagItem.tagItem == value) {
//              return true;
//            } else {
//              return false;
//            }
//          });
          notifyListeners();
        }));
  }

  bool hasSameChips(String value) {
    int index = tagChips.indexWhere((item) {
      Text itemText = item.label as Text;
      if (itemText.data == value) {
        return true;
      } else {
        return false;
      }
    });
    print(index);
    if (index >= 0) {
      return true;
    } else {
      return false;
    }
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
    await _googleMapController.future;
  }

  @override
  bool isDispose() {
    return _isDispose;
  }
}
