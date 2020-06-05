import 'package:firebase_auth/firebase_auth.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/FBall/Data/Entity/FBall.dart';
import 'package:forutonafront/FBall/Dto/FBallInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallJoinReqDto.dart';
import 'package:meta/meta.dart';
import 'package:forutonafront/FBall/Dto/FBallReqDto.dart';

abstract class IssueBallTypeRemoteDateSource {
  Future<int> deleteBall({@required FBallReqDto reqDto,@required FDio fDio});
  Future<int> insertBall({@required FBallInsertReqDto reqDto,@required FDio fDio});
  Future<FBall> selectBall({@required  FBallReqDto reqDto,@required FDio fDio});
  Future<int> updateBall({@required FBallInsertReqDto reqDto,@required FDio fDio});
  Future<int> joinBall({@required FBallJoinReqDto reqDto,@required FDio fDio});
  Future<int> ballHit({@required FBallReqDto reqDto,@required FDio noneTokenFDio});
}
class IssueBallTypeRemoteDateSourceImpl implements IssueBallTypeRemoteDateSource{

  IssueBallTypeRemoteDateSourceImpl();

  @override
  Future<int> ballHit({@required  FBallReqDto reqDto,@required FDio noneTokenFDio}) async {
    var response = await noneTokenFDio.post("/v1/FBall/Issue/BallHit",data: reqDto.toJson());
    return int.parse(response.data);
  }

  @override
  Future<int> deleteBall({@required FBallReqDto reqDto,@required FDio fDio}) async {
    var response = await fDio.delete("/v1/FBall/Issue/Delete",queryParameters: reqDto.toJson());
    return int.parse(response.data);
  }

  @override
  Future<int> insertBall({@required FBallInsertReqDto reqDto,@required FDio fDio}) async {
    var response = await fDio.post("/v1/FBall/Issue/Insert",data: reqDto.toJson());
    return int.parse(response.data);
  }

  @override
  Future<int> joinBall({@required FBallJoinReqDto reqDto,@required FDio fDio})async {
      var response = await fDio.post("/v1/FBall/Issue/Join",data: reqDto.toJson());
      return int.parse(response.data);
    }

  @override
  Future<FBall> selectBall({@required FBallReqDto reqDto,@required FDio fDio}) async {
    var response = await fDio.post("/v1/FBall/Issue/Select",queryParameters: reqDto.toJson());
    return FBall.fromJson(response.data);
  }

  @override
  Future<int> updateBall({@required FBallInsertReqDto reqDto,@required FDio fDio}) async {
    var response = await fDio.put("/v1/FBall/Issue/Update",data: reqDto.toJson());
    return int.parse(response.data);
  }
}


