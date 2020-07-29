import 'dart:async';
import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallValuation.dart';
import 'package:forutonafront/FBall/Data/Entity/IssueBall.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBall/FBallUseCaseInputPort.dart';

import 'package:forutonafront/FBall/Domain/UseCase/FBallValuation/IssueBall/IssueBallValuationUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallValuation/IssueBall/IssueBallValuationUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallValuation/FBallValuationInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallValuation/FBallValuationReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallValuation/FBallValuationResDto.dart';
import 'package:forutonafront/FBall/MarkerSupport/Style2/FBallResForMarkerStyle2Dto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallDescriptionImageViewer/BallDesciprtionImageViwer.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallImageViewer/BallImageViwer.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallModify/BallModifyService.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallModify/Impl/IssueBallModifyService.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallModify/Widget/CommonBallModifyWidgetResultType.dart';
import 'package:forutonafront/ForutonaUser/Data/Entity/FUserInfoSimple1.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseOutputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserInfoSimple1/UserInfoSimple1UseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserInfoSimple1/UserInfoSimple1UseCaseOutputPort.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoSimple1ResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserReqDto.dart';
import 'package:forutonafront/HCodePage/H005/H005MainPage.dart';
import 'package:forutonafront/HCodePage/H005/H005PageState.dart';
import 'package:forutonafront/ICodePage/IM001/IM001MainPage.dart';
import 'package:forutonafront/ICodePage/IM001/IM001MainPageEnterMode.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:forutonafront/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCaseInputPort.dart';
import 'package:forutonafront/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCaseOutputPort.dart';
import 'package:forutonafront/Tag/Dto/FBallTagResDto.dart';
import 'package:forutonafront/Tag/Dto/TagFromBallReqDto.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as Youtube;

