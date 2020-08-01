import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/FBall/Dto/FBallPlayerResDto.dart';

abstract class FBallPlayerRemoteDataSource {
  Future<PageWrap<FBallPlayerResDto>> getUserPlayBallList(
      {@required String playerUid,
      @required Pageable pageable,
      @required FDio noneTokenFDio});
}

class FBallPlayerRemoteDataSourceImpl implements FBallPlayerRemoteDataSource {
  @override
  Future<PageWrap<FBallPlayerResDto>> getUserPlayBallList(
      {@required String playerUid,
        @required Pageable pageable,
        @required FDio noneTokenFDio}) async {
    Map<String,dynamic> jsonReq = Map<String,dynamic>();
    jsonReq["playerUid"] = playerUid;
    jsonReq.addAll(pageable.toJson());
    var response = await noneTokenFDio.get("/v1/FBallPlayer/UserToPlayBallList",
        queryParameters: jsonReq);
    return PageWrap<FBallPlayerResDto>.fromJson(response.data, FBallPlayerResDto.fromJson);
  }
}
