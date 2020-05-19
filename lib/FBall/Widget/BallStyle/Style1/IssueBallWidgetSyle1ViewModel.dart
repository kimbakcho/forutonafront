import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/DistanceDisplayUtil.dart';
import 'package:forutonafront/FBall/Dto/FBallDescirptionBasic.dart';
import 'package:forutonafront/FBall/Dto/FBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallType.dart';
import 'package:forutonafront/FBall/Repository/FBallTypeRepository.dart';
import 'package:forutonafront/ICodePage/ID001/ID001MainPage.dart';
import 'package:geolocator/geolocator.dart';

class IssueBallWidgetSyle1ViewModel extends ChangeNotifier {
  final BuildContext _context;
  FBallResDto ballResDto;
  FBallDescirptionBasic fBallDescriptionBasic;

  //Loading
  bool _isLoading = false;

  getIsLoading() {
    return _isLoading;
  }

  _setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  IssueBallWidgetSyle1ViewModel(this.ballResDto, this._context) {
    this.fBallDescriptionBasic = FBallDescirptionBasic.fromJson(
        json.decode(this.ballResDto.description));
  }

  bool isAliveBall() {
    return this.ballResDto.activationTime.isAfter(DateTime.now());
  }

  @override
  void dispose() {
    super.dispose();
  }

  isMainPicture() {
    if (fBallDescriptionBasic.desimages.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  String mainPictureSrc() {
    if (isMainPicture()) {
      return fBallDescriptionBasic.desimages[0].src;
    } else {
      return null;
    }
  }

  int getPicktureCount() {
    return fBallDescriptionBasic.desimages.length;
  }

  void goIssueDetailPage() async {
    await Navigator.of(_context)
        .push(MaterialPageRoute(builder: (_) => ID001MainPage(ballResDto)));
    _setIsLoading(true);
    var fBallTypeRepository = FBallTypeRepository.create(FBallType.IssueBall);
    this.ballResDto = await fBallTypeRepository
        .selectBall(FBallReqDto(FBallType.IssueBall, ballResDto.ballUuid));
    var position = await Geolocator().getLastKnownPosition();

    this.ballResDto.distanceWithMapCenter = await Geolocator().distanceBetween(
        this.ballResDto.latitude,
        this.ballResDto.longitude,
        position.latitude,
        position.longitude);

    this.ballResDto.distanceDisplayText = DistanceDisplayUtil.changeDisplayStr(
        this.ballResDto.distanceWithMapCenter);

    this.fBallDescriptionBasic = FBallDescirptionBasic.fromJson(
        json.decode(this.ballResDto.description));
    _setIsLoading(false);
  }
}
