import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallType.dart';
import 'package:forutonafront/FBall/Dto/IssueBallDescriptionDto.dart';
import 'package:forutonafront/FBall/MarkerSupport/Style2/FBallResForMarkerStyle2Dto.dart';
import 'package:forutonafront/FBall/MarkerSupport/Style2/MakerSupportStyle2.dart';
import 'package:forutonafront/FBall/Widget/BallSupport/BallImageViwer.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserReqDto.dart';
import 'package:forutonafront/ForutonaUser/Repository/FUserRepository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ID001MainPageViewModel extends ChangeNotifier {
  final BuildContext _context;
  FUserRepository _fUserRepository = new FUserRepository();

  GlobalKey makerAnimationKey = new GlobalKey();

  List<FBallResForMarkerStyle2Dto> ballList;
  IssueBallDescriptionDto issueBallDescriptionDto;
  CameraPosition initialCameraPosition;
  Set<Marker> markers = Set<Marker>();
  final FBallResDto fBallResDto;
  bool showMoreDetailFlag = false;
  FUserInfoResDto makerUserInfo;

  ScrollController mainScrollController = new ScrollController();

  //볼에 레이더 애니메이션을 주기위한 Ticker
  Ticker _ticker;

  ID001MainPageViewModel(this._context, this.fBallResDto) {
    initialCameraPosition = CameraPosition(
        target: LatLng(fBallResDto.latitude, fBallResDto.longitude),
        zoom: 14.425);
    issueBallDescriptionDto =
        IssueBallDescriptionDto.fromJson(json.decode(fBallResDto.description));

    init();
  }

  init() async {
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
    _ticker = Ticker(onTickerDrawBall);
    //개발중에는 애니메이션 효과 줄시 너무 느리므로 끔.
//    _ticker.start();
    makerUserInfo =
        await _fUserRepository.getUserInfoSimple1(FUserReqDto(fBallResDto.uid));

    notifyListeners();
  }

  ImageProvider getMakerUserImage() {
    if (makerUserInfo != null && makerUserInfo.profilePictureUrl.length != 0) {
      return NetworkImage(makerUserInfo.profilePictureUrl);
    } else {
      return AssetImage("assets/basicprofileimage.png");
    }
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
        position: LatLng(fBallResDto.latitude, fBallResDto.longitude),
        anchor: Offset(0.5, 0.5),
        zIndex: 0,
        icon: BitmapDescriptor.fromBytes(uint8BallAnimation)));
    notifyListeners();
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

  Container getImageContentBar() {
    switch (issueBallDescriptionDto.desimages.length) {
      case 0:
        {
          return Container();
        }
        break;
      case 1:
        {
          return Container(
              height: 260.00.h,
              width: 328.00.w,
              margin: EdgeInsets.only(bottom: 24.h),
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0.h),
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
            height: 260.00.h,
            width: 328.00.w,
            margin: EdgeInsets.only(bottom: 24.h),
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0.h),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    height: 260.00.h,
                    width: 162.00.w,
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
                    ),
                  ),
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 260.00.h,
                      width: 162.00.w,
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
                        ),
                      ),
                    ))
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.00),
            ),
          );
        }
        break;
      case 3:
        {
          return Container(
              height: 260.00.h,
              width: 328.00.w,
              margin: EdgeInsets.only(bottom: 24.h),
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0.h),
              child: Stack(
                children: <Widget>[
                  Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                          height: 260.00.h,
                          width: 235.00.w,
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
                  Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                          height: 128.00.h,
                          width: 89.00.w,
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
                              )))),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                          height: 128.00.h,
                          width: 89.00.w,
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
                              ),
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(12.00),
                              )))),
                ],
              ));
        }
        break;
      case 4:
        {
          return Container(
              height: 260.00.h,
              width: 328.00.w,
              margin: EdgeInsets.only(bottom: 24.h),
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0.h),
              child: Stack(
                children: <Widget>[
                  Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                          height: 260.00.h,
                          width: 235.00.w,
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
                          ))),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                          height: 84.00.h,
                          width: 89.00.w,
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
                              )))),
                  Positioned(
                      top: 88.h,
                      right: 0,
                      child: Container(
                          height: 84.00.h,
                          width: 89.00.w,
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
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                          height: 84.00.h,
                          width: 89.00.w,
                          child: FlatButton(
                            onPressed: () {
                              jumpToBallImageViewer(3);
                            },
                          ),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(issueBallDescriptionDto
                                      .desimages[3].src)),
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(12.00),
                              ))))
                ],
              ));
        }
        break;
      default:
        {
          return Container(
              height: 260.00.h,
              width: 328.00.w,
              margin: EdgeInsets.only(bottom: 24.h),
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0.h),
              child: Stack(
                children: <Widget>[
                  Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                          height: 260.00.h,
                          width: 235.00.w,
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
                          ))),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                          height: 84.00.h,
                          width: 89.00.w,
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
                              )))),
                  Positioned(
                      top: 88.h,
                      right: 0,
                      child: Container(
                          height: 84.00.h,
                          width: 89.00.w,
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
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                          height: 84.00.h,
                          width: 89.00.w,
                          child: Container(
                            height: 84.00.h,
                            width: 89.00.w,
                            child: FlatButton(
                              onPressed: (){
                                jumpToBallImageViewer(3);
                              },
                              child:Text(
                                  "더 보기 +${issueBallDescriptionDto.desimages.length - 4}",
                                  style: TextStyle(
                                    fontFamily: "Noto Sans CJK KR",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 10.sp,
                                    color: Color(0xfff2f0f1),
                                  ))
                            ),
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
                                  image: NetworkImage(issueBallDescriptionDto
                                      .desimages[3].src)),
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(12.00),
                              ))))
                ],
              ));
        }
        break;
    }
  }
}
