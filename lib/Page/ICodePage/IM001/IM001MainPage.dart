import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/InsertBall/InsertBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/UpdateBall/UpdateBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Value/FBallState.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Value/FBallType.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Value/IssueBallDescription.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallDesImagesDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallInsertReqDto/FBallInsertReqDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallUpdateReqDto/FBallUpdateReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoSimpleResDto.dart';
import 'package:forutonafront/AppBis/Tag/Dto/FBallTagResDto.dart';
import 'package:forutonafront/AppBis/Tag/Dto/TagInsertReqDto.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/Common/GoogleMapSupport/MapBallMarkerFactory.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/Common/SearchHistory/Domain/Repository/SearchHistoryRepository.dart';
import 'package:forutonafront/Components/BackButton/BorderCircleBackButton.dart';
import 'package:forutonafront/Components/ButtonStyle/CircleIconBtn.dart';
import 'package:forutonafront/Components/InputSearchBar/InputSearchBar.dart';
import 'package:forutonafront/Components/SolidBottomSheet/src/solidBottomSheet.dart';
import 'package:forutonafront/Components/SolidBottomSheet/src/solidController.dart';
import 'package:forutonafront/Page/HCodePage/H008/H008MainView.dart';
import 'package:forutonafront/Page/HCodePage/H008/PlaceListFromSearchTextWidget.dart';
import 'package:forutonafront/Page/HCodePage/H010/H010MainView.dart';
import 'package:forutonafront/Page/ICodePage/ID001/ID001MainPage2.dart';
import 'package:forutonafront/Page/ICodePage/ID001/ID001Mode.dart';
import 'package:forutonafront/Page/ICodePage/ID01/ID01MainPage.dart';
import 'package:forutonafront/Page/ICodePage/ID01/ID01Mode.dart';
import 'package:forutonafront/Page/ICodePage/IM001/IM001BottomSheetBody.dart';
import 'package:forutonafront/Page/ICodePage/IM001/IM001BottomSheetHeader.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'IM001Mode.dart';

class IM001MainPage extends StatefulWidget {
  final IM001Mode im001mode;
  final FBallResDto? preSetBallResDto;
  final List<FBallTagResDto>? preSetFBallTagResDtos;

  const IM001MainPage(
      {Key? key,
      this.im001mode = IM001Mode.create,
      this.preSetBallResDto,
      this.preSetFBallTagResDtos})
      : super(key: key);

  @override
  _IM001MainPageState createState() => _IM001MainPageState();
}

