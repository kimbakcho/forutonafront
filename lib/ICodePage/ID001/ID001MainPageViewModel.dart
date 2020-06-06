import 'dart:async';
import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:forutonafront/FBall/Data/Value/FBallType.dart';
import 'package:forutonafront/FBall/Dto/FBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallValuation/FBallValuationInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallValuation/FBallValuationReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallValuation/FBallValuationResDto.dart';
import 'package:forutonafront/FBall/MarkerSupport/Style2/FBallResForMarkerStyle2Dto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallSupport/BallImageViwer.dart';
import 'package:forutonafront/FBall/Repository/FBallValuationRepository.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserReqDto.dart';
import 'package:forutonafront/ForutonaUser/Repository/FUserRepository.dart';
import 'package:forutonafront/GlobalModel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as Youtube;


class ID001MainPageViewModel extends ChangeNotifier {
  final BuildContext context;

  ScrollController mainScrollController = new ScrollController();

  FUserRepository _fUserRepository = new FUserRepository();

  FBallResDto fBallResDto;
  bool showMoreDetailFlag = false;
  FUserInfoResDto makerUserInfo;

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
  TagRepository _tagRepository = new TagRepository();
  List<Chip> tagChips = [];

  //UnAndDown 관련
  String userNickName = "로 딩 중";
  FBallValuationRepository _fBallValuationRepository =
      FBallValuationRepository();
  FBallValuationResDto fBallValuationResDto;
  bool isInitFinish = false;

  bool _isLoading = false;
  getIsLoading() {
    return _isLoading;
  }

  _setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  final String fBallUuid;

  ID001MainPageViewModel({@required this.context, this.fBallUuid,this.fBallResDto}) {
    _init();
  }

  _init() async {
    mainScrollController.addListener(onScrollControllerListener);
    if(fBallResDto == null ){
      isInitFinish = false;
      _setIsLoading(true);
      var fBallTypeRepository = FBallTypeRepository.create(FBallType.IssueBall);
      var currentFBallResDto = await fBallTypeRepository
          .selectBall(FBallReqDto(FBallType.IssueBall, this.fBallUuid));
      this.fBallResDto = currentFBallResDto;
      _setIsLoading(false);
    }
    initialCameraPosition = CameraPosition(
        target: LatLng(fBallResDto.latitude, fBallResDto.longitude),
        zoom: 14.425);
//    issueBallDescriptionDto =
//        IssueBallDescriptionDto.fromJson(json.decode(fBallResDto.description));
    if (issueBallDescriptionDto.youtubeVideoId != null) {
      youtubeLoad(issueBallDescriptionDto.youtubeVideoId);
    }
    tagLoad(fBallResDto.ballUuid);

    makerUserInfo =
        await _fUserRepository.getUserInfoSimple1(FUserReqDto(fBallResDto.uid));

    loadFBallValuation();
    isInitFinish= true;

    notifyListeners();
  }

  onScrollControllerListener(){
    notifyListeners();
  }
  isBallNameScrollOver(){
    if(mainScrollController.hasClients && mainScrollController.offset > 305){
      return true;
    }else {
      return false;
    }
  }