class ID001MainPageViewModel extends ChangeNotifier
    implements
        TagFromBallUuidUseCaseOutputPort,
        UserInfoSimple1UseCaseOutputPort,
        IssueBallValuationUseCaseOutputPort,
        AuthUserCaseOutputPort {
  final BuildContext context;
  final ScrollController mainScrollController;
  final FBallUseCaseInputPort _issueBallUseCaseInputPort;
  final UserInfoSimple1UseCaseInputPort _userInfoSimple1UseCaseInputPort;
  final AuthUserCaseInputPort _authUserCaseInputPort;
  final TagFromBallUuidUseCaseInputPort _tagFromBallUuidUseCaseInputPort;
  final IssueBallValuationUseCaseInputPort _issueBallValuationUseCaseInputPort;
  final SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;

  IssueBall issueBall;

  bool showMoreDetailFlag = false;
  FUserInfoSimple1 makerUserInfo;

  //googleMap 관련
  CameraPosition initialCameraPosition;
  List<FBallResForMarkerStyle2Dto> ballList;

  //Youtube 관련
  Youtube.YoutubeExplode _youtubeExplode = Youtube.YoutubeExplode();
  String currentYoutubeImage;
  String currentYoutubeTitle;
  String currentYoutubeAuthor;
  int currentYoutubeView;
  DateTime currentYoutubeUploadDate;

  List<Chip> tagChips = [];
  double tagChipHeight = 20.0;

  String userNickName = "로 딩 중";

  FBallValuation fBallValuation = FBallValuation();

  bool isInitFinish = false;
  bool isLoading = false;
  bool showFBallValuation = false;

  ID001MainPageViewModel({
    @required this.context,
    @required this.issueBall,
    @required this.mainScrollController,
    @required FBallUseCaseInputPort issueBallUseCaseInputPort,
    @required UserInfoSimple1UseCaseInputPort userInfoSimple1UseCaseInputPort,
    @required AuthUserCaseInputPort authUserCaseInputPort,
    @required TagFromBallUuidUseCaseInputPort tagFromBallUuidUseCaseInputPort,
    @required
        IssueBallValuationUseCaseInputPort issueBallValuationUseCaseInputPort,
    @required SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort,
  })  : _issueBallUseCaseInputPort = issueBallUseCaseInputPort,
        _userInfoSimple1UseCaseInputPort = userInfoSimple1UseCaseInputPort,
        _authUserCaseInputPort = authUserCaseInputPort,
        _tagFromBallUuidUseCaseInputPort = tagFromBallUuidUseCaseInputPort,
        _issueBallValuationUseCaseInputPort =
            issueBallValuationUseCaseInputPort,
        _signInUserInfoUseCaseInputPort = signInUserInfoUseCaseInputPort {
    _init();
  }

  _init() async {
    turnUserScreen();

    googleMapInitCameraPositionSetting();

    issueBallYoutubeSetting();

    loadTagFromBall();

    reqBallMakerInfo();

    loadFBallValuation();

    isInitFinish = true;

    mainScrollController.addListener(mainScrollListener);

    notifyListeners();
  }

  Future<FUserInfoSimple1ResDto> reqBallMakerInfo() {
    return _userInfoSimple1UseCaseInputPort.getBallMakerInfo(
        makerUid: FUserReqDto(issueBall.uid), outputPort: this);
  }

  Future<List<FBallTagResDto>> loadTagFromBall() {
    return _tagFromBallUuidUseCaseInputPort.getTagFromBallUuid(
        reqDto: TagFromBallReqDto(ballUuid: issueBall.ballUuid),
        outputPort: this);
  }

  void turnUserScreen() {
    _authUserCaseInputPort.isLogin(authUserCaseOutputPort: this);
  }

  void issueBallYoutubeSetting() {
    if (issueBall.hasYoutubeVideo()) {
      youtubeLoad(issueBall.getDisplayYoutubeVideoId());
    }
  }

  void googleMapInitCameraPositionSetting() {
    initialCameraPosition = CameraPosition(
        target: LatLng(issueBall.latitude, issueBall.longitude), zoom: 14.425);
  }

  @override
  onBallMakerInfo(FUserInfoSimple1ResDto fUserInfoSimple1ResDto) {
    makerUserInfo =
        FUserInfoSimple1.fromFUserInfoSimple1ResDto(fUserInfoSimple1ResDto);
    notifyListeners();
  }

  isBallNameScrollOver() {
    if (mainScrollController.hasClients && mainScrollController.offset > 305) {
      return true;
    } else {
      return false;
    }
  }

  @override
  onLoginCheck(bool isLogin) {
    if (isLogin) {
      var fUserInfo =
          _signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory();
      userNickName = fUserInfo.nickName;
      showFBallValuation = true;
    }
    notifyListeners();
  }

  Future<void> loadFBallValuation() async {
    if (await _authUserCaseInputPort.isLogin()) {
      FBallValuationReqDto valuationReqDto = FBallValuationReqDto();
      valuationReqDto.ballUuid = issueBall.ballUuid;
      valuationReqDto.uid = await _authUserCaseInputPort.myUid();
      _issueBallValuationUseCaseInputPort.getFBallValuation(
          reqDto: valuationReqDto, outputPort: this);
    }
  }

  @override
  onFBallValuation(FBallValuationResDto fBallValuationResDto) {
    this.fBallValuation =
        FBallValuation.fromFBallValuationResDto(fBallValuationResDto);
    notifyListeners();
  }

  youtubeLoad(String videoId) async {
    var video = await _youtubeExplode.videos.get(videoId);
    if (video.thumbnails.highResUrl != null) {
      currentYoutubeImage = video.thumbnails.highResUrl;
    } else if (video.thumbnails.mediumResUrl != null) {
      currentYoutubeImage = video.thumbnails.mediumResUrl;
    } else {
      currentYoutubeImage = video.thumbnails.lowResUrl;
    }
    currentYoutubeTitle = video.title;
    currentYoutubeAuthor = video.author;
    currentYoutubeView = video.engagement.viewCount;
    currentYoutubeUploadDate = video.uploadDate;

    notifyListeners();
  }

  @override
  onTagFromBallUuid(List<FBallTagResDto> ballTags) {
    tagChips.clear();
    addTagWidget(ballTags);
    notifyListeners();
  }

  void addTagWidget(List<FBallTagResDto> ballTags) {
    for (var o in ballTags) {
      tagChips.add(Chip(
          backgroundColor: Color(0xffE4E7E8),
          label: Container(
            height: tagChipHeight,
            child: InkWell(
              onTap: () {
                gotoH005TagInitPage(tagText: o.tagItem);
              },
              child: Text("#${o.tagItem}",
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: Color(0xff454f63),
                  )),
            ),
          )));
    }
  }

  void gotoH005TagInitPage({@required String tagText}) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return H005MainPage(
          searchText: tagText, initPageState: H005PageState.Tag);
    }));
  }

  void backBtnTap() {
    Navigator.of(context).pop();
  }

  void toggleMoreDetailToggle() {
    showMoreDetailFlag = !showMoreDetailFlag;
    notifyListeners();
  }

  String getMakerUserNickName() {
    if (makerUserInfo != null) {
      return makerUserInfo.nickName;
    } else {
      return "로딩중";
    }
  }

  jumpToBallImageViewer(int indexNumber) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return BallImageViewer(
        issueBall.getDesImages(),
        null,
        initIndex: indexNumber,
      );
    }));
  }

  Widget getImageContentBar(BuildContext context) {
    return BallDescriptionImageViewer.descriptionImages(
            desImages: issueBall.getDesImages(), context: context)
        .getImageViewerWidget();
  }

  Future<void> goYoutubeIntent(String youtubeVideoId) async {
    if (Platform.isAndroid) {
      try {
        AndroidIntent intent = AndroidIntent(
            action: 'action_view', data: "vnd.youtube:$youtubeVideoId");
        await intent.launch();
      } catch (ex) {
        AndroidIntent intent = AndroidIntent(
            action: 'action_view',
            data: "https://www.youtube.com/watch?v=$youtubeVideoId");
        await intent.launch();
      }
    }
  }

  void plusBtnTap() async {
    if (issueBall.isDeadBall()) {
      return;
    }
    if (fBallValuation.isLikeState()) {
      deleteValuation(1);
    } else if (fBallValuation.isDisLikeState()) {
      deleteValuation(-1);
      valuationSave(1);
    } else {
      valuationSave(1);
    }
  }

  void minusBtnTap() async {
    if (issueBall.isDeadBall()) {
      return;
    }
    if (fBallValuation.isLikeState()) {
      deleteValuation(1);
      valuationSave(-1);
    } else if (fBallValuation.isDisLikeState()) {
      deleteValuation(-1);
    } else {
      valuationSave(-1);
    }
    notifyListeners();
  }

  void deleteValuation(int deletePoint) {
    _issueBallValuationUseCaseInputPort.deleteFBallValuation(
        valueUuid: fBallValuation.valueUuid,
        deletePoint: deletePoint,
        outputPort: this);
  }

  @override
  onDeleteFBallValuation(int deletePoint) {
    fBallValuation = new FBallValuation();
    if (isDeleteBeforeStateLike(deletePoint)) {
      issueBall.minusBallLike(deletePoint.abs());
      makerUserInfo.minusCumulativeInfluence(deletePoint);
    } else {
      issueBall.minusBallDisLike(deletePoint.abs());
      makerUserInfo.plusCumulativeInfluence(deletePoint);
    }
    issueBall.minusContributorCount();
    notifyListeners();
  }

  bool isDeleteBeforeStateLike(int deletePoint) => deletePoint > 0;

  @override
  onSave(FBallValuationResDto fBallValuationResDto) {
    if (isUserSaveValuationLike(fBallValuationResDto)) {
      issueBall.plusBallLike(fBallValuationResDto.upAndDown);
      makerUserInfo.plusCumulativeInfluence(fBallValuationResDto.upAndDown);
    } else {
      issueBall.plusBallDisLike(fBallValuationResDto.upAndDown);
      makerUserInfo.minusCumulativeInfluence(fBallValuationResDto.upAndDown);
    }
    this.fBallValuation =
        FBallValuation.fromFBallValuationResDto(fBallValuationResDto);
    notifyListeners();
  }

  bool isUserSaveValuationLike(FBallValuationResDto fBallValuationResDto) =>
      fBallValuationResDto.upAndDown > 0;

  void valuationSave(int point) async {
    FBallValuationInsertReqDto reqDto = FBallValuationInsertReqDto(
        ballUuid: issueBall.ballUuid,
        uid: await _authUserCaseInputPort.myUid(),
        upAndDown: point,
        valueUuid: Uuid().v4());
    _issueBallValuationUseCaseInputPort.save(reqDto: reqDto, outputPort: this);
  }

  getFBallValuationText() {
    if (issueBall.isDeadBall()) {
      return "평가 시간이 완료 되었습니다.";
    } else if (!fBallValuation.hasValuation()) {
      return "님 평가를 해주세요.";
    } else if (fBallValuation.hasValuation()) {
      return "님 평가해 주셔서 감사합니다.";
    } else {
      return "";
    }
  }

  getValuationIconAndTextColor(FBallValuationState state) {
    if (state == FBallValuationState.Like) {
      return getValuationLikeStateColor();
    } else {
      return getValuationDisLikeColor();
    }
  }

  Color getValuationDisLikeColor() {
    if (!fBallValuation.hasValuation()) {
      return Color(0xff454F63);
    } else if (fBallValuation.isLikeState()) {
      return Color(0xffB1B1B1);
    } else if (fBallValuation.isDisLikeState()) {
      return Colors.white;
    } else {
      return Color(0xff454F63);
    }
  }

  Color getValuationLikeStateColor() {
    if (!fBallValuation.hasValuation()) {
      return Color(0xff454F63);
    } else if (fBallValuation.isLikeState()) {
      return Colors.white;
    } else if (fBallValuation.isDisLikeState()) {
      return Color(0xffB1B1B1);
    } else {
      return Color(0xff454F63);
    }
  }

  getValuationBorderColor(FBallValuationState state) {
    if (state == FBallValuationState.Like) {
      return getLikeValuationBorderColor();
    } else {
      return getDisLikeValuationBorderColor();
    }
  }

  Color getDisLikeValuationBorderColor() {
    if (!fBallValuation.hasValuation()) {
      return Color(0xff454F63);
    } else if (fBallValuation.isLikeState()) {
      return Color(0xffC1C2C2);
    } else if (fBallValuation.isDisLikeState()) {
      return Color(0xff4F72FF);
    } else {
      return Color(0xff454F63);
    }
  }

  Color getLikeValuationBorderColor() {
    if (!fBallValuation.hasValuation()) {
      return Color(0xff454F63);
    } else if (fBallValuation.isLikeState()) {
      return Color(0xff4F72FF);
    } else if (fBallValuation.isDisLikeState()) {
      return Color(0xffC1C2C2);
    } else {
      return Color(0xff454F63);
    }
  }

  getValuationBoxColor(FBallValuationState state) {
    if (state == FBallValuationState.Like) {
      return getLikeValuationBoxColor();
    } else {
      return getDisLikeValuationBoxColor();
    }
  }

  Color getDisLikeValuationBoxColor() {
    if (!fBallValuation.hasValuation()) {
      return Colors.white;
    } else if (fBallValuation.isLikeState()) {
      return Colors.white;
    } else if (fBallValuation.isDisLikeState()) {
      return Color(0xff4F72FF);
    } else {
      return Colors.white;
    }
  }

  Color getLikeValuationBoxColor() {
    if (!fBallValuation.hasValuation()) {
      return Colors.white;
    } else if (fBallValuation.isLikeState()) {
      return Color(0xff4F72FF);
    } else if (fBallValuation.isDisLikeState()) {
      return Colors.white;
    } else {
      return Colors.white;
    }
  }

  void showBallSetting() async {
    BallModifyService ballModifyService = IssueBallModifyService(
      authUserCaseInputPort: sl()
    );
    if (await ballModifyService.isCanModify(ballMakeUid: issueBall.uid)) {
      await showModifyDialog(ballModifyService);
    }
  }

  Future showModifyDialog(BallModifyService ballModifyService) async {
    var result =
        await ballModifyService.showModifySelectDialog(context: context);
    if (result == CommonBallModifyWidgetResultType.Delete) {
      await _issueBallUseCaseInputPort.deleteBall(ballUuid: issueBall.ballUuid);
      onDeleteBall();
    } else if (result == CommonBallModifyWidgetResultType.Update) {
      await gotoIM001Page();
      reFreshBall();
    }
  }

  Future gotoIM001Page() async {
    return await Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return IM001MainPage(
          LatLng(issueBall.latitude, issueBall.longitude),
          issueBall.placeAddress,
          issueBall.ballUuid,
          IM001MainPageEnterMode.Update);
    }));
  }

  Future<void> reFreshBall() async {
    isLoading = true;
    var fBallResDto = await _issueBallUseCaseInputPort.selectBall(
        ballUuid: issueBall.ballUuid);
    issueBall.reFreshFromBallResDto(fBallResDto);
    isLoading = false;
  }

  showLoading() {
    isLoading = true;
    notifyListeners();
  }

  hideLoading() {
    isLoading = false;
    notifyListeners();
  }

  mainScrollListener() {
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _youtubeExplode.close();
  }

  void onDeleteBall() {
    issueBall.ballDeleteFlag = true;
    notifyListeners();
  }
}

enum FBallValuationState { Like, DisLike }
