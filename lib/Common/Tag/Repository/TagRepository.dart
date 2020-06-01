import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/Common/Geolocation/DistanceDisplayUtil.dart';
import 'file:///C:/workproject/FlutterPro/forutonafront/lib/Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCase.dart';
import 'package:forutonafront/Common/Tag/Dto/TagFromBallReqDto.dart';
import 'package:forutonafront/Common/Tag/Dto/TagRankingReqDto.dart';
import 'package:forutonafront/Common/Tag/Dto/TagRankingWrapDto.dart';
import 'package:forutonafront/Common/Tag/Dto/TagResDtoWrap.dart';
import 'package:forutonafront/Common/Tag/Dto/TagSearchFromTextReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallListUpWrapDto.dart';
import 'package:geolocator/geolocator.dart';

class TagRepository {

  Future<TagRankingWrapDto> getTagRanking(TagRankingReqDto reqDto) async {
    FDio dio = new FDio("nonetoken");
    var response = await dio.get("/v1/FTag/Ranking",
        queryParameters: reqDto.toJson()
    );
    return TagRankingWrapDto.fromJson(response.data);
  }

  Future<FBallListUpWrapDto> tagSearchFromTextToBalls(TagSearchFromTextReqDto reqDto)async {
    FDio dio = new FDio("nonetoken");
    var response =
    await dio.get("/v1/FTag/tagSearchFromTextToBalls", queryParameters: reqDto.toJson());
    var fBallListUpWrapDto = FBallListUpWrapDto.fromJson(response.data);
    var position = await  GeoLocationUtilUseCase().getCurrentWithLastPosition();
    for (var ball in fBallListUpWrapDto.balls) {
//      ball.distanceWithMapCenter = await Geolocator().distanceBetween(
//          ball.latitude, ball.longitude, position.latitude, position.longitude);
//      ball.distanceDisplayText = DistanceDisplayUtil.changeDisplayStr(ball.distanceWithMapCenter);
    }
    return fBallListUpWrapDto;
  }

  Future<TagRankingWrapDto> tagSearchFromTextToTagRankings(TagSearchFromTextReqDto reqDto) async {
    FDio dio = new FDio("nonetoken");
    var response =
    await dio.get("/v1/FTag/tagSearchFromTextToTagRankings", queryParameters: reqDto.toJson());
    var tagRankingWrapDto = TagRankingWrapDto.fromJson(response.data);
    return tagRankingWrapDto;
  }

  Future<TagResDtoWrap> tagFromBallUuid(TagFromBallReqDto reqDto)async {
    FDio dio = new FDio("nonetoken");
    var response = await dio.get("/v1/FTag/tagFromBallUuid",queryParameters:reqDto.toJson());
    return TagResDtoWrap.fromJson(response.data);
  }
}