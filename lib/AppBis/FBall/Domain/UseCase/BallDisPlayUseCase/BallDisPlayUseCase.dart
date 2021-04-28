import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forutonafront/Common/Geolocation/Adapter/GeolocatorAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/DistanceDisplayUtil.dart';
import 'package:forutonafront/Common/TimeUitl/TimeDisplayUtil.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Value/BallDescription.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallDesImagesDto.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/Page/ICodePage/IM001/Component/BallImageEdit/BallImageItem.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BallDisPlayUseCase {
  FBallResDto? fBallResDto;
  BallDescription? ballDescription;
  GeolocatorAdapter? geoLocatorAdapter;

  BallDisPlayUseCase(
      this.fBallResDto, this.ballDescription, this.geoLocatorAdapter);

  String remainTime() {
    return TimeDisplayUtil.getCalcToStrFromNow(fBallResDto!.activationTime!);
  }

  String ballUuid(){
    if (fBallResDto!.ballDeleteFlag) {
      return "-";
    } else {
      return fBallResDto!.ballUuid.toString();
    }
  }

  String ballLikes() {
    if (fBallResDto!.ballDeleteFlag) {
      return "-";
    } else {
      return fBallResDto!.ballLikes.toString();
    }
  }

  String ballPower() {
    if (fBallResDto!.ballDeleteFlag) {
      return "-";
    } else {
      return fBallResDto!.ballPower.toString();
    }
  }

  String ballDisLikes() {
    if (fBallResDto!.ballDeleteFlag) {
      return "-";
    } else {
      return fBallResDto!.ballDisLikes.toString();
    }
  }

  String commentCount() {
    if (fBallResDto!.ballDeleteFlag) {
      return "-";
    } else {
      return fBallResDto!.commentCount.toString();
    }
  }

  String? profilePictureUrl() {
    if (fBallResDto!.ballDeleteFlag) {
      return "";
    } else {
      if(fBallResDto!.uid!.profilePictureUrl != null && fBallResDto!.uid!.profilePictureUrl!.isNotEmpty){
        return fBallResDto!.uid!.profilePictureUrl;
      }else {
        return "";
      }
    }
  }

  Container _basicProfileImageWidget() {
    return Container(
      width: 30,
      height: 30,
      child: SvgPicture.asset("assets/IconImage/user-circle.svg"),
      decoration: BoxDecoration(
        shape: BoxShape.circle
      ),
    );
  }

  String ballName() {
    if (fBallResDto!.ballDeleteFlag) {
      return "-";
    } else {
      return fBallResDto!.ballName!;
    }
  }

  String placeAddress() {
    if (fBallResDto!.ballDeleteFlag) {
      return "-";
    } else {
      return fBallResDto!.placeAddress!;
    }
  }

  bool isAlive() {
    if (fBallResDto!.activationTime!.isAfter(DateTime.now())) {
      return true;
    } else {
      return false;
    }
  }

  String ballHits() {
    if (fBallResDto!.ballDeleteFlag!) {
      return "-";
    } else {
      return fBallResDto!.ballHits.toString();
    }
  }

  String displayMakeTime() {
    if (fBallResDto!.ballDeleteFlag!) {
      return "-";
    } else {
      return TimeDisplayUtil.getCalcToStrFromNow(fBallResDto!.makeTime!);
    }
  }

  String? makerNickName({int maxLength = -1}) {
    if (fBallResDto!.ballDeleteFlag!) {
      return "-";
    } else {
      if (maxLength != -1) {
        if (fBallResDto!.uid!.nickName!.length >= maxLength) {
          String result = fBallResDto!.uid!.nickName!.substring(0, maxLength - 3);
          return result + "...";
        }
      }
      return fBallResDto!.uid!.nickName;
    }
  }

  String makerFollower() {
    if (fBallResDto!.ballDeleteFlag!) {
      return "-";
    } else {
      return fBallResDto!.uid!.followerCount.toString();
    }
  }

  String makerInfluencePower() {
    if (fBallResDto!.ballDeleteFlag!) {
      return "-";
    } else {
      return fBallResDto!.uid!.cumulativeInfluence.toString();
    }
  }

  bool isMainPicture() {
    if (fBallResDto!.ballDeleteFlag! || ballDescription!.desimages == null) {
      return false;
    } else {
      return ballDescription!.desimages.length > 0;
    }
  }

  String? mainPictureSrc() {
    if (fBallResDto!.ballDeleteFlag!) {
      return null;
    } else {
      return ballDescription!.desimages[0].src;
    }
  }

  int pictureCount() {
    if (fBallResDto!.ballDeleteFlag!) {
      return 0;
    } else {
      return ballDescription!.desimages.length;
    }
  }

  List<BallImageItem> getDesImages() {
    if (fBallResDto!.ballDeleteFlag!) {
      return [];
    } else {
      var list = ballDescription!.desimages.map((e) {
        var imageItem =  BallImageItem(sl());
        imageItem.addImage( imageProvider: NetworkImage(e.src!));
        return imageItem;
      }).toList();
      return list;
    }
  }

  String descriptionText() {
    if (fBallResDto!.ballDeleteFlag! || ballDescription!.text == null) {
      return "";
    } else {
      return ballDescription!.text!;
    }
  }

  getYoutubeId() {
    if (fBallResDto!.ballDeleteFlag!) {
      return "";
    } else {
      if (ballDescription!.youtubeVideoId != null) {
        return ballDescription!.youtubeVideoId;
      } else {
        return "";
      }
    }
  }

  getDistanceFromSearchPositionToText(Position ballSearchPosition,
      BallDisPlayUseCaseOutputPort outputPort) async {
    if (fBallResDto!.ballDeleteFlag!) {
      return "";
    } else {
      Position ballPosition = Position(
          longitude: fBallResDto!.longitude, latitude: fBallResDto!.latitude);
      var distance = geoLocatorAdapter!.distanceBetween(
          ballPosition.latitude!,
          ballPosition.longitude!,
          ballSearchPosition.latitude!,
          ballSearchPosition.longitude!);
      outputPort.distanceFromSearchPositionToText(
          DistanceDisplayUtil.changeDisplayStr(distance));
    }
  }
}

abstract class BallDisPlayUseCaseOutputPort {
  distanceFromSearchPositionToText(String distanceText);
}
