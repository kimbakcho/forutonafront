import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:forutonafront/Common/GoogleMapSupport/MapAniCircleController.dart';
import 'package:forutonafront/Common/Tag/Dto/TagFromBallReqDto.dart';
import 'package:forutonafront/Common/Tag/Dto/TagResDto.dart';
import 'package:forutonafront/Common/Tag/Repository/TagRepository.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResWrapDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallType.dart';
import 'package:forutonafront/FBall/Dto/FBallValuation/FBallValuationInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallValuation/FBallValuationReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallValuation/FBallValuationResDto.dart';
import 'package:forutonafront/FBall/Dto/IssueBallDescriptionDto.dart';
import 'package:forutonafront/FBall/MarkerSupport/Style2/FBallResForMarkerStyle2Dto.dart';
import 'package:forutonafront/FBall/MarkerSupport/Style2/MakerSupportStyle2.dart';
import 'package:forutonafront/FBall/Repository/FBallReplyRepository.dart';
import 'package:forutonafront/FBall/Repository/FBallValuationRepository.dart';
import 'package:forutonafront/FBall/Widget/BallSupport/BallImageViwer.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserReqDto.dart';
import 'package:forutonafront/ForutonaUser/Repository/FUserRepository.dart';
import 'package:forutonafront/GlobalModel.dart';
import 'package:forutonafront/ICodePage/ID001/ID001DetailReplyView.dart';
import 'package:forutonafront/JCodePage/J001/J001View.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as Youtube;

import 'ID001InputReplyView.dart';
import 'ID001InputReplyViewModel.dart';

class ID001MainPageViewModel extends ChangeNotifier {
  final BuildContext _context;

  ScrollController mainScrollController = new ScrollController();

  FUserRepository _fUserRepository = new FUserRepository();
  IssueBallDescriptionDto issueBallDescriptionDto;
  final FBallResDto fBallResDto;
  bool showMoreDetailFlag = false;
  FUserInfoResDto makerUserInfo;

  //googleMap 관련
  CameraPosition initialCameraPosition;
  Set<Marker> markers = Set<Marker>();
  List<FBallResForMarkerStyle2Dto> ballList;
  GlobalKey makerAnimationKey = new GlobalKey();
  Set<Circle> circles = Set<Circle>();
  MapAniCircleController googleMapCircleController =
      new MapAniCircleController();

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

  //볼에 레이더 애니메이션을 주기위한 Ticker
  Ticker _ticker;

  //댓글 관련
  int replyCount = 0;
  FBallReplyRepository _fBallReplyRepository = new FBallReplyRepository();
  FBallReplyResWrapDto fBallReplyResWrapDto = new FBallReplyResWrapDto();

  //UnAndDown 관련
  String userNickName = "로 딩 중";
  FBallValuationRepository _fBallValuationRepository =
      FBallValuationRepository();
  FBallValuationResDto fBallValuationResDto;

  ID001MainPageViewModel(this._context, this.fBallResDto) {
    initialCameraPosition = CameraPosition(
        target: LatLng(fBallResDto.latitude, fBallResDto.longitude),
        zoom: 14.425);
    issueBallDescriptionDto =
        IssueBallDescriptionDto.fromJson(json.decode(fBallResDto.description));
    init();
  }

  init() async {
    if (issueBallDescriptionDto.youtubeVideoId != null) {
      youtubeLoad(issueBallDescriptionDto.youtubeVideoId);
    }

     tagLoad(fBallResDto.ballUuid);

     ballMarkerLoad();

    makerUserInfo =
        await _fUserRepository.getUserInfoSimple1(FUserReqDto(fBallResDto.uid));

     replyLoad();

     loadFBallValuation();

    notifyListeners();
  }
  bool showFBallValuation(){
    GlobalModel globalModel = Provider.of(_context, listen: false);
    if(globalModel.fUserInfoDto != null){
      return true;
    }else {
      return false;
    }
  }

  Future<void> loadFBallValuation() async {
    GlobalModel globalModel = Provider.of(_context, listen: false);
    userNickName =
        globalModel.fUserInfoDto.nickName;
    FBallValuationReqDto valuationReqDto = FBallValuationReqDto();
    valuationReqDto.ballUuid = fBallResDto.ballUuid;
    valuationReqDto.uid =
        Provider.of<GlobalModel>(_context, listen: false).fUserInfoDto.uid;
    var fBallValuationWrapResDto =
        await _fBallValuationRepository.getFBallValuation(valuationReqDto);
    if (fBallValuationWrapResDto.count == 1) {
      fBallValuationResDto = fBallValuationWrapResDto.contents[0];
    }
  }

  Future<void> replyLoad() async {
    FBallReplyReqDto reqDto = new FBallReplyReqDto();
    reqDto.ballUuid = fBallResDto.ballUuid;
    reqDto.detail = false;
    reqDto.size = 3;
    reqDto.page = 0;
    if (reqDto.page == 0) {
      this.fBallReplyResWrapDto.contents.clear();
      notifyListeners();
    }
    this.fBallReplyResWrapDto =
        await _fBallReplyRepository.getFBallReply(reqDto);

    notifyListeners();
  }

  Future<void> ballMarkerLoad() async {
    this.ballList = new List<FBallResForMarkerStyle2Dto>();
    ballList.add(new FBallResForMarkerStyle2Dto(
        FBallType.IssueBall,
        LatLng(fBallResDto.latitude, fBallResDto.longitude),
        fBallResDto.ballUuid));
    Completer<Set<Marker>> _markerCompleter = Completer();
    MakerSupportStyle2(ballList, _markerCompleter).generate(_context);
    Set<Marker> markers = await _markerCompleter.future;
    this.markers.clear();
    this.markers.addAll(markers);
    googleMapDarwRader();
  }

