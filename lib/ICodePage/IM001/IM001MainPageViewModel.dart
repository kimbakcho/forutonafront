import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Common/YoutubeUtil/YoutubeIdParser.dart';
import 'package:forutonafront/FBall/Data/Entity/IssueBall.dart';
import 'package:forutonafront/FBall/Domain/UseCase/IssueBall/IssueBallUseCase.dart';
import 'package:forutonafront/FBall/Domain/UseCase/IssueBall/IssueBallUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/IssueBall/IssueBallUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallDesImagesDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Dto/IssueBallInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/IssueBallUpdateReqDto.dart';
import 'package:forutonafront/FBall/MarkerSupport/Style2/FBallResForMarkerStyle2Dto.dart';
import 'package:forutonafront/ICodePage/ID001/ID001MainPage.dart';
import 'package:forutonafront/ICodePage/IM001/IM001MainPageEnterMode.dart';
import 'package:forutonafront/Tag/Data/Entity/FBallTag.dart';
import 'package:forutonafront/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCase.dart';
import 'package:forutonafront/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCaseInputPort.dart';
import 'package:forutonafront/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCaseOutputPort.dart';
import 'package:forutonafront/Tag/Dto/FBallTagResDto.dart';
import 'package:forutonafront/Tag/Dto/TagFromBallReqDto.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:youtube_parser/youtube_parser.dart';

import 'BallImageItemDto.dart';

