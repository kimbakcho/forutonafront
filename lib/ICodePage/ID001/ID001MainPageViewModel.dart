import 'dart:async';
import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallValuation.dart';
import 'package:forutonafront/FBall/Data/Entity/IssueBall.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallValuation/IssueBall/IssueBallValuationUseCase.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallValuation/IssueBall/IssueBallValuationUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallValuation/IssueBall/IssueBallValuationUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/IssueBall/IssueBallUseCase.dart';
import 'package:forutonafront/FBall/Domain/UseCase/IssueBall/IssueBallUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/IssueBall/IssueBallUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallValuation/FBallValuationInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallValuation/FBallValuationReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallValuation/FBallValuationResDto.dart';
import 'package:forutonafront/FBall/MarkerSupport/Style2/FBallResForMarkerStyle2Dto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallDescriptionImageViewer/BallDesciprtionImageViwer.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallModify/BallModifyService.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallModify/Impl/IssueBallModifyService.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallModify/Widget/CommonBallModifyWidgetResultType.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallSupport/BallImageViwer.dart';
import 'package:forutonafront/ForutonaUser/Data/Entity/FUserInfoSimple1.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseOutputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/FireBaseAuthUseCase.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserInfoSimple1/UserInfoSimple1UseCase.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserInfoSimple1/UserInfoSimple1UseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserInfoSimple1/UserInfoSimple1UseCaseOutputPort.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoSimple1ResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserReqDto.dart';
import 'package:forutonafront/ICodePage/IM001/IM001MainPage.dart';
import 'package:forutonafront/ICodePage/IM001/IM001MainPageEnterMode.dart';
import 'package:forutonafront/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCase.dart';
import 'package:forutonafront/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCaseInputPort.dart';
import 'package:forutonafront/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCaseOutputPort.dart';
import 'package:forutonafront/Tag/Dto/FBallTagResDto.dart';
import 'package:forutonafront/Tag/Dto/TagFromBallReqDto.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as Youtube;