  bool showFBallValuation() {
    GlobalModel globalModel = Provider.of(context, listen: false);
    if (globalModel.fUserInfoDto != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> loadFBallValuation() async {
    GlobalModel globalModel = Provider.of(context, listen: false);
    userNickName = globalModel.fUserInfoDto.nickName;
    FBallValuationReqDto valuationReqDto = FBallValuationReqDto();
    valuationReqDto.ballUuid = fBallResDto.ballUuid;
    valuationReqDto.uid =
        Provider.of<GlobalModel>(context, listen: false).fUserInfoDto.uid;
    var fBallValuationWrapResDto =
        await _fBallValuationRepository.getFBallValuation(valuationReqDto);
    if (fBallValuationWrapResDto.count == 1) {
      fBallValuationResDto = fBallValuationWrapResDto.contents[0];
    }
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

  Future<void> tagLoad(String ballUuid) async {
    var tagResDtoWrap =
        await _tagRepository.tagFromBallUuid(TagFromBallReqDto(ballUuid));
    List<TagResDto> tags = tagResDtoWrap.tags;
    tagChips.clear();
    for (var o in tags) {
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

  ImageProvider getMakerUserImage() {
    if (makerUserInfo != null && makerUserInfo.profilePictureUrl.length != 0) {
      return NetworkImage(makerUserInfo.profilePictureUrl);
    } else {
      return AssetImage("assets/basicprofileimage.png");
    }
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
        issueBallDescriptionDto.desimages,
        null,
        initIndex: indexNumber,
      );
    }));
  }

  Container getImageContentBar(BuildContext context) {
    switch (issueBallDescriptionDto.desimages.length) {
      case 0:
        {
          return Container();
        }
        break;
      case 1:
        {
          return Container(
              height: 260.00,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: FlatButton(
                onPressed: () {
                  jumpToBallImageViewer(0);
                },
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image:
                        NetworkImage(issueBallDescriptionDto.desimages[0].src),
                  ),
                  borderRadius: BorderRadius.circular(12.00)));
        }
      case 2:
        {
          return Container(
            height: 260.00,
            margin: EdgeInsets.only(bottom: 24),
            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Row(children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                      margin: EdgeInsets.only(right: 1),
                      height: 260.00,
                      child: FlatButton(
                        onPressed: () {
                          jumpToBallImageViewer(0);
                        },
                      ),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                issueBallDescriptionDto.desimages[0].src),
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.00),
                            bottomLeft: Radius.circular(12.00),
                          )))),
              Expanded(
                  flex: 1,
                  child: Container(
                      margin: EdgeInsets.only(left: 1),
                      height: 260.00,
                      child: FlatButton(
                        onPressed: () {
                          jumpToBallImageViewer(1);
                        },
                      ),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                issueBallDescriptionDto.desimages[1].src),
                          ),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12.00),
                            bottomRight: Radius.circular(12.00),
                          ))))
            ]),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.00),
            ),
          );
        }
        break;
      case 3:
        {
          return Container(
              height: 260.00,
              margin: EdgeInsets.only(bottom: 24),
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Container(
                          margin: EdgeInsets.only(right: 2),
                          height: 260.00,
                          child: FlatButton(
                            onPressed: () {
                              jumpToBallImageViewer(0);
                            },
                          ),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    issueBallDescriptionDto.desimages[0].src),
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12.00),
                                bottomLeft: Radius.circular(12.00),
                              )))),
                  Column(children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                            margin: EdgeInsets.only(bottom: 1),
                            child: FlatButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () {
                                jumpToBallImageViewer(1);
                              },
                            ),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      issueBallDescriptionDto.desimages[1].src),
                                ),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12.00),
                                )))),
                    Expanded(
                        flex: 1,
                        child: Container(
                            margin: EdgeInsets.only(top: 1),
                            child: FlatButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () {
                                jumpToBallImageViewer(2);
                              },
                            ),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      issueBallDescriptionDto.desimages[2].src),
                                ),
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(12.00),
                                ))))
                  ])
                ],
              ));
        }
        break;
      case 4:
        {
          return Container(
              height: 260.00,
              margin: EdgeInsets.only(bottom: 24),
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                        height: 260.00,
                        margin: EdgeInsets.only(right: 2),
                        child: FlatButton(
                          onPressed: () {
                            jumpToBallImageViewer(0);
                          },
                        ),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                issueBallDescriptionDto.desimages[0].src),
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.00),
                            bottomLeft: Radius.circular(12.00),
                          ),
                        )),
                  ),
                  Column(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                            margin: EdgeInsets.only(bottom: 1),
                            child: FlatButton(onPressed: () {
                              jumpToBallImageViewer(1);
                            }),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      issueBallDescriptionDto.desimages[1].src),
                                ),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12.00),
                                ))),
                      ),
                      Expanded(
                          flex: 1,
                          child: Container(
                              margin: EdgeInsets.only(bottom: 1, top: 1),
                              child: FlatButton(
                                onPressed: () {
                                  jumpToBallImageViewer(2);
                                },
                              ),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    issueBallDescriptionDto.desimages[2].src),
                              )))),
                      Expanded(
                          flex: 1,
                          child: Container(
                              margin: EdgeInsets.only(top: 1),
                              child: FlatButton(
                                onPressed: () {
                                  jumpToBallImageViewer(3);
                                },
                              ),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          issueBallDescriptionDto
                                              .desimages[3].src)),
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(12.00),
                                  ))))
                    ],
                  ),
                ],
              ));
        }
        break;
      default:
        {
          return Container(
              height: 260.00,
              margin: EdgeInsets.only(bottom: 24),
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                        height: 260.00,
                        margin: EdgeInsets.only(right: 2),
                        child: FlatButton(
                          onPressed: () {
                            jumpToBallImageViewer(0);
                          },
                        ),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                issueBallDescriptionDto.desimages[0].src),
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.00),
                            bottomLeft: Radius.circular(12.00),
                          ),
                        )),
                  ),
                  Column(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                            margin: EdgeInsets.only(bottom: 1),
                            child: FlatButton(
                              onPressed: () {
                                jumpToBallImageViewer(1);
                              },
                            ),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      issueBallDescriptionDto.desimages[1].src),
                                ),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12.00),
                                ))),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                            margin: EdgeInsets.only(top: 1, bottom: 1),
                            child: FlatButton(
                              onPressed: () {
                                jumpToBallImageViewer(2);
                              },
                            ),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  issueBallDescriptionDto.desimages[2].src),
                            ))),
                      ),
                      Expanded(
                          flex: 1,
                          child: Container(
                              margin: EdgeInsets.only(top: 1),
                              child: Container(
                                child: FlatButton(
                                    onPressed: () {
                                      jumpToBallImageViewer(3);
                                    },
                                    child: Text(
                                        "더 보기 +${issueBallDescriptionDto.desimages.length - 4}",
                                        style: TextStyle(
                                          fontFamily: "Noto Sans CJK KR",
                                          fontWeight: FontWeight.w700,
                                          fontSize: 10,
                                          color: Color(0xfff2f0f1),
                                        ))),
                                decoration: BoxDecoration(
                                  color: Color(0xff454f63).withOpacity(0.90),
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(12.00)),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Color(0xff454f63).withOpacity(0.90),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          issueBallDescriptionDto
                                              .desimages[3].src)),
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(12.00),
                                  ))))
                    ],
                  )
                ],
              ));
        }
        break;
    }
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



  isPlusStatue() {
    if (fBallValuationResDto != null && fBallValuationResDto.upAndDown > 0) {
      return true;
    } else {
      return false;
    }
  }

  isMinusStatue() {
    if (fBallValuationResDto != null && fBallValuationResDto.upAndDown < 0) {
      return true;
    } else {
      return false;
    }
  }

  void onPlusBtn() async {
//    _setIsLoading(true);
    if (fBallResDto.activationTime.isBefore(DateTime.now())) {
      return;
    }
    if (isPlusStatue()) {
      deleteValueation(1);

    } else if (isMinusStatue()) {
      deleteValueation(-1);
      onFBallValuation(1);

    } else {
      onFBallValuation(1);
    }
    notifyListeners();

//    _setIsLoading(false);
  }

  void onMinusBtn() async {
//    _setIsLoading(true);
    if (fBallResDto.activationTime.isBefore(DateTime.now())) {
      return;
    }
    if (isMinusStatue()) {
      deleteValueation(-1);

    } else if (isPlusStatue()) {
      deleteValueation(1);
      onFBallValuation(-1);

    } else {
      onFBallValuation(-1);
    }
    notifyListeners();
  }

  void deleteValueation(int deletePoint) {
    _fBallValuationRepository
        .deleteFBallValuation(fBallValuationResDto.valueUuid);
    fBallValuationResDto = null;
    makerUserInfo.cumulativeInfluence = (makerUserInfo.cumulativeInfluence - deletePoint);
    if(deletePoint > 0) {
      fBallResDto.ballLikes = fBallResDto.ballLikes - deletePoint.abs();
    }else {
      fBallResDto.ballDisLikes = fBallResDto.ballDisLikes - deletePoint.abs();
    }
    fBallResDto.contributor--;
  }

  Future onFBallValuation(int unAndDown) async {
    FBallValuationInsertReqDto reqDto = FBallValuationInsertReqDto();
    reqDto.valueUuid = Uuid().v4();
    reqDto.ballUuid = fBallResDto.ballUuid;
    reqDto.uid =
        Provider.of<GlobalModel>(context, listen: false).fUserInfoDto.uid;
    reqDto.unAndDown = unAndDown;
     _fBallValuationRepository.insertFBallValuation(reqDto);

    if(fBallValuationResDto == null) {
      fBallValuationResDto = new FBallValuationResDto();
      fBallValuationResDto.valueUuid = reqDto.valueUuid;
      fBallValuationResDto.ballUuid = reqDto.ballUuid;
      fBallValuationResDto.uid = reqDto.uid;
      fBallValuationResDto.upAndDown = reqDto.unAndDown;
    }
    makerUserInfo.cumulativeInfluence = (makerUserInfo.cumulativeInfluence + unAndDown);
    if(unAndDown > 0) {
      fBallResDto.ballLikes = fBallResDto.ballLikes + unAndDown.abs();
    }else {
      fBallResDto.ballDisLikes = fBallResDto.ballDisLikes + unAndDown.abs();
    }
    fBallResDto.contributor++;
  }

  getFBallValuationText() {
    if (fBallResDto.activationTime.isBefore(DateTime.now())) {
      return "평가 시간이 완료 되었습니다.";
    } else if (fBallValuationResDto == null) {
      return "님 평가를 해주세요.";
    } else if (fBallValuationResDto != null) {
      return "님 평가해 주셔서 감사합니다.";
    } else {
      return "";
    }
  }

  getValuationIconAndTextColor(FBallValuationState state) {
    if (state == FBallValuationState.Like) {
      if (fBallValuationResDto == null) {
        return Color(0xff454F63);
      } else if (isPlusStatue()) {
        return Colors.white;
      } else if (isMinusStatue()) {
        return Color(0xffB1B1B1);
      } else {
        return Color(0xff454F63);
      }
    } else {
      if (fBallValuationResDto == null) {
        return Color(0xff454F63);
      } else if (isPlusStatue()) {
        return Color(0xffB1B1B1);
      } else if (isMinusStatue()) {
        return Colors.white;
      } else {
        return Color(0xff454F63);
      }
    }
  }

  getValuationBorderColor(FBallValuationState state) {
    if (state == FBallValuationState.Like) {
      if (fBallValuationResDto == null) {
        return Color(0xff454F63);
      } else if (isPlusStatue()) {
        return Color(0xff4F72FF);
      } else if (isMinusStatue()) {
        return Color(0xffC1C2C2);
      } else {
        return Color(0xff454F63);
      }
    } else {
      if (fBallValuationResDto == null) {
        return Color(0xff454F63);
      } else if (isPlusStatue()) {
        return Color(0xffC1C2C2);
      } else if (isMinusStatue()) {
        return Color(0xff4F72FF);
      } else {
        return Color(0xff454F63);
      }
    }
  }

  getValuationBoxColor(FBallValuationState state) {
    if (state == FBallValuationState.Like) {
      if (fBallValuationResDto == null) {
        return Colors.white;
      } else if (isPlusStatue()) {
        return Color(0xff4F72FF);
      } else if (isMinusStatue()) {
        return Colors.white;
      } else {
        return Colors.white;
      }
    } else {
      if (fBallValuationResDto == null) {
        return Colors.white;
      } else if (isPlusStatue()) {
        return Colors.white;
      } else if (isMinusStatue()) {
        return Color(0xff4F72FF);
      } else {
        return Colors.white;
      }
    }
  }

  void showBallSetting() async {
    BallModifyService ballModifyService = IssueBallModifyService();
    if (await ballModifyService.isCanModify(fBallResDto.uid)) {
      var result = await ballModifyService.showModifySelectDialog(context, fBallResDto.ballType,fBallResDto.ballUuid);
      if (result == CommonBallModifyWidgetResultType.Delete) {
        Navigator.of(context).pop();
      } else if (result == CommonBallModifyWidgetResultType.Update) {
        reFreshBall();
      }
    }
  }

  void reFreshBall() {
    this.fBallResDto = null;
    this._init();
  }

}

enum FBallValuationState { Like, DisLike }