class IM001MainPageViewModel extends ChangeNotifier
    implements IssueBallUseCaseOutputPort, TagFromBallUuidUseCaseOutputPort {
  final BuildContext _context;
  final LatLng _setUpPosition;
  String ballUuid;

  final String address;
  String currentClipBoardData;
  String validYoutubeLink;
  GlobalKey makerAnimationKey = new GlobalKey();

  String topNameTitle = "이슈볼 만들기";

  IssueBall _issueBall;

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

  IssueBallUseCaseInputPort _issueBallUseCaseInputPort = IssueBallUseCase();
  TagFromBallUuidUseCaseInputPort _tagFromBallUuidUseCaseInputPort =
      TagFromBallUuidUseCase();

  //Loading
  bool _isLoading = false;

  get isLoading {
    return _isLoading;
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  IM001MainPageEnterMode mode;

  IM001MainPageViewModel(this._context, this._setUpPosition, this.address,
      this.ballUuid, this.mode) {
    _init();
  }

  _init() async {
    titleFocusNode.addListener(onTitleFocusNode);
    textContentFocusNode.addListener(onTextContentFocusNode);
    tagEditFocusNode.addListener(onTagEditFocusNode);
    textContentEditController.addListener(onTextContentEditController);
    titleEditController.addListener(onTitleEditController);
    KeyboardVisibility.onChange.listen((bool visible) {
      keyboardVisibility = visible;
    });
    initCameraPosition =
        new CameraPosition(target: _setUpPosition, zoom: 14.4746);
    if (mode == IM001MainPageEnterMode.Insert) {
      insertInit();
    } else if (mode == IM001MainPageEnterMode.Update) {
      await updateActionInit();
    }

    notifyListeners();
    copyClipBoard();
  }

  void insertInit() {
    _issueBall = IssueBall();

    _issueBall.longitude = _setUpPosition.longitude;
    _issueBall.latitude = _setUpPosition.latitude;
    _issueBall.placeAddress = address;
    _issueBall.ballDeleteFlag = false;
    this.topNameTitle = "이슈볼 만들기";
    notifyListeners();
    _issueBall.ballUuid = Uuid().v4();
    ballUuid = _issueBall.ballUuid;
  }

  Future updateActionInit() async {
    this.topNameTitle = "이슈볼 수정하기";
    notifyListeners();
    isLoading = true;
    await _issueBallUseCaseInputPort.selectBall(
        ballUuid: ballUuid, outputPort: this);

    isLoading = false;
  }

  @override
  onTagFromBallUuid(List<FBallTagResDto> ballTags) {}

  @override
  void onSelectBall(FBallResDto fBallResDto) async {
    _issueBall = IssueBall.fromFBallResDto(fBallResDto);
    if (_issueBall.hasYoutubeVideo()) {
      this.youtubeAttachVisibility = true;
      this.validYoutubeLink = "https://youtu.be/${_issueBall.getDisplayYoutubeVideoId()}";
    }
    var tagDTOs = await _tagFromBallUuidUseCaseInputPort.getTagFromBallUuid(
        reqDto: TagFromBallReqDto(ballUuid: _issueBall.ballUuid));
    var tags = tagDTOs.map((x) => FBallTag.fromFBallTagResDto(x)).toList();
    _issueBall.tags = tags;
    if (_issueBall.hasTags()) {
      this.tagBarVisibility = true;
    }
    _issueBall.tags.forEach((element) {
      addTagChips(element.tagItem);
    });
    titleEditController.text = _issueBall.ballName;
    textContentEditController.text = _issueBall.getDisplayDescriptionText();
    ballImageList = _issueBall.getDesImages().map((x) => BallImageItemDto.fromFBallDesImagesDto(x)).toList();
  }

  void onTextContentFocusNode() {
    notifyListeners();
  }

  void onTextContentEditController() {
    _issueBall.setDescriptionText(textContentEditController.text);
    notifyListeners();
  }

  void onTitleEditController() {
    _issueBall.ballName = titleEditController.text;
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
    if (titleEditController.text.trim().length > 0 &&
        textContentEditController.text.trim().length > 0) {
      return true;
    } else {
      return false;
    }
  }

  void onCompleteTap() async {
    isLoading = true;
    List<FBallDesImages> imageList = await fBallImageUpload();
    _issueBall.setDesImages(imageList);
    if (mode == IM001MainPageEnterMode.Insert) {
      await _issueBallUseCaseInputPort.insertBall(
          reqDto: IssueBallInsertReqDto.fromIssueBall(_issueBall),
          outputPort: this);
    } else if (mode == IM001MainPageEnterMode.Update) {
      await _issueBallUseCaseInputPort.updateBall(
          reqDto: IssueBallUpdateReqDto.fromIssueBall(_issueBall),
          outputPort: this);
    }
    isLoading = false;
  }

  Future<List<FBallDesImages>> fBallImageUpload() async {
    List<FBallDesImages> imageList = [];
    List<BallImageItemDto> fillUrlBallImageList =
        await _issueBallUseCaseInputPort.ballImageListUpLoadAndFillUrls(
            refSrcList: this.ballImageList);
    for (var index = 0; index < fillUrlBallImageList.length; index++) {
      imageList.add(FBallDesImages.fromBallImageItemDto(
          index, fillUrlBallImageList[index]));
    }
    return imageList;
  }

  @override
  void onInsertBall(FBallResDto resDto) {
    Navigator.of(_context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => ID001MainPage(issueBall: IssueBall.fromFBallResDto(resDto))),
        ModalRoute.withName('/'));
  }

  @override
  void onUpdateBall() {
    Navigator.of(_context).pop(mode);
  }

  bool hasYoutubeLink() => validYoutubeLink != null;

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
            MaterialLocalizations.of(_context).modalBarrierDismissLabel,
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
      this.validYoutubeLink =currentClipBoardData ;
      _issueBall.setYoutubeVideoId(YoutubeIdParser.getIdFromUrl(validYoutubeLink));
    }
    notifyListeners();
  }

  void deleteYoutubeLink() {
    this.validYoutubeLink = null;
    _issueBall.setYoutubeVideoId(null);
    notifyListeners();
  }

  void onTagEditFocusNode() {
    notifyListeners();
  }

  void onTagTextChanged(String value) {
    if (value.indexOf(",") == 0) {
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
      _issueBall.tags
          .add(FBallTag(ballUuid: _issueBall.ballUuid, tagItem: value));
      addTagChips(value);
      tagEditController.clear();
      moveToBottomScroller();
      notifyListeners();
    }
  }

  void onTagFieldSubmitted(String value) {
    _issueBall.tags
        .add(FBallTag(ballUuid: _issueBall.ballUuid, tagItem: value));
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
          timeInSecForIos: 1,
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

  bool isTagChipLimitOver() => tagChips.length > 10;

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
          _issueBall.tags.removeWhere((tagItem) {
            if(tagItem.tagItem == value) {
              return true;
            }else {
              return false;
            }
          });
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
    GoogleMapController controllerTemp = await _googleMapController.future;
  }

  @override
  void onBallHit() {
    throw ("here don't have action");
  }

  @override
  void onDeleteBall() {
    throw ("here don't have action");
  }
}