class _IM001MainPageState extends State<IM001MainPage>
    with SingleTickerProviderStateMixin {
  AnimationController? _aniController;
  Animation<double>? animation;

  @override
  void initState() {
    super.initState();
    _aniController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _aniController!.addListener(() {
      setState(() {});
    });

    animation = Tween<double>(begin: 0, end: 1).animate(_aniController!);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => IM001MainPageViewModel(
            sl(), context, _aniController, sl(), sl(), sl(), sl(),
            im001mode: widget.im001mode,
            preSetBallResDto: widget.preSetBallResDto,
            preSetFBallTagResDtos: widget.preSetFBallTagResDtos),
        child: Consumer<IM001MainPageViewModel>(builder: (_, model, child) {
          return Scaffold(
              bottomSheet: model.getBottomSheet(),
              body: Container(
                  padding: MediaQuery.of(context).padding,
                  child: Stack(children: [
                    Column(
                      children: [
                        Container(
                            color: Colors.white,
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Row(children: [
                              SizedBox(width: 16),
                              Material(
                                color: Color(0xffF6F6F6),
                                shape: CircleBorder(),
                                child: InkWell(
                                  customBorder: CircleBorder(),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    width: 36,
                                    height: 36,
                                    child: Icon(Icons.close),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                  child: Material(
                                color: Color(0xffF6F6F6),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
                                child: InkWell(
                                  customBorder: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0))),
                                  onTap: () {
                                    model.gotoAddressSearchPage();
                                  },
                                  child: Container(
                                    height: 36,
                                    padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                                    alignment: Alignment.centerLeft,
                                    child: Text("주소 검색",style: GoogleFonts.notoSans(
                                      color: Color(0xffB1B1B1)
                                    ),),
                                  ),
                                ),
                              )),
                              SizedBox(width: 16),
                            ])),
                        Expanded(
                            child: Container(
                          child: Stack(
                            children: [
                              GoogleMap(
                                initialCameraPosition: model.initCameraPosition!,
                                onCameraMove: model.onCameraMove,
                                onMapCreated: model.onCreateMap,
                                onCameraIdle: model.onCameraIdle,
                                zoomControlsEnabled: false,
                              ),
                              Center(
                                  child: IgnorePointer(
                                      child: Container(
                                        height: 60,
                                          width: 43,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/MarkesImages/issueselectballmaker.png")))))),
                              widget.im001mode == IM001Mode.create
                                  ? Positioned(
                                      right: 16,
                                      top: 16,
                                      child: CircleIconBtn(
                                        color: Colors.white,
                                        width: 36,
                                        height: 36,
                                        onTap: () {
                                          model.moveToMyPosition();
                                        },
                                        icon: Icon(
                                          Icons.my_location,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                  : Container(width: 0, height: 0)
                            ],
                          ),
                          margin: EdgeInsets.only(bottom: 71),
                        ))
                      ],
                    ),
                    model.isBottomOpened
                        ? Container(
                            color: Color(0xff2F3035)
                                .withOpacity(animation!.value.clamp(0, 0.7)),
                          )
                        : Container(),
                    Positioned(
                        top: (80 * animation!.value) - 70,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 16),
                              width: 36,
                              height: 36,
                              child: Material(
                                color: Color(0xffF6F6F6),
                                shape: CircleBorder(),
                                child: InkWell(
                                  onTap: () {
                                    model._solidController!.hide();
                                  },
                                  child: Icon(Icons.arrow_back,
                                      color: Color(0xff454F63), size: 20),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 16),
                              child: FlatButton(
                                  disabledTextColor: Color(0xffD4D4D4),
                                  disabledColor: Color(0xffF6F6F6),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      side: model.isCanComplete
                                          ? BorderSide(
                                              color: Colors.black, width: 1)
                                          : BorderSide.none),
                                  color: Colors.white,
                                  onPressed: model.isCanComplete
                                      ? () {
                                          widget.im001mode == IM001Mode.create
                                              ? model._onCreateBall()
                                              : model._onModifyBall();
                                        }
                                      : null,
                                  child: Text(
                                      widget.im001mode == IM001Mode.create
                                          ? "완료"
                                          : "수정")),
                            )
                          ],
                        ))
                  ])));
        }));
  }
}