  //Google Map에 레이더로 애니메이션을 그린다 .
  void googleMapDarwRader() {
    var circleBack = Circle(
        circleId: CircleId("raderBack"),
        zIndex: 0,
        center: LatLng(fBallResDto.latitude, fBallResDto.longitude),
        strokeWidth: 0,
        fillColor: Color(0xff39F999).withOpacity(0.17),
        radius: 200);
    circles.add(circleBack);
    googleMapCircleController.aniController.addListener(() {
      var circle1 = Circle(
          circleId: CircleId("rader1"),
          zIndex: 1,
          center: LatLng(fBallResDto.latitude, fBallResDto.longitude),
          strokeWidth: 0,
          fillColor: Color(0xff39F999).withOpacity(0.3),
          radius: googleMapCircleController.circleRadius.value);
      circles.removeWhere((value) {
        return value.circleId.value == "rader1";
      });
      circles.add(circle1);
      notifyListeners();
    });
    googleMapCircleController.aniController2.addListener(() {
      var circle2 = Circle(
          circleId: CircleId("rader2"),
          zIndex: 2,
          center: LatLng(fBallResDto.latitude, fBallResDto.longitude),
          strokeWidth: 0,
          fillColor: Color(0xff39F999).withOpacity(0.6),
          radius: googleMapCircleController.circleRadius2.value);
      circles.removeWhere((value) {
        return value.circleId.value == "rader2";
      });
      circles.add(circle2);
      notifyListeners();
    });
    googleMapCircleController.aniController.forward();
    Future.delayed(Duration(milliseconds: 500), () {
      googleMapCircleController.aniController2.forward();
    });
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
        backgroundColor: Color(0xffCCCCCC),
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
    Navigator.of(_context).pop();
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
    Navigator.of(_context).push(MaterialPageRoute(builder: (context) {
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

  void popupInputDisplay() async {
     var firebaseUser = await FirebaseAuth.instance.currentUser();
     if(firebaseUser != null ){
       ID001InputReplyViewResult result = await showGeneralDialog(
           context: _context,
           barrierDismissible: true,
           transitionDuration: Duration(milliseconds: 300),
           barrierColor: Colors.black.withOpacity(0.3),
           barrierLabel:
           MaterialLocalizations.of(_context).modalBarrierDismissLabel,
           pageBuilder:
               (_context, Animation animation, Animation secondaryAnimation) {
             FBallReplyInsertReqDto reqDto = new FBallReplyInsertReqDto();
             reqDto.ballUuid = fBallResDto.ballUuid;
             return ID001InputReplyView(reqDto);
           });
       if (result != null) {
         await replyLoad();
         mainScrollController.animateTo(
             mainScrollController.position.maxScrollExtent + 100,
             duration: Duration(milliseconds: 500),
             curve: Curves.linear);
       }
     }else {
       Navigator.push(
           _context,
           MaterialPageRoute(
               settings: RouteSettings(name: "/J001"),
               builder: (context) {
                 return J001View();
               }));
     }


  }

  void popDetailReply() async {
    await showGeneralDialog(
        context: _context,
        barrierDismissible: true,
        transitionDuration: Duration(milliseconds: 300),
        barrierColor: Colors.black.withOpacity(0.3),
        barrierLabel:
            MaterialLocalizations.of(_context).modalBarrierDismissLabel,
        pageBuilder:
            (_context, Animation animation, Animation secondaryAnimation) {
          return ID001DetailReplyView(fBallResDto.ballUuid);
        });

    await replyLoad();
    mainScrollController.animateTo(
        mainScrollController.position.maxScrollExtent + 100,
        duration: Duration(milliseconds: 500),
        curve: Curves.linear);
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
    if(fBallResDto.activationTime.isBefore(DateTime.now())){
      return ;
    }

    if (isPlusStatue()) {
      await _fBallValuationRepository
          .deleteFBallValuation(fBallValuationResDto.idx);
      fBallValuationResDto = null;
      notifyListeners();
    } else if (isMinusStatue()) {
      await _fBallValuationRepository
          .deleteFBallValuation(fBallValuationResDto.idx);

      await onFBallValuation(1);
      notifyListeners();
    } else {
      await onFBallValuation(1);
    }
    notifyListeners();
  }

  void onMinusBtn() async {
    if(fBallResDto.activationTime.isBefore(DateTime.now())){
      return ;
    }
    if (isMinusStatue()) {
      await _fBallValuationRepository
          .deleteFBallValuation(fBallValuationResDto.idx);
      fBallValuationResDto = null;
      notifyListeners();
    } else if (isPlusStatue()) {
      await _fBallValuationRepository
          .deleteFBallValuation(fBallValuationResDto.idx);

      await onFBallValuation(-1);
      notifyListeners();
    } else {
      await onFBallValuation(-1);
    }
    notifyListeners();
  }

  Future onFBallValuation(int unAndDown) async {
    FBallValuationInsertReqDto reqDto = FBallValuationInsertReqDto();
    reqDto.ballUuid = fBallResDto.ballUuid;
    reqDto.uid =
        Provider.of<GlobalModel>(_context, listen: false).fUserInfoDto.uid;
    reqDto.unAndDown = unAndDown;
    var idx = await _fBallValuationRepository.insertFBallValuation(reqDto);
    if (idx >= 0) {
      fBallValuationResDto = FBallValuationResDto();
      fBallValuationResDto.uid = reqDto.uid;
      fBallValuationResDto.ballUuid = fBallResDto.ballUuid;
      fBallValuationResDto.upAndDown = unAndDown;
      fBallValuationResDto.idx = idx;
    } else {
      fBallValuationResDto = null;
    }
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
}

enum FBallValuationState { Like, DisLike }