class ID001MainPageViewModel extends ChangeNotifier
    implements
        TagFromBallUuidUseCaseOutputPort,
        UserInfoSimple1UseCaseOutputPort,
        IssueBallValuationUseCaseOutputPort,
        IssueBallUseCaseOutputPort,
        AuthUserCaseOutputPort{
  final BuildContext context;
  IssueBall issueBall;

  ScrollController mainScrollController = new ScrollController();

  bool showMoreDetailFlag = false;
  FUserInfoSimple1 makerUserInfo;

  IssueBallUseCaseInputPort _issueBallUseCaseInputPort = IssueBallUseCase();

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

  //Tag 관련
  TagFromBallUuidUseCaseInputPort _tagFromBallUuidUseCaseInputPort =
      TagFromBallUuidUseCase();
  List<Chip> tagChips = [];

  //UnAndDown 관련
  String userNickName = "로 딩 중";
  IssueBallValuationUseCaseInputPort _issueBallValuationUseCaseInputPort = IssueBallValuationUseCase();
  FBallValuation fBallValuation = FBallValuation();

  //UserInfo 관련
  UserInfoSimple1UseCaseInputPort _userInfoSimple1UseCaseInputPort =
      UserInfoSimple1UseCase();
  AuthUserCaseInputPort _authUserCaseInputPort = FireBaseAuthUseCase();

  bool isInitFinish = false;
  bool _isLoading = false;
  bool showFBallValuation =false;

  get isLoading {
    return _isLoading;
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  ID001MainPageViewModel({@required this.context, @required this.issueBall}) {
    _init();
  }

  _init() async {
    _authUserCaseInputPort.checkLogin(authUserCaseOutputPort: this);
    mainScrollController.addListener(onScrollControllerListener);
    initialCameraPosition = CameraPosition(
        target: LatLng(issueBall.latitude, issueBall.longitude), zoom: 14.425);
    if (issueBall.hasYoutubeVideo()) {
      youtubeLoad(issueBall.getDisplayYoutubeVideoId());
    }
    _tagFromBallUuidUseCaseInputPort.getTagFromBallUuid(
        reqDto: TagFromBallReqDto(ballUuid: issueBall.ballUuid),
        outputPort: this);

    _userInfoSimple1UseCaseInputPort.getUserInfoSimple1(
        reqDto: FUserReqDto(issueBall.uid), outputPort: this);

    loadFBallValuation();
    isInitFinish = true;

    notifyListeners();
  }

  @override
  onUserInfoSimple1(FUserInfoSimple1ResDto fUserInfoSimple1ResDto) {
    makerUserInfo = FUserInfoSimple1.fromFUserInfoSimple1ResDto(fUserInfoSimple1ResDto);
    notifyListeners();
  }

  onScrollControllerListener() {
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
    if(isLogin){
      userNickName = _authUserCaseInputPort.userNickName(context: context);
      showFBallValuation = true;
    }
    notifyListeners();
  }

  Future<void> loadFBallValuation() async {
    FBallValuationReqDto valuationReqDto = FBallValuationReqDto();
    valuationReqDto.ballUuid = issueBall.ballUuid;
    valuationReqDto.uid = await _authUserCaseInputPort.userUid();
    _issueBallValuationUseCaseInputPort.getFBallValuation(reqDto: valuationReqDto,outputPort: this);
  }

  @override
  onFBallValuation(FBallValuationResDto fBallValuationResDto) {
    this.fBallValuation = FBallValuation.fromFBallValuationResDto(fBallValuationResDto);
    notifyListeners();
  }


  youtubeLoad(String videoId) async {
    var video = await _youtubeExplode.getVideo(videoId);
    if (video.thumbnailSet.highResUrl != null) {
      currentYoutubeImage = video.thumbnailSet.highResUrl;
    } else if (video.thumbnailSet.mediumResUrl != null) {
      currentYoutubeImage = video.thumbnailSet.mediumResUrl;
    } else {
      currentYoutubeImage = video.thumbnailSet.lowResUrl;
    }
    currentYoutubeTitle = video.title;
    currentYoutubeAuthor = video.author;
    currentYoutubeView = video.statistics.viewCount;
    currentYoutubeUploadDate = video.uploadDate;
    notifyListeners();
  }

  @override
  onTagFromBallUuid(List<FBallTagResDto> ballTags) {
    tagChips.clear();
    for (var o in ballTags) {
      tagChips.add(Chip(
        backgroundColor: Color(0xffE4E7E8),
        label: Text("#${o.tagItem}",
            style: TextStyle(
              fontFamily: "Noto Sans CJK KR",
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: Color(0xff454f63),
            )),
      ));
    }
    notifyListeners();
  }

  void onBackBtn() {
    Navigator.of(context).pop();
  }

  void showMoreDetailToggle() {
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


  void onPlusBtn() async {
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



  void onMinusBtn() async {
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
    _issueBallValuationUseCaseInputPort.deleteFBallValuation(valueUuid: fBallValuation.valueUuid
        ,deletePoint: deletePoint
        ,outputPort: this);
  }

  @override
  onDeleteFBallValuation(int deletePoint) {
    fBallValuation = new FBallValuation();
    if (deletePoint > 0) {
      issueBall.minusBallLike(deletePoint.abs());
      makerUserInfo.minusCumulativeInfluence(deletePoint);
    } else {
      issueBall.minusBallDisLike(deletePoint.abs());
      makerUserInfo.plusCumulativeInfluence(deletePoint);
    }
    issueBall.minusContributorCount();
    notifyListeners();
  }
  @override
  onSave(FBallValuationResDto fBallValuationResDto) {
    if(fBallValuationResDto.upAndDown > 0){
      issueBall.plusBallLike(fBallValuationResDto.upAndDown);
      makerUserInfo.plusCumulativeInfluence(fBallValuationResDto.upAndDown);
    }else {
      issueBall.plusBallDisLike(fBallValuationResDto.upAndDown);
      makerUserInfo.minusCumulativeInfluence(fBallValuationResDto.upAndDown);
    }
    this.fBallValuation = FBallValuation.fromFBallValuationResDto(fBallValuationResDto);
    notifyListeners();
  }


  void valuationSave(int point) async {
    FBallValuationInsertReqDto reqDto = FBallValuationInsertReqDto(
      ballUuid: issueBall.ballUuid,
      uid: await _authUserCaseInputPort.userUid(),
      upAndDown: point,
      valueUuid: Uuid().v4()
    );
    _issueBallValuationUseCaseInputPort.save(reqDto: reqDto,outputPort: this);
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
      if (!fBallValuation.hasValuation()) {
        return Color(0xff454F63);
      } else if (fBallValuation.isLikeState()) {
        return Colors.white;
      } else if (fBallValuation.isDisLikeState()) {
        return Color(0xffB1B1B1);
      } else {
        return Color(0xff454F63);
      }
    } else {
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
  }

  getValuationBorderColor(FBallValuationState state) {
    if (state == FBallValuationState.Like) {
      if (!fBallValuation.hasValuation()) {
        return Color(0xff454F63);
      } else if (fBallValuation.isLikeState()) {
        return Color(0xff4F72FF);
      } else if (fBallValuation.isDisLikeState()) {
        return Color(0xffC1C2C2);
      } else {
        return Color(0xff454F63);
      }
    } else {
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
  }

  getValuationBoxColor(FBallValuationState state) {
    if (state == FBallValuationState.Like) {
      if (!fBallValuation.hasValuation()) {
        return Colors.white;
      } else if (fBallValuation.isLikeState()) {
        return Color(0xff4F72FF);
      } else if (fBallValuation.isDisLikeState()) {
        return Colors.white;
      } else {
        return Colors.white;
      }
    } else {
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
  }

  void showBallSetting() async {
    BallModifyService ballModifyService = IssueBallModifyService();
    if (await ballModifyService.isCanModify(ballMakeUid: issueBall.uid)) {
      var result = await ballModifyService.showModifySelectDialog(context: context);
      if (result == CommonBallModifyWidgetResultType.Delete) {
        _issueBallUseCaseInputPort.deleteBall(ballUuid: issueBall.ballUuid, outputPort: this);

      } else if (result == CommonBallModifyWidgetResultType.Update) {
        await Navigator.of(context).push(MaterialPageRoute(
          builder: (_){
            return IM001MainPage(LatLng(issueBall.latitude,issueBall.longitude), issueBall.placeAddress,
                issueBall.ballUuid,IM001MainPageEnterMode.Update);
          }
        ));
        reFreshBall();
      }
    }
  }

  Future<void> reFreshBall() async {
    isLoading = true;
    await _issueBallUseCaseInputPort.selectBall(ballUuid: issueBall.ballUuid, outputPort: this);
    isLoading = false;
  }


  @override
  void onBallHit() {
    throw ("here don't have action");
  }

  @override
  void onDeleteBall() {
//    issueBall.ballDeleteFlag = true;
    Navigator.of(context).pop();
  }

  @override
  void onSelectBall(FBallResDto fBallResDto) {
    this.issueBall = IssueBall.fromFBallResDto(fBallResDto);
    _init();
    notifyListeners();
  }

  @override
  void onInsertBall(FBallResDto resDto) {
    throw ("here don't have action");
  }

  @override
  void onUpdateBall() {
    throw("here don't have action");
  }

}

enum FBallValuationState { Like, DisLike }