class IM001MainPageViewModel extends ChangeNotifier
    implements InputSearchBarListener, PlaceListFromSearchTextWidgetListener {
  CameraPosition? initCameraPosition;

  final GeoLocationUtilForeGroundUseCaseInputPort?
      _geoLocationUtilForeGroundUseCase;

  CameraPosition? currentPosition;

  Completer<GoogleMapController> _googleMapController = Completer();

  bool isBallPosition = true;

  final BuildContext? context;

  SolidController? _solidController;

  Widget? bottomWidget;

  AnimationController? aniController;

  IM001BottomSheetHeaderController? _im001bottomSheetHeaderController;

  MapBallMarkerFactory? _mapBallMarkerFactory;

  String? headBarAddress;

  bool isCanComplete = false;

  IM001BottomSheetBodyController? _im001bottomSheetBodyController;

  final SignInUserInfoUseCaseInputPort? signInUserInfoUseCaseInputPort;

  final InsertBallUseCaseInputPort? insertBallUseCaseInputPort;

  final UpdateBallUseCaseInputPort? updateBallUseCaseInputPort;

  final IM001Mode? im001mode;

  final FBallResDto? preSetBallResDto;

  final List<FBallTagResDto>? preSetFBallTagResDtos;

  IM001MainPageViewModel(
      this._geoLocationUtilForeGroundUseCase,
      this.context,
      this.aniController,
      this._mapBallMarkerFactory,
      this.signInUserInfoUseCaseInputPort,
      this.insertBallUseCaseInputPort,
      this.updateBallUseCaseInputPort,
      {this.im001mode,
      this.preSetBallResDto,
      this.preSetFBallTagResDtos}) {
    headBarAddress = '로딩중';
    _im001bottomSheetBodyController = IM001BottomSheetBodyController();
    if (im001mode == IM001Mode.create) {
      var currentWithLastPositionInMemory = _geoLocationUtilForeGroundUseCase!
          .getCurrentWithLastPositionInMemory();
      initCameraPosition = new CameraPosition(
          zoom: 14.56,
          target: LatLng(currentWithLastPositionInMemory!.latitude!,
              currentWithLastPositionInMemory.longitude!));
    } else {
      initCameraPosition = new CameraPosition(
          zoom: 14.56,
          target:
              LatLng(preSetBallResDto!.latitude!, preSetBallResDto!.longitude!));
      currentPosition = initCameraPosition;
    }

    _solidController = SolidController();

    _im001bottomSheetHeaderController = IM001BottomSheetHeaderController();

    bottomWidget = SolidBottomSheet(
      maxHeight: MediaQuery.of(context!).size.height - 150,
      draggableBody: false,
      controller: _solidController,
      bodyColor: Colors.white,
      elevation: 6.0,
      onShow: () {
        aniController!.forward();
        _im001bottomSheetHeaderController!
            .changeHeaderMode(IM001BottomSheetHeaderMode.show);
      },
      onHide: () {
        aniController!.reverse();
        _im001bottomSheetHeaderController!
            .changeHeaderMode(IM001BottomSheetHeaderMode.hide);
      },
      headerBar: IM001BottomSheetHeader(
        onNextBtnTap: () {
          _solidController!.show();
        },
        displayAddress: "로딩중",
        im001bottomSheetHeaderController: _im001bottomSheetHeaderController,
        im001mode: im001mode,
        preSetBallResDto: preSetBallResDto,
      ),
      body: IM001BottomSheetBody(
        initAddress: "로딩중",
        onComplete: onComplete,
        im001bottomSheetBodyController: _im001bottomSheetBodyController,
        onChangeAddress: (value) {
          _im001bottomSheetHeaderController!.changeDisplayAddress(value);
        },
        im001mode: im001mode,
        preSetBallResDto: preSetBallResDto,
        preSetFBallTagResDtos: preSetFBallTagResDtos,
      ),
    );
  }

  onComplete(bool value) {
    isCanComplete = value;
    notifyListeners();
  }

  getBottomSheet() {
    return bottomWidget;
  }

  get isBottomOpened {
    return _solidController!.isOpened;
  }

  void onCreateMap(GoogleMapController controller) async {
    _googleMapController.complete(controller);
    Position position;
    if (im001mode == IM001Mode.create) {
      position = await moveToMyPosition();
    } else {
      position = Position(
          latitude: preSetBallResDto!.latitude,
          longitude: preSetBallResDto!.longitude);
    }

    String address =
        await _geoLocationUtilForeGroundUseCase!.getPositionAddress(position);

    _im001bottomSheetBodyController!.changeDisplayAddress(address);

    _im001bottomSheetHeaderController!.changeDisplayAddress(address);

    headBarAddress = address;

    notifyListeners();
  }

  void onCameraIdle() async {
    if (currentPosition != null) {
      var position2 = Position(
          latitude: currentPosition!.target.latitude,
          longitude: currentPosition!.target.longitude);
      String address =
          await _geoLocationUtilForeGroundUseCase!.getPositionAddress(position2);
      _im001bottomSheetBodyController!.changeDisplayAddress(address);
      notifyListeners();
    }
  }

  moveToMyPosition() async {
    var position =
        await _geoLocationUtilForeGroundUseCase!.getCurrentWithLastPosition();
    GoogleMapController mapController = await _googleMapController.future;
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude!, position.longitude!), zoom: 14.5)));
    return position;
  }

  void onCameraMove(CameraPosition position) async {
    currentPosition = position;
  }

  showPreViewDetailPage(BuildContext context) async {
    FBallResDto fBallResDto = FBallResDto();
    fBallResDto.ballName = _im001bottomSheetBodyController!.getBallName();
    fBallResDto.ballDeleteFlag = false;
    fBallResDto.makeTime = DateTime.now();
    fBallResDto.latitude = currentPosition!.target.latitude;
    fBallResDto.longitude = currentPosition!.target.longitude;
    fBallResDto.activationTime = DateTime.now().add(Duration(days: 7));
    fBallResDto.ballHits = 0;
    var reqSignInUserInfoFromMemory =
        signInUserInfoUseCaseInputPort!.reqSignInUserInfoFromMemory();
    fBallResDto.uid =
        FUserInfoSimpleResDto.fromFUserInfoResDto(reqSignInUserInfoFromMemory!);
    fBallResDto.placeAddress =
        _im001bottomSheetBodyController!.getPlaceAddress();
    fBallResDto.commentCount = 0;
    fBallResDto.ballState = FBallState.Play;
    fBallResDto.ballType = FBallType.IssueBall;
    fBallResDto.contributor = 0;
    fBallResDto.ballPower = 0;
    IssueBallDescription issueBallDescription = IssueBallDescription();
    issueBallDescription.text = _im001bottomSheetBodyController!.getContent();
    issueBallDescription.desimages = [];
    issueBallDescription.youtubeVideoId =
        _im001bottomSheetBodyController!.getYoutubeId();
    fBallResDto.description = json.encode(issueBallDescription);
    fBallResDto.ballUuid = "TESTUUuid";
    fBallResDto.activationTime = DateTime.now().add(Duration(days: 7));
    fBallResDto.isEditContent = false;
    fBallResDto.ballLikes = 0;
    fBallResDto.ballDisLikes = 0;
    List<FBallTagResDto> fBallTagResDtos = [];
    var tags = _im001bottomSheetBodyController!.getTags();

    for (int i = 0; i < tags.length; i++) {
      FBallTagResDto fBallTagResDto = new FBallTagResDto();
      fBallTagResDto.ballUuid = "TESTUUuid";
      fBallTagResDto.tagItem = tags[i].text;
      fBallTagResDto.idx = i;
      fBallTagResDto.tagIndex = i;
      fBallTagResDtos.add(fBallTagResDto);
    }

    showDialog(
        context: context,
        builder: (context) => ID01MainPage(
          onCreateBall: _onCreateBall,
          preViewResDto: fBallResDto,
          preViewBallImage: _im001bottomSheetBodyController!.getBallImages(),
          id01Mode: ID01Mode.preview,
          preViewfBallTagResDtos: fBallTagResDtos,
        ),
       );
  }

  _onCreateBall() async {
    showDialog(context: context!, builder: (context) => CommonLoadingComponent());

    FBallInsertReqDto fBallInsertReqDto = FBallInsertReqDto();

    var imageItems =
        await _im001bottomSheetBodyController!.updateImageAndFillImageUrl();

    IssueBallDescription issueBallDescription = IssueBallDescription();

    issueBallDescription.text = _im001bottomSheetBodyController!.getContent();

    issueBallDescription.desimages = [];
    for (int i = 0; i < imageItems.length; i++) {
      FBallDesImages fBallDesImages = new FBallDesImages();
      var item = imageItems[i];
      if(item != null){
        fBallDesImages.src = item.imageUrl;
      }
      fBallDesImages.index = i;
      issueBallDescription.desimages!.add(fBallDesImages);
    }
    issueBallDescription.youtubeVideoId =
        _im001bottomSheetBodyController!.getYoutubeId();

    fBallInsertReqDto.ballName = _im001bottomSheetBodyController!.getBallName();
    fBallInsertReqDto.description = json.encode(issueBallDescription);
    fBallInsertReqDto.ballType = FBallType.IssueBall;
    fBallInsertReqDto.placeAddress =
        _im001bottomSheetBodyController!.getPlaceAddress();
    fBallInsertReqDto.latitude = currentPosition!.target.latitude;
    fBallInsertReqDto.longitude = currentPosition!.target.longitude;
    fBallInsertReqDto.ballUuid = Uuid().v4();

    var tags = _im001bottomSheetBodyController!.getTags();
    fBallInsertReqDto.tags = [];
    for (int i = 0; i < tags.length; i++) {
      TagInsertReqDto tagInsertReqDto = TagInsertReqDto();
      tagInsertReqDto.ballUuid = fBallInsertReqDto.ballUuid;
      tagInsertReqDto.tagItem = tags[i].text;
      fBallInsertReqDto.tags!.add(tagInsertReqDto);
    }

    var fBallResDto =
        await insertBallUseCaseInputPort!.insertBall(fBallInsertReqDto);

    Navigator.of(context!).pop();
    Navigator.of(context!).pop();
    Navigator.of(context!).pop(fBallResDto);

    notifyListeners();
  }

  _onModifyBall() async {
    showDialog(context: context!, builder: (context) => CommonLoadingComponent());

    var imageItems =
        await _im001bottomSheetBodyController!.updateImageAndFillImageUrl();

    FBallUpdateReqDto fBallUpdateReqDto = FBallUpdateReqDto();
    IssueBallDescription issueBallDescription = IssueBallDescription();

    issueBallDescription.text = _im001bottomSheetBodyController!.getContent();

    issueBallDescription.desimages = [];
    for (int i = 0; i < imageItems.length; i++) {
      FBallDesImages fBallDesImages = new FBallDesImages();
      var item = imageItems[i];
      if(item != null){
        fBallDesImages.src = item.imageUrl;
      }
      fBallDesImages.index = i;
      issueBallDescription.desimages!.add(fBallDesImages);
    }
    issueBallDescription.youtubeVideoId =
        _im001bottomSheetBodyController!.getYoutubeId();

    fBallUpdateReqDto.ballName = _im001bottomSheetBodyController!.getBallName();
    print(fBallUpdateReqDto.ballName);
    fBallUpdateReqDto.description = json.encode(issueBallDescription);
    fBallUpdateReqDto.ballType = FBallType.IssueBall;
    fBallUpdateReqDto.placeAddress =
        _im001bottomSheetBodyController!.getPlaceAddress();
    fBallUpdateReqDto.latitude = currentPosition!.target.latitude;
    fBallUpdateReqDto.longitude = currentPosition!.target.longitude;
    fBallUpdateReqDto.ballUuid = preSetBallResDto!.ballUuid;

    var tags = _im001bottomSheetBodyController!.getTags();
    fBallUpdateReqDto.tags = [];
    for (int i = 0; i < tags.length; i++) {
      TagInsertReqDto tagInsertReqDto = TagInsertReqDto();
      tagInsertReqDto.ballUuid = fBallUpdateReqDto.ballUuid;
      tagInsertReqDto.tagItem = tags[i].text;
      fBallUpdateReqDto.tags!.add(tagInsertReqDto);
    }

    var fBallResDto =
        await updateBallUseCaseInputPort!.updateBall(fBallUpdateReqDto);

    Navigator.of(context!).pop();
    Navigator.of(context!).pop();
    Navigator.of(context!).pop(fBallResDto);

    notifyListeners();
  }

  void gotoAddressSearchPage() {
    Navigator.of(context!).push(MaterialPageRoute(builder: (_) {
      return H010MainView(
          inputSearchBarListener: this,
          searchHistoryDataSourceKey:
              SearchHistoryDataSourceKey.AddressSearchHistoryDataSource);
    }));
  }

  //지도 찾기
  @override
  Future<void> onSearch(String search, {BuildContext? context}) async {
    Navigator.of(this.context!).pop();
    Navigator.of(this.context!).push(MaterialPageRoute(builder: (_) {
      return H008MainView(
          initSearchText: search, placeListFromSearchTextWidgetListener: this);
    }));
  }

  @override
  onPlaceListTabPosition(Position position) async {
    Navigator.of(context!).pop();
    GoogleMapController mapController = await _googleMapController.future;
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude!, position.longitude!), zoom: 14.5)));

    headBarAddress =
        await _geoLocationUtilForeGroundUseCase!.getPositionAddress(position);
  }
}
